/* Data cutting into the outpocket/outpatient + screening cohorts */

libname out1 'F:\CSPH_Projects\IRB2015P000341_PreventativeServicesInUS\Prjct_PreventativeServicesUseInUSFollowingACA\WorkFldr_CMeyer(CZ551)\meps data cut1';
libname meps 'F:\CSPH_Projects\IRB2015P000341_PreventativeServicesInUS\Prjct_PreventativeServicesUseInUSFollowingACA\WorkFldr_CMeyer(CZ551)\meps data cut2';
options nofmterr;

/*** Run these code scripts one at a time to run out of pocket and out
of patient analysis ***/

/* 1 */
/* Data cutting for out of office out of pocket costs */
data meps.costs_outpocket_pre; /*pre aca*/
set OUT1.OFFICE_2009 (keep = OBSF09X PID);
status='Pre';
year = '2009';
ACA_CAT_OF = 1;
outpocket = OBSF09X;
run;

data meps.costs_outpocket_post; /*post aca*/
set OUT1.OFFICE_2011 (keep = OBSF11X PID)
OUT1.OFFICE_2012 (keep = OBSF12X PID);
status='Post';
ACA_CAT_OF = 2;
if OBSF11X ne . then outpocket = OBSF11X ;
else outpocket = OBSF12X;
if OBSF11X ne . then year = '2011';
if OBSF12X ne . then year = '2012';
run;

data meps.cost_outpocket_all;
set meps.costs_outpocket_pre meps.costs_outpocket_post;
if outpocket = 0 then POP_ZERO = 0;
if outpocket > 0 then POP_ZERO = 1;
if outpocket < 0 then inapp = 1;
if outpocket >= 0 then inapp = 0;
if outpocket = 0 then outpocket_5 = 0.5;
else if outpocket > 0 then outpocket_5 = outpocket; 
keep pid status outpocket ACA_CAT_OF POP_ZERO year inapp outpocket_5;
run;

/* 2 */
/* Data cutting for out patient costs */
data meps.costs_outpatient_pre; /*pre aca*/
set OUT1.OUTPATIENT_2009 (keep = OPXP09X PID);
status='Pre';
year = '2009';
ACA_CAT_PAT = 1;
outpatient = OPXP09X;
run;

data meps.costs_outpatient_post; /*pre post*/
set OUT1.OUTPATIENT_2011 (keep = OPXP11X PID)
OUT1.OUTPATIENT_2012 (keep= OPXP12X PID);
status='Post';
ACA_CAT_PAT = 2;
if OPXP11X ne . then outpatient = OPXP11X ;
else outpatient = OPXP12X;
if OPXP11x ne . then year = '2011';
if OPXP12x ne . then year = '2012';
run;

data meps.cost_outpatient_all;
set meps.costs_outpatient_pre meps.costs_outpatient_post;
if outpatient = 0 then POP_ZERO = 0;
if outpatient > 0 then POP_ZERO = 1;
if outpatient < 0 then inapp = 1;
if outpatient >= 0 then inapp = 0;
if outpatient = 0 then outpatient_5 = 0.5;
else if outpatient > 0 then outpatient_5 = outpatient; 
keep pid status outpatient ACA_CAT_PAT POP_ZERO inapp year outpatient_5;
run;

/* 3 */
/* Data cutting for out of office out of pocket costs for mammography */
data meps.costsMAMPRE; /*pre aca*/
set OUT1.OFFICE_2009  (keep = OBSF09X MAMMOG PID);
status='Pre';
ACA_CAT_OF=1;
outpocket = OBSF09X;
run;

data meps.costsMAMPOST; /*post aca*/
set OUT1.OFFICE_2011 (keep = OBSF11X MAMMOG PID)
OUT1.OFFICE_2012 (keep = OBSF12X MAMMOG PID);
status='Post';
ACA_CAT_OF=2;
if OBSF11X ne . then outpocket=OBSF11X ;
else outpocket= OBSF12X;
run;

data meps.cost_outpocket_mammo;
set meps.costsMAMPRE meps.costsMAMPOST;
if outpocket = 0 then POP_ZERO = 0;
if outpocket > 0 then POP_ZERO = 1;
if outpocket < 0 then inapp = 1;
if outpocket >= 0 then inapp = 0;
keep pid status outpocket logoutpocket ACA_CAT_OF POP_ZERO inapp MAMMOG;
run;

/* 4 */
/* Data cutting for out of office out of patient costs for mammography */
data meps.costsMAMPRE; /*pre aca*/
set OUT1.OUTPATIENT_2009 (keep = OPXP09X MAMMOG PID);
status='Pre';
ACA_CAT_PAT=1;
outpatient = OPXP09X;
run;

data meps.costsMAMPOST; /*post aca*/
set OUT1.OUTPATIENT_2011 (keep = OPXP11X MAMMOG PID)
OUT1.OUTPATIENT_2012 (keep = OPXP12X MAMMOG PID);
status='Post';
ACA_CAT_PAT=2;
if OPXP11X ne . then outpatient=OPXP11X;
else outpatient = OPXP12X;
run;

data meps.cost_outpatient_mammo;
set meps.costsMAMPRE meps.costsMAMPOST;
if outpatient = 0 then POP_ZERO = 0;
if outpatient > 0 then POP_ZERO = 1;
if outpatient < 0 then inapp = 1;
if outpatient >= 0 then inapp = 0;
keep pid status outpatient logoutpatient ACA_CAT_PAT POP_ZERO inapp MAMMOG;
run;

/***************** Cohort matching with screening *********************/

/***merging with cohorts outpocket*/

%macro cohort(type);

data meps.&type;
set out1.&type;
pidc= substr(DUPERSID,6,3);
pid=input(pidc,best9.);
run;

proc sort data = meps.&type;
by pid;
run;

proc sort data = meps.cost_outpocket_all;
by pid;
run;

data meps.cost_outpocket_&type;
merge meps.cost_outpocket_all meps.&type (in=a);
by pid;
if a;
run;

%mend;
%cohort(breast);  %cohort(prostate); %cohort(colon);  %cohort(cervical);

/***merging with cohorts outpatient*/

%macro cohort(type);

data meps.&type;
set out1.&type;
pidc= substr(DUPERSID,6,3);
pid=input(pidc,best9.);
run;

proc sort data = meps.&type;
by pid;
run;

proc sort data = meps.cost_outpatient_all;
by pid;
run;

data meps.cost_outpatient_&type;
merge meps.cost_outpatient_all meps.&type (in=a);
by pid;
if a;
run;

%mend;
%cohort(breast);  %cohort(prostate); %cohort(colon);  %cohort(cervical);

/***merging with cohorts MAMMO outpocket*/

%macro cohort(type);

data meps.&type;
set out1.&type;
pidc= substr(DUPERSID,6,3);
pid=input(pidc,best9.);
run;

proc sort data = meps.&type;
by pid;
run;

proc sort data = meps.cost_outpocket_mammo;
by pid;
run;

data meps.cost_outpocket_mammo_&type;
merge meps.cost_outpocket_mammo meps.&type (in=a);
by pid;
if a;
run;

%mend;
%cohort(breast);  %cohort(prostate); %cohort(colon);  %cohort(cervical);

/***merging with cohorts MAMMO outpatient*/

%macro cohort(type);

data meps.&type;
set out1.&type;
pidc= substr(DUPERSID,6,3);
pid=input(pidc,best9.);
run;

proc sort data = meps.&type;
by pid;
run;

proc sort data = meps.cost_outpatient_mammo;
by pid;
run;

data meps.cost_outpatient_mammo_&type;
merge meps.cost_outpatient_mammo meps.&type (in=a);
by pid;
if a;
run;

%mend;
%cohort(breast);  %cohort(prostate); %cohort(colon);  %cohort(cervical);


/* Contents (checking) for each cohort */

%macro cohort(type);

title "Variable check in cost outpocket" (nobs = 25);
proc print data = meps.cost_outpocket_&type;
run;

title "Variable check in cost outpatient";
proc print data = meps.cost_outpatient_&type (nobs = 25);
run;

%mend;
%cohort(breast);  %cohort(prostate); %cohort(colon);  %cohort(cervical);
