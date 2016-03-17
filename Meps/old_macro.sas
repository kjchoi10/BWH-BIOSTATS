/* OLD MACRO FOR REGRESSION by Gally R*/
%macro blah(type);

 TITLE " &Type expences - Pre ACA Out-Patient Costs, Descriptive Statistics";
        PROC SURVEYMEANS DATA=meps.cost_&type MEAN STDERR median quartiles NOBS;
        CLASS ACA_CAT_PAT;
        STRATA VARSTR ;
        CLUSTER VARPSU;
        WEIGHT PERWTF;
        VAR logoutpatient;
        DOMAIN ACA_CAT_PAT;
        RUN;

/* Wilcoxon Scores (Rank Sums)  */
TITLE " &Type expences - Pre ACA Out-Patient Costs, Wilcoxon";
        PROC npar1way data=meps.cost_&type wilcoxon;
        CLASS ACA_CAT_PAT;
        VAR logoutpatient;
        RUN;

/* */
TITLE " &Type expences out patient - Pre ACA Out-Patient Costs, Regression";
        PROC SURVEYreg DATA=meps.cost_&type;
        WEIGHT PERWTF;
        CLUSTER VARPSU;
        STRATA VARSTR;
        CLASS ACA_CAT_PAT AGECAT NEWRACE HIGHEDUC LANG HAVEUS INSUR EMPSTA;
        model logoutpatient = ACA_CAT_PAT AGECAT NEWRACE HIGHEDUC LANG HAVEUS INSUR EMPSTA /CLPARM SOLUTION;
        WHERE HAVEUS in (1,2);
        FORMAT MAMOGR53 TestDone. AGECAT AGECAT. NEWRACE RACEF. HIGHEDUC EDUCF. LANG LANGHM. HAVEUS YESNO. POVCAT09 povcat9h. INSUR YESNO. EMPSTA EMPSTCAT. STUDENT STUDENTCAT.;
        RUN;

%mend;
%blah(breast);  %blah(prostate); %blah(colon);  %blah(Cervical);
