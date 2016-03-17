/******** GEE macro *********/

libname out1 'F:\CSPH_Projects\IRB2015P000341_PreventativeServicesInUS\Prjct_PreventativeServicesUseInUSFollowingACA\WorkFldr_CMeyer(CZ551)\meps data cut1';
libname meps 'F:\CSPH_Projects\IRB2015P000341_PreventativeServicesInUS\Prjct_PreventativeServicesUseInUSFollowingACA\WorkFldr_CMeyer(CZ551)\meps data cut2';
options nofmterr;

/******** outpocket *********/

%macro cohort(type);

TITLE "Dummy variable &type data set";
data meps.dummy_outpocket_&type;
set meps.cost_outpocket_&type;

        /* dummy variables*/
        if aca_cat_of = 2 then aca = 1; /*post*/
        else if aca_cat_of = 1 then aca = 0; /* pre*/

        if agecat = 3 then age_final = 1;
        else if agecat = 2 then age_final = 0;

        if newrace = 5 then race5 = 1;
        else race5 = 0;

        if newrace = 4 then race4 = 1;
        else race4 = 0;

        if newrace = 3 then race3 = 1;
        else race3 = 0;

        if newrace = 2 then race2 = 1;
        else race2 = 0;

        if lang = 2 then lan = 1;
        else if lang = 1 then lan = 0;

        if haveus = 2 then us = 1;
        else if haveus = 1 then us = 0;

        if insur = 2 then ins = 1;
        else if insur = 1 then ins = 0;

        if empsta = 2 then emp = 1;
        else if empsta = 1 then emp = 0;

        if higheduc = 2 then educ = 1;
        else if higheduc = 1 then educ = 0;

        RUN;

TITLE "Glimmix &type for gllimix";
        PROC GLIMMIX DATA=meps.dummy_outpocket_&type;
        _variance_ = _mu_ ** 2;
        MODEL outpocket = aca age_final race5 race4 race3 race2 lan us ins emp educ / LINK = log S;
		WEIGHT perwtf;
        RANDOM _residual_; /* adds scale parameter to variance */
        OUTPUT OUT = meps.output_outpocket_&type PRED = _xb_;
        RUN;

TITLE "intercept trick for &type";
        data meps.output_outpocket_&type;
        set meps.output_outpocket_&type meps.dummy_outpocket_&type;
        mu = exp(_xb_);
        y_ = ( _xb_ * mu + outpocket - mu )/sqrt(mu**2);
        intercep = mu/sqrt(mu**2);

        aca = aca*intercep;
        age_final = age_final*intercep;
        race5 = race5*intercep;
        race4 = race4*intercep;
        race3 = race3*intercep;
        race2 = race2*intercep;
        lan = lan*intercep;
        us = us*intercep;
        ins = ins*intercep;
        emp= emp*intercep;
        educ = educ*intercep;

        RUN;

TITLE "GEE estimate outpatient under cluster sampling and strata for &type";
        PROC SURVEYREG data=meps.output_outpocket_&type;
        STRATUM varstr;
        CLUSTER varpsu;
        WEIGHT perwtf;
        MODEL y_ = intercep aca age_final race5 race4 race3 race2 lan us ins emp educ/noint CLPARM solution;
		LSMEANS aca / diff cl;
		ODS output ParameterEstimates = MyParamEst;
        RUN;


ods pdf body='F:\CSPH_Projects\IRB2015P000341_PreventativeServicesInUS\Prjct_PreventativeServicesUseInUSFollowingACA\WorkFldr_CMeyer(CZ551)\Cost_outpatient.pdf';

proc print data = MyParamEst;
run;

ods pdf close;

%mend;
%cohort(breast); %cohort(cervical); %cohort(prostate); %cohort(colon);

/******** outpatient *********/

%macro cohort(type);

TITLE "Dummy variable &type data set";
data meps.dummy_outpatient_&type;
set meps.cost_outpatient_&type;

        /* dummy variables*/
        if aca_cat_pat = 2 then aca = 1; /*post*/
        else if aca_cat_pat = 1 then aca = 0; /* pre*/

        if agecat = 3 then age_final = 1;
        else if agecat = 2 then age_final = 0;

        if newrace = 5 then race5 = 1;
        else race5 = 0;

        if newrace = 4 then race4 = 1;
        else race4 = 0;

        if newrace = 3 then race3 = 1;
        else race3 = 0;

        if newrace = 2 then race2 = 1;
        else race2 = 0;

        if lang = 2 then lan = 1;
        else if lang = 1 then lan = 0;

        if haveus = 2 then us = 1;
        else if haveus = 1 then us = 0;

        if insur = 2 then ins = 1;
        else if insur = 1 then ins = 0;

        if empsta = 2 then emp = 1;
        else if empsta = 1 then emp = 0;

        if higheduc = 2 then educ = 1;
        else if higheduc = 1 then educ = 0;

        RUN;

TITLE "Glimmix &type for gllimix";
        PROC GLIMMIX DATA=meps.dummy_outpatient_&type;
        _variance_ = _mu_ ** 2;
        MODEL outpatient = aca age_final race5 race4 race3 race2 lan us ins emp educ / LINK = log S;
		WEIGHT perwtf;
        RANDOM _residual_; /* adds scale parameter to variance */
        OUTPUT OUT = meps.output_outpatient_&type PRED = _xb_;
        RUN;

TITLE "intercept trick for &type";
        data meps.output_outpatient_&type;
        set meps.output_outpatient_&type meps.dummy_outpatient_&type;
        mu = exp(_xb_);
        y_ = ( _xb_ * mu + outpatient - mu )/sqrt(mu**2);
        intercep = mu/sqrt(mu**2);

        aca = aca*intercep;
        age_final = age_final*intercep;
        race5 = race5*intercep;
        race4 = race4*intercep;
        race3 = race3*intercep;
        race2 = race2*intercep;
        lan = lan*intercep;
        us = us*intercep;
        ins = ins*intercep;
        emp= emp*intercep;
        educ = educ*intercep;

        RUN;

TITLE "GEE estimate outpatient under cluster sampling and strata for &type";
        PROC SURVEYREG data=meps.output_outpatient_&type;
        STRATUM varstr;
        CLUSTER varpsu;
        WEIGHT perwtf;
        MODEL y_ = intercep aca age_final race5 race4 race3 race2 lan us ins emp educ/noint CLPARM solution;
		ODS output ParameterEstimates = MyParamEst;
        RUN;

ods pdf body='F:\CSPH_Projects\IRB2015P000341_PreventativeServicesInUS\Prjct_PreventativeServicesUseInUSFollowingACA\WorkFldr_CMeyer(CZ551)\Cost_outpatient.pdf';

proc print data = MyParamEst;
run;

ods pdf close;

%mend;
%cohort(breast); %cohort(cervical); %cohort(prostate); %cohort(colon);
