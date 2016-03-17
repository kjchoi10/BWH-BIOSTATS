*****************************************************
*** Kevin Choi SAS 9.4 BWH 6/16/15
*** David Friedlander's project using HINTS4 Cycle 3;

***********************
* Library named HINTS4;

libname HINTS4 '/folders/myfolders/all_SAS_data/dataset/hints/HINTS4-Cycle3-SAS/SAS/';
options fmtsearch = (hintsf);
ODS trace on; /* gives you table presentation options, type off if you want to take iff off */

***************************************************************************************************
*** Construct clean dataset includes age 40-75 and excludes patietns that have had Prostate Cancer;

data HINTS4_CYCLECLEAN;
set HINTS4.hints4cycle3_public;

		*******************************
		** Table Cohorts;
		
		/* Age specifications */
		if Age >= 40;
		if Age <= 75;

		/* Disclude Prostate cancer patients */
		if CaProstate^=1;
		
		/* Gender */
		if SelfGender=1;

		**********************
		** Response variables;
		
		/* EverHadPSATest */
		if EverHadPSATest=1 then _EverHadPSATest=1;
		else if EverHadPSATest=2 then _EverHadPSATest=2;
		else _EverHadPSATest=.;
		
		/* DrShouldPSATest */
		if DrShouldPSATest=1 then _DrShouldPSATest=1;
		else if DrShouldPSATest=2 then _DrShouldPSATest=2;
		else _DrShouldPSATest=.;
		
		/* SomeDisagreePSATests */
		if SomeDisagreePSATests=1 then _SomeDisagreePSATests=1;
		else if SomeDisagreePSATests=2 then _SomeDisagreePSATests=2;
		else _SomeDisagreePSATests=.;
		
		/* ProstateCa_PSATest */
		if ProstateCa_PSATest=1 then _ProstateCa_PSATest=1;
		else if ProstateCa_PSATest=2 then _ProstateCa_PSATest=2;
		else _ProstateCa_PSATest=.;
		
		/* ProstateCa_SlowGrowing */
		if ProstateCa_SlowGrowing=1 then _ProstateCa_SlowGrowing=1;
		else if ProstateCa_SlowGrowing=2 then _ProstateCa_SlowGrowing=2;
		else _ProstateCa_SlowGrowing=.;	
		
		/* ProstateCa_SideEffects */
		if ProstateCa_SideEffects=1 then _ProstateCa_SideEffects=1;
		else if ProstateCa_SideEffects=2 then _ProstateCa_SideEffects=2;
		else _ProstateCa_SideEffects=.;
		
		************************
		*** Covariates recoded ;
		
		/* Age */ 
		if (AGE >=40 and AGE <=49) then _Age=1;
		else if (AGE >=50 and AGE <=64) then _Age=2;
		else if (AGE >=65 and AGE <=75) then _Age=3;
		else _Age=.;		
		
		/* Race */
		if RaceEthn=2 then Race=1;
		else if RaceEthn=3 then Race=2;
		else if RaceEthn=1 then Race=3;
		else if RaceEthn=5 then Race=4;
		else if RaceEthn in (4 6 7) then Race=5;
		else Race=.;
		
		/* Occupation status */
		if OccupationStatus=1 then _OccupationStatus=1;
		else if OccupationStatus=2 then _OccupationStatus=2;
		else if OccupationStatus in (3 4 5 6 91)then _OccupationStatus=3;
		else _OccupationStatus=.;
		
		/* Education */
		if Education in (1 2) then _Education=1;
		else if Education in (3 4) then _Education=2;
		else if Education in (5 6 7) then _Education=3;
		else _Education=.;
		
		/* Health Insurance */
		if HCCoverage=1 then _HCCoverage=1;
		else if HCCoverage=2 then _HCCoverage=2;
		else _HCCoverage=.;
		
		/* Income ranges */
		if IncomeRanges in (1 2 3) then _Income=1;
		else if IncomeRanges in (4 5) then _Income=2;
		else if IncomeRanges in (6 7 8 9) then _Income=3;
		else _Income=.;	
		
		/* Marital Status */
		if MaritalStatus in (1 2) then _MaritalStatus=1;
		else if MaritalStatus=3 then _MaritalStatus=2;
		else if MaritalStatus in (4 5 6) then _MaritalStatus=3;
		else _MaritalStatus=.;

		/* RUC2003 */
		if RUC2003 in (1 2 3) then _RUC2003=1;
		else _RUC2003=2;
		
		/* EverHadCancer */
		if EverHadCancer=1 then _EverHadCancer=1;
		else if EverHadCancer=2 then _EverHadCancer=2;
		else _EverHadCancer=.;
		
		/* RegularProvider */
		if RegularProvider=-9 then RegularProvider=.;
		
		/* HCCoverage Coded with 1 and 2 (Yes and No) */
		
		/* uncomment to use this HCCoverage code
		
		if (HCCoverage_Insurance=1 or HCCoverage_Private=1 or HCCoverage_Medicare=1 or HCCoverage_Medicaid=1
		or HCCoverage_VA=1 or HCCoverage_Tricare=1 or HCCoverage_IHS=1) then HCCoverage_Type=1;
		else if (HCCoverage_Insurance=2 or HCCoverage_Private=2 or HCCoverage_Medicare=2 or HCCoverage_Medicaid=2
		or HCCoverage_VA=2 or HCCoverage_Tricare=2 or HCCoverage_IHS=2) then HCCoverage_Type=2;
		else HCCoverage=Type=.;
		
		*/
		
		/* Healthcare type */
		if (HCCoverage_Insurance=1 or HCCoverage_Private=1) then HCCoverage_Type=1;
		else if HCCoverage_Medicare=1 then HCCoverage_Type=2;
		else if HCCoverage_Medicaid=1 then HCCoverage_Type=3;
		else if (HCCoverage_VA=1 or HCCoverage_Tricare=1 or HCCoverage_IHS=1) then HCCoverage_Type=4;
		else if (HCCoverage_Insurance=2 or HCCoverage_Private=2 or HCCoverage_Medicare=2 or
		HCCoverage_Medicaid=2 or HCCoverage_VA=2 or HCCoverage_Tricare=2 or HCCoverage_IHS=2)
		then HCCoverage_Type=5;
		else HCCoverage_Type=.;
run;

*************
*** Analysis;

*****************************
*** Table 1 frequency and CT;

/* Table 1 Age */
proc surveyfreq data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;
table _Age Race _Income _Education _MaritalStatus _OccupationStatus _RUC2003 _EverHadCancer RegularProvider HCCoverage_Type;
title "Table 1 Age 40-75";
run;

/* Table 1 EverHadPSATest */
proc surveyfreq data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;
table (_Age Race _Income _Education _MaritalStatus _OccupationStatus _RUC2003 _EverHadCancer RegularProvider HCCoverage_Type)*_EverHadPSATest / chisq;
title "Table 1 EverHadPSATest: Have you ever had a PSA test?";
run;

/* Number of total observations for table 1*/
proc surveyfreq data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;
table _EverHadPSATest / chisq;
title "Table 1 EverHadPSATest: Have you ever had a PSA test?";
run;

****************************************************************
*** Table 2 multivariable logistic regression;

/* Table 2 EverHadPSA */
proc surveylogistic data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;
class _Age(ref='1') Race(ref='1') _EverHadCancer(ref='2') _Income(ref='1') _OccupationStatus(ref='1') _RUC2003(ref='2') _Education(ref='1') _MaritalStatus(ref='1') RegularProvider(ref='2') HCCoverage_Type(ref='1');
model _EverHadPSATest = _EverHadCancer _Age Race _Income _OccupationStatus _RUC2003 _Education _MaritalStatus RegularProvider HCCoverage_Type/ expb tech=newton xconv=1e-8;
title "Table 2 EverHadPSATest: Have you ever had a PSA test?";
run;

****************************************************************
*** Table 3 multivariable logistic regression;

/* Table 3 Discussed PSA */
proc surveylogistic data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;
class _Age(ref='1') Race(ref='1') _EverHadCancer(ref='2') _Income(ref='1') _OccupationStatus(ref='1') _RUC2003(ref='2') _Education(ref='1') _MaritalStatus(ref='1') RegularProvider(ref='2') HCCoverage_Type(ref='1');
model _DrShouldPSATest = _EverHadCancer _Age Race _Income _Education _MaritalStatus _OccupationStatus _RUC2003 RegularProvider HCCoverage_Type/ expb tech = newton xconv=1e-8;
title "Table 3 DrShouldPSATest: Has a doctor ever discussed with you whether or not you should have the PSA test?";
run;

/* Table 3 Experts PSA */
proc surveylogistic data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;
class _Age(ref='1') Race(ref='1') _EverHadCancer(ref='2') _Income(ref='1') _OccupationStatus(ref='1') _RUC2003(ref='2') _Education(ref='1') _MaritalStatus(ref='1') RegularProvider(ref='2') HCCoverage_Type(ref='1') HCCoverage(ref='1');
model _SomeDisagreePSATests = _EverHadCancer _Age Race _Income _Education _MaritalStatus _OccupationStatus _RUC2003 RegularProvider  HCCoverage_Type/ expb tech = newton xconv=1e-8;
title "Table 3 SomeDisagreePSATests: Did a doctor ever tell you that some experts disagree about whether men should have PSA tests?";
run;

/* Table 3 ProstateCa_SlowGrowing */
proc surveylogistic data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;
class _Age(ref='1') Race(ref='1') _EverHadCancer(ref='2') _Income(ref='1') _OccupationStatus(ref='1') _RUC2003(ref='2') _Education(ref='1') _MaritalStatus(ref='1') RegularProvider(ref='2') HCCoverage_Type(ref='1');
model _ProstateCa_SlowGrowing = _EverHadCancer _Age Race _Income _Education _MaritalStatus _OccupationStatus _RUC2003 RegularProvider HCCoverage_Type/ expb tech = newton xconv=1e-8;
title "Table 3 ProstateCa_SlowGrowing: Has a doctor or other health care professional ever told you that some types of prostate cancer are slow-growing and need no treatment?";
run;

/* Table 3 ProstateCa_SideEffects */
proc surveylogistic data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;
class _Age(ref='1') Race(ref='1') _EverHadCancer(ref='2') _Income(ref='1') _OccupationStatus(ref='1') _RUC2003(ref='2') _Education(ref='1') _MaritalStatus(ref='1') RegularProvider(ref='2') HCCoverage_Type(ref='1');
model _ProstateCa_SideEffects = _EverHadCancer _Age Race _Income _Education _MaritalStatus _OccupationStatus _RUC2003 RegularProvider HCCoverage_Type / expb tech = newton xconv=1e-8;
title "Table 3 ProstateCa_SideEffects: Has a doctor or other health care professional ever told you that treating any type of prostate cancer can lead to serious side-effects, such as problems with urination or having sex?";
run;

***********************************
*** Macro for testing interactions;

%macro interaction ( var1, ref1 ,var2, ref2, outcome );

proc surveylogistic data=HINTS4_CYCLECLEAN varmethod=jackknife;
weight PERSON_FINWT0;
repweights PERSON_FINWT1-PERSON_FINWT50 / df=49 jkcoefs=0.98;

class &var1 (ref="&ref1") &var2 (ref="&ref2");
model &outcome = &var1 &var2 &var1*&var2 / expb;

%mend;


/* _EverHadPSATest*/
%interaction ( _EverHadCancer, 2, _Age, 1, _EverHadPSATest); 
%interaction ( _EverHadCancer, 2, Race, 1, _EverHadPSATest); 
%interaction ( _EverHadCancer, 2, _Income, 1, _EverHadPSATest); 
%interaction ( _EverHadCancer, 2, _Education, 1, _EverHadPSATest); 
%interaction ( _EverHadCancer, 2, _MaritalStatus, 1, _EverHadPSATest); 
%interaction ( _EverHadCancer, 2, _OccupationStatus, 1, _EverHadPSATest); 
%interaction ( _EverHadCancer, 2, _RUC2003, 2, _EverHadPSATest); 
%interaction ( _EverHadCancer, 2, RegularProvider, 1, _EverHadPSATest); 
%interaction ( _EverHadCancer, 2, HCCoverage_Type, 1, _EverHadPSATest); 

%interaction ( _Age, 1, Race, 1, _EverHadPSATest); 
%interaction ( _Age, 1, _Income, 1, _EverHadPSATest); 
%interaction ( _Age, 1, _Education, 1, _EverHadPSATest); 
%interaction ( _Age, 1, _MaritalStatus, 1, _EverHadPSATest); 
%interaction ( _Age, 1, _OccupationStatus, 1, _EverHadPSATest); 
%interaction ( _Age, 1, _RUC2003, 2, _EverHadPSATest); 
%interaction ( _Age, 1, RegularProvider, 1, _EverHadPSATest); 
%interaction ( _Age, 1, HCCoverage_Type, 1, _EverHadPSATest); 

%interaction ( Race, 1, _Income, 1, _EverHadPSATest); 
%interaction ( Race, 1, _Education, 1, _EverHadPSATest); 
%interaction ( Race, 1, _OccupationStatus, 1, _EverHadPSATest); 
%interaction ( Race, 1, _RUC2003, 2, _EverHadPSATest); 
%interaction ( Race, 1, RegularProvider, 1, _EverHadPSATest); 
%interaction ( Race, 1, HCCoverage_Type, 1, _EverHadPSATest); 

%interaction ( _Income, 1, _Education, 1, _EverHadPSATest); 
%interaction ( _Income, 1, _OccupationStatus, 1, _EverHadPSATest); 
%interaction ( _Income, 1, _RUC2003, 2, _EverHadPSATest); 
%interaction ( _Income, 1, RegularProvider, 1, _EverHadPSATest); 
%interaction ( _Income, 1, HCCoverage_Type, 1, _EverHadPSATest); 

%interaction ( _Education, 1, _OccupationStatus, 1, _EverHadPSATest); 
%interaction ( _Education, 1, _RUC2003, 2, _EverHadPSATest); 
%interaction ( _Education, 1, RegularProvider, 1, _EverHadPSATest); 
%interaction ( _Education, 1, HCCoverage_Type, 1, _EverHadPSATest); 

%interaction ( _OccupationStatus, 1, _RUC2003, 2, _EverHadPSATest); 
%interaction ( _OccupationStatus, 1, RegularProvider, 1, _EverHadPSATest); 
%interaction ( _OccupationStatus, 1, HCCoverage_Type, 1, _EverHadPSATest); 

%interaction ( _RUC2003, 2, RegularProvider, 1, _EverHadPSATest); 
%interaction ( _RUC2003, 2, HCCoverage_Type, 1, _EverHadPSATest);

%interaction ( RegularProvider, 1, HCCoverage_Type, 1, _EverHadPSATest); 

/* _DrShouldPSATest */
%interaction ( _EverHadCancer, 2, _Age, 1, _DrShouldPSATest); 
%interaction ( _EverHadCancer, 2, Race, 1, _DrShouldPSATest); 
%interaction ( _EverHadCancer, 2, _Income, 1, _DrShouldPSATest); 
%interaction ( _EverHadCancer, 2, _Education, 1, _DrShouldPSATest); 
%interaction ( _EverHadCancer, 2, _MaritalStatus, 1, _DrShouldPSATest); 
%interaction ( _EverHadCancer, 2, _OccupationStatus, 1, _DrShouldPSATest); 
%interaction ( _EverHadCancer, 2, _RUC2003, 2, _DrShouldPSATest); 
%interaction ( _EverHadCancer, 2, RegularProvider, 1, _DrShouldPSATest); 
%interaction ( _EverHadCancer, 2, HCCoverage_Type, 1, _DrShouldPSATest); 

%interaction ( _Age, 1, Race, 1, _DrShouldPSATest); 
%interaction ( _Age, 1, _Income, 1, _DrShouldPSATest); 
%interaction ( _Age, 1, _Education, 1, _DrShouldPSATest); 
%interaction ( _Age, 1, _MaritalStatus, 1, _DrShouldPSATest); 
%interaction ( _Age, 1, _OccupationStatus, 1, _DrShouldPSATest); 
%interaction ( _Age, 1, _RUC2003, 2, _DrShouldPSATest); 
%interaction ( _Age, 1, RegularProvider, 1, _DrShouldPSATest); 
%interaction ( _Age, 1, HCCoverage_Type, 1, _DrShouldPSATest); 

%interaction ( Race, 1, _Income, 1, _DrShouldPSATest); 
%interaction ( Race, 1, _Education, 1, _DrShouldPSATest); 
%interaction ( Race, 1, _OccupationStatus, 1, _DrShouldPSATest); 
%interaction ( Race, 1, _RUC2003, 2, _DrShouldPSATest); 
%interaction ( Race, 1, RegularProvider, 1, _DrShouldPSATest); 
%interaction ( Race, 1, HCCoverage_Type, 1, _DrShouldPSATest); 

%interaction ( _Income, 1, _Education, 1, _DrShouldPSATest); 
%interaction ( _Income, 1, _OccupationStatus, 1, _DrShouldPSATest); 
%interaction ( _Income, 1, _RUC2003, 2, _DrShouldPSATest); 
%interaction ( _Income, 1, RegularProvider, 1, _DrShouldPSATest); 
%interaction ( _Income, 1, HCCoverage_Type, 1, _DrShouldPSATest); 

%interaction ( _Education, 1, _OccupationStatus, 1, _DrShouldPSATest); 
%interaction ( _Education, 1, _RUC2003, 2, _DrShouldPSATest); 
%interaction ( _Education, 1, RegularProvider, 1, _DrShouldPSATest); 
%interaction ( _Education, 1, HCCoverage_Type, 1, _DrShouldPSATest); 

%interaction ( _OccupationStatus, 1, _RUC2003, 2, _DrShouldPSATest); 
%interaction ( _OccupationStatus, 1, RegularProvider, 1, _DrShouldPSATest); 
%interaction ( _OccupationStatus, 1, HCCoverage_Type, 1, _DrShouldPSATest); 

%interaction ( _RUC2003, 2, RegularProvider, 1, _DrShouldPSATest); 
%interaction ( _RUC2003, 2, HCCoverage_Type, 1, _DrShouldPSATest);

%interaction ( RegularProvider, 1, HCCoverage_Type, 1, _DrShouldPSATest); 

/* _SomeDisagreePSATests */
%interaction ( _EverHadCancer, 2, _Age, 1, _SomeDisagreePSATests); 
%interaction ( _EverHadCancer, 2, Race, 1, _SomeDisagreePSATests); 
%interaction ( _EverHadCancer, 2, _Income, 1, _SomeDisagreePSATests); 
%interaction ( _EverHadCancer, 2, _Education, 1, _SomeDisagreePSATests); 
%interaction ( _EverHadCancer, 2, _MaritalStatus, 1, _SomeDisagreePSATests); 
%interaction ( _EverHadCancer, 2, _OccupationStatus, 1, _SomeDisagreePSATests); 
%interaction ( _EverHadCancer, 2, _RUC2003, 2, _SomeDisagreePSATests); 
%interaction ( _EverHadCancer, 2, RegularProvider, 1, _SomeDisagreePSATests); 
%interaction ( _EverHadCancer, 2, HCCoverage_Type, 1, _SomeDisagreePSATests); 

%interaction ( _Age, 1, Race, 1, _SomeDisagreePSATests); 
%interaction ( _Age, 1, _Income, 1, _SomeDisagreePSATests); 
%interaction ( _Age, 1, _Education, 1, _SomeDisagreePSATests); 
%interaction ( _Age, 1, _MaritalStatus, 1, _SomeDisagreePSATests); 
%interaction ( _Age, 1, _OccupationStatus, 1, _SomeDisagreePSATests); 
%interaction ( _Age, 1, _RUC2003, 2, _SomeDisagreePSATests); 
%interaction ( _Age, 1, RegularProvider, 1, _SomeDisagreePSATests); 
%interaction ( _Age, 1, HCCoverage_Type, 1, _SomeDisagreePSATests); 

%interaction ( Race, 1, _Income, 1, _SomeDisagreePSATests); 
%interaction ( Race, 1, _Education, 1, _SomeDisagreePSATests); 
%interaction ( Race, 1, _OccupationStatus, 1, _SomeDisagreePSATests); 
%interaction ( Race, 1, _RUC2003, 2, _SomeDisagreePSATests); 
%interaction ( Race, 1, RegularProvider, 1, _SomeDisagreePSATests); 
%interaction ( Race, 1, HCCoverage_Type, 1, _SomeDisagreePSATests); 

%interaction ( _Income, 1, _Education, 1, _SomeDisagreePSATests); 
%interaction ( _Income, 1, _OccupationStatus, 1, _SomeDisagreePSATests); 
%interaction ( _Income, 1, _RUC2003, 2, _SomeDisagreePSATests); 
%interaction ( _Income, 1, RegularProvider, 1, _SomeDisagreePSATests); 
%interaction ( _Income, 1, HCCoverage_Type, 1, _SomeDisagreePSATests); 

%interaction ( _Education, 1, _OccupationStatus, 1, _SomeDisagreePSATests); 
%interaction ( _Education, 1, _RUC2003, 2, _SomeDisagreePSATests); 
%interaction ( _Education, 1, RegularProvider, 1,_SomeDisagreePSATests); 
%interaction ( _Education, 1, HCCoverage_Type, 1, _SomeDisagreePSATests); 

%interaction ( _OccupationStatus, 1, _RUC2003, 2, _SomeDisagreePSATests); 
%interaction ( _OccupationStatus, 1, RegularProvider, 1, _SomeDisagreePSATests); 
%interaction ( _OccupationStatus, 1, HCCoverage_Type, 1, _SomeDisagreePSATests); 

%interaction ( _RUC2003, 2, RegularProvider, 1, _SomeDisagreePSATests); 
%interaction ( _RUC2003, 2, HCCoverage_Type, 1, _SomeDisagreePSATests);

%interaction ( RegularProvider, 1, HCCoverage_Type, 1, _SomeDisagreePSATests); 

/* _ProstateCa_PSATest */
%interaction ( _EverHadCancer, 2, _Age, 1, _ProstateCa_PSATest); 
%interaction ( _EverHadCancer, 2, Race, 1, _ProstateCa_PSATest); 
%interaction ( _EverHadCancer, 2, _Income, 1, _ProstateCa_PSATest); 
%interaction ( _EverHadCancer, 2, _Education, 1, _ProstateCa_PSATest); 
%interaction ( _EverHadCancer, 2, _MaritalStatus, 1, _ProstateCa_PSATest); 
%interaction ( _EverHadCancer, 2, _OccupationStatus, 1, _ProstateCa_PSATest); 
%interaction ( _EverHadCancer, 2, _RUC2003, 2, _ProstateCa_PSATest); 
%interaction ( _EverHadCancer, 2, RegularProvider, 1, _ProstateCa_PSATest); 
%interaction ( _EverHadCancer, 2, HCCoverage_Type, 1, _ProstateCa_PSATest); 

%interaction ( _Age, 1, Race, 1, _ProstateCa_PSATest); 
%interaction ( _Age, 1, _Income, 1, _ProstateCa_PSATest); 
%interaction ( _Age, 1, _Education, 1, _ProstateCa_PSATest); 
%interaction ( _Age, 1, _MaritalStatus, 1, _ProstateCa_PSATest); 
%interaction ( _Age, 1, _OccupationStatus, 1, _ProstateCa_PSATest); 
%interaction ( _Age, 1, _RUC2003, 2, _ProstateCa_PSATest); 
%interaction ( _Age, 1, RegularProvider, 1, _ProstateCa_PSATest); 
%interaction ( _Age, 1, HCCoverage_Type, 1, _ProstateCa_PSATest); 

%interaction ( Race, 1, _Income, 1, _ProstateCa_PSATest); 
%interaction ( Race, 1, _Education, 1, _ProstateCa_PSATest); 
%interaction ( Race, 1, _OccupationStatus, 1, _ProstateCa_PSATest); 
%interaction ( Race, 1, _RUC2003, 2, _ProstateCa_PSATest); 
%interaction ( Race, 1, RegularProvider, 1, _ProstateCa_PSATest); 
%interaction ( Race, 1, HCCoverage_Type, 1, _ProstateCa_PSATest); 

%interaction ( _Income, 1, _Education, 1, _ProstateCa_PSATest); 
%interaction ( _Income, 1, _OccupationStatus, 1, _ProstateCa_PSATest); 
%interaction ( _Income, 1, _RUC2003, 2, _ProstateCa_PSATest); 
%interaction ( _Income, 1, RegularProvider, 1, _ProstateCa_PSATest); 
%interaction ( _Income, 1, HCCoverage_Type, 1, _ProstateCa_PSATest); 

%interaction ( _Education, 1, _OccupationStatus, 1, _ProstateCa_PSATest); 
%interaction ( _Education, 1, _RUC2003, 2, _ProstateCa_PSATest); 
%interaction ( _Education, 1, RegularProvider, 1, _ProstateCa_PSATest); 
%interaction ( _Education, 1, HCCoverage_Type, 1, _ProstateCa_PSATest); 

%interaction ( _OccupationStatus, 1, _RUC2003, 2, _ProstateCa_PSATest); 
%interaction ( _OccupationStatus, 1, RegularProvider, 1, _ProstateCa_PSATest); 
%interaction ( _OccupationStatus, 1, HCCoverage_Type, 1, _ProstateCa_PSATest); 

%interaction ( _RUC2003, 2, RegularProvider, 1, _ProstateCa_PSATest); 
%interaction ( _RUC2003, 2, HCCoverage_Type, 1, _ProstateCa_PSATest);

%interaction ( RegularProvider, 1, HCCoverage_Type, 1, _ProstateCa_PSATest); 

/* _ProstateCa_SlowGrowing */
%interaction ( _EverHadCancer, 2, _Age, 1, _ProstateCa_SlowGrowing); 
%interaction ( _EverHadCancer, 2, Race, 1, _ProstateCa_SlowGrowing); 
%interaction ( _EverHadCancer, 2, _Income, 1, _ProstateCa_SlowGrowing); 
%interaction ( _EverHadCancer, 2, _Education, 1, _ProstateCa_SlowGrowing); 
%interaction ( _EverHadCancer, 2, _MaritalStatus, 1, _ProstateCa_SlowGrowing); 
%interaction ( _EverHadCancer, 2, _OccupationStatus, 1, _ProstateCa_SlowGrowing); 
%interaction ( _EverHadCancer, 2, _RUC2003, 2, _ProstateCa_SlowGrowing); 
%interaction ( _EverHadCancer, 2, RegularProvider, 1, _ProstateCa_SlowGrowing); 
%interaction ( _EverHadCancer, 2, HCCoverage_Type, 1, _ProstateCa_SlowGrowing); 

%interaction ( _Age, 1, Race, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Age, 1, _Income, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Age, 1, _Education, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Age, 1, _MaritalStatus, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Age, 1, _OccupationStatus, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Age, 1, _RUC2003, 2, _ProstateCa_SlowGrowing); 
%interaction ( _Age, 1, RegularProvider, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Age, 1, HCCoverage_Type, 1, _ProstateCa_SlowGrowing); 

%interaction ( Race, 1, _Income, 1, _ProstateCa_SlowGrowing); 
%interaction ( Race, 1, _Education, 1, _ProstateCa_SlowGrowing); 
%interaction ( Race, 1, _OccupationStatus, 1, _ProstateCa_SlowGrowing); 
%interaction ( Race, 1, _RUC2003, 2, _ProstateCa_SlowGrowing); 
%interaction ( Race, 1, RegularProvider, 1, _ProstateCa_SlowGrowing); 
%interaction ( Race, 1, HCCoverage_Type, 1, _ProstateCa_SlowGrowing); 

%interaction ( _Income, 1, _Education, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Income, 1, _OccupationStatus, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Income, 1, _RUC2003, 2, _ProstateCa_SlowGrowing); 
%interaction ( _Income, 1, RegularProvider, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Income, 1, HCCoverage_Type, 1, _ProstateCa_SlowGrowing); 

%interaction ( _Education, 1, _OccupationStatus, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Education, 1, _RUC2003, 2, _ProstateCa_SlowGrowing); 
%interaction ( _Education, 1, RegularProvider, 1, _ProstateCa_SlowGrowing); 
%interaction ( _Education, 1, HCCoverage_Type, 1, _ProstateCa_SlowGrowing); 

%interaction ( _OccupationStatus, 1, _RUC2003, 2, _ProstateCa_SlowGrowing); 
%interaction ( _OccupationStatus, 1, RegularProvider, 1, _ProstateCa_SlowGrowing); 
%interaction ( _OccupationStatus, 1, HCCoverage_Type, 1, _ProstateCa_SlowGrowing); 

%interaction ( _RUC2003, 2, RegularProvider, 1, _ProstateCa_SlowGrowing); 
%interaction ( _RUC2003, 2, HCCoverage_Type, 1, _ProstateCa_SlowGrowing);

%interaction ( RegularProvider, 1, HCCoverage_Type, 1, _ProstateCa_SlowGrowing);

/* _ProstateCa_SideEffects */
%interaction ( _EverHadCancer, 2, _Age, 1, _ProstateCa_SideEffects); 
%interaction ( _EverHadCancer, 2, Race, 1, _ProstateCa_SideEffects); 
%interaction ( _EverHadCancer, 2, _Income, 1, _ProstateCa_SideEffects); 
%interaction ( _EverHadCancer, 2, _Education, 1, _ProstateCa_SideEffects); 
%interaction ( _EverHadCancer, 2, _MaritalStatus, 1, _ProstateCa_SideEffects); 
%interaction ( _EverHadCancer, 2, _OccupationStatus, 1, _ProstateCa_SideEffects); 
%interaction ( _EverHadCancer, 2, _RUC2003, 2, _ProstateCa_SideEffects); 
%interaction ( _EverHadCancer, 2, RegularProvider, 1, _ProstateCa_SideEffects); 
%interaction ( _EverHadCancer, 2, HCCoverage_Type, 1, _ProstateCa_SideEffects); 

%interaction ( _Age, 1, Race, 1, _ProstateCa_SideEffects); 
%interaction ( _Age, 1, _Income, 1, _ProstateCa_SideEffects); 
%interaction ( _Age, 1, _Education, 1, _ProstateCa_SideEffects); 
%interaction ( _Age, 1, _MaritalStatus, 1, _ProstateCa_SideEffects); 
%interaction ( _Age, 1, _OccupationStatus, 1, _ProstateCa_SideEffects); 
%interaction ( _Age, 1, _RUC2003, 2, _ProstateCa_SideEffects); 
%interaction ( _Age, 1, RegularProvider, 1, _ProstateCa_SideEffects); 
%interaction ( _Age, 1, HCCoverage_Type, 1, _ProstateCa_SideEffects); 

%interaction ( Race, 1, _Income, 1, _ProstateCa_SideEffects); 
%interaction ( Race, 1, _Education, 1, _ProstateCa_SideEffects); 
%interaction ( Race, 1, _OccupationStatus, 1, _ProstateCa_SideEffects); 
%interaction ( Race, 1, _RUC2003, 2, _ProstateCa_SideEffects); 
%interaction ( Race, 1, RegularProvider, 1, _ProstateCa_SideEffects); 
%interaction ( Race, 1, HCCoverage_Type, 1, _ProstateCa_SideEffects); 

%interaction ( _Income, 1, _Education, 1, _ProstateCa_SideEffects); 
%interaction ( _Income, 1, _OccupationStatus, 1, _ProstateCa_SideEffects); 
%interaction ( _Income, 1, _RUC2003, 2, _ProstateCa_SideEffects); 
%interaction ( _Income, 1, RegularProvider, 1, _ProstateCa_SideEffects); 
%interaction ( _Income, 1, HCCoverage_Type, 1, _ProstateCa_SideEffects); 

%interaction ( _Education, 1, _OccupationStatus, 1, __ProstateCa_SideEffects); 
%interaction ( _Education, 1, _RUC2003, 2, _ProstateCa_SideEffects); 
%interaction ( _Education, 1, RegularProvider, 1, _ProstateCa_SideEffects); 
%interaction ( _Education, 1, HCCoverage_Type, 1, _ProstateCa_SideEffects); 

%interaction ( _OccupationStatus, 1, _RUC2003, 2, _ProstateCa_SideEffects); 
%interaction ( _OccupationStatus, 1, RegularProvider, 1, _ProstateCa_SideEffects); 
%interaction ( _OccupationStatus, 1, HCCoverage_Type, 1, _ProstateCa_SideEffects); 

%interaction ( _RUC2003, 2, RegularProvider, 1, _ProstateCa_SideEffects); 
%interaction ( _RUC2003, 2, HCCoverage_Type, 1, _ProstateCa_SideEffects);

%interaction ( RegularProvider, 1, HCCoverage_Type, 1,_ProstateCa_SideEffects);
Status API Training Shop Blog About Pricing
© 2015 GitHub, Inc. Terms Privacy Security Contact Help
