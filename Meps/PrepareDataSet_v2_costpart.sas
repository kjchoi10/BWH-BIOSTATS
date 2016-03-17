 libname out1 'F:\Projects\Trinh\MEPS\__MACOSX';   

/* Get 2009 Data  */

filename IN1 'F:\Projects\Trinh\MEPS\__MACOSX\h129.ssp';                                        
                                                                                                     
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;  
     
     proc datasets library=out1;
   change H129=consolidated_2009;
   run;

 filename IN1 'F:\Projects\Trinh\MEPS\__MACOSX\h126g.ssp';                                        
                                                                                                   
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;   

   proc datasets library=out1;
   change H126G=office_2009;
	run; 
	
 filename IN1 'F:\Projects\Trinh\MEPS\__MACOSX\h126f.ssp';                                        
                                                                                                   
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;   

   proc datasets library=out1;
   change H126F=outpatient_2009;
run; 
  
  /* Get 2011 Data  */


filename IN1 'F:\Projects\Trinh\MEPS\__MACOSX\h147.ssp';                                        
                                                                                                     
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;  
     
     proc datasets library=out1;
   change H147=consolidated_2011;
   run;
    
 filename IN1 'F:\Projects\Trinh\MEPS\__MACOSX\h144g.ssp';                                        
                                                                                                   
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;   

   proc datasets library=out1;
   change H144G=office_2011;
	run; 
	
 filename IN1 'F:\Projects\Trinh\MEPS\__MACOSXX\h144f.ssp';                                        
                                                                                                   
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;   

   proc datasets library=out1;
   change H144F=outpatient_2011;
run; 
  
/* Get 2012 Data  */

filename IN1 'F:\Projects\Trinh\MEPS\__MACOSX\h155.ssp';                                        
                                                                                                     
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;  
     
     proc datasets library=out1;
   change H155=consolidated_2012;
   run;

 filename IN1 'F:\Projects\Trinh\MEPS\__MACOSX\h152g.ssp';                                        
                                                                                                   
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;   

   proc datasets library=out1;
   change H152G=office_2012;
	run; 
	
 filename IN1 'F:\Projects\Trinh\MEPS\__MACOSX\h152f.ssp';                                        
                                                                                                   
     PROC XCOPY IN=IN1 out=out1 IMPORT;                                                           
     RUN;   

   proc datasets library=out1;
   change H152F=outpatient_2012;
run; 
  
/* Preparing Data  */
 
    /*  2009 Data */ 

      /* Data set for BreastCancer Compliance */
    
      DATA out1.BC_DATA_09;
		SET
	  	    out1.consolidated_2009 (KEEP = DUPERSID SEX AGE09X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT09 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU09X INS31X INS42X INS53X INS09X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT09F 
									rename=(PERWT09F=PERWTF )
											);
			label MAMOGR53 = 'MAMMOGRAM';								
			if SEX=2 & AGE09X > 50 & AGE09X < 74 & MAMOGR53 in (1,2,3,4,5,6) & HAVEUS42 in (1, 2);
			income=POVCAT09;
		RUN;
 
      /* Data set for BreastCancer Compliance */
    
      DATA out1.BC_DATA_09;
		SET
	  	    out1.consolidated_2009 (KEEP = DUPERSID SEX AGE09X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT09 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU09X INS31X INS42X INS53X INS09X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT09F 
									rename=(PERWT09F=PERWTF )
											);
			label MAMOGR53 = 'MAMMOGRAM';								
			if SEX=2 & AGE09X > 50 & AGE09X < 74 & MAMOGR53 in (1,2,3,4,5,6 & HAVEUS42 in (1, 2));
			income=POVCAT09;
		RUN; 
    
    /* Data set for Cervical Cancer Compliance */
    
     DATA out1.CeC_DATA_09;
		SET
	  	    out1.consolidated_2009 (KEEP = DUPERSID SEX AGE09X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT09 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU09X INS31X INS42X INS53X INS09X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT09F 
									rename=(PERWT09F=PERWTF )
											);
			if SEX=2 & AGE09X > 21 & AGE09X < 65 & PAPSMR53 in (1,2,3,4,5,6) & HYSTER53=2 & if HAVEUS42 in (1, 2) ;
			income=POVCAT09;
		RUN;  
        
      /* Data set for Colon Cancer Compliance */   
      
      DATA out1.CC_DATA_09;
		SET  out1.consolidated_2009 (KEEP = DUPERSID SEX AGE09X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT09 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU09X INS31X INS42X INS53X INS09X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT09F 
									rename=(PERWT09F=PERWTF )
											);
			if AGE09X > 50 & AGE09X < 75 & HAVEUS42 in (1, 2) & ( BSTST53 in (1 , 2, 3, 4, 5,6) | CLNTST53 in (1,2,3,4,5,6) | 
(SGMTST53 in (1,2,3,4,5,6) ));
income=POVCAT09;
			RUN;
      
      /* Data set for Prostate  Cancer Compliance */
      
      DATA out1.PC_DATA_09;
		SET
	  	    out1.consolidated_2009 (KEEP = DUPERSID SEX AGE09X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT09 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU09X INS31X INS42X INS53X INS09X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT09F 
									rename=(PERWT09F=PERWTF )
											);
			if AGE09X > 50 & AGE09X < 75  & PSA53 in (1 , 2, 3, 4, 5,6) & HAVEUS42 in (1, 2) ;
			income=POVCAT09;
		RUN;
    
    /*  2011 & 2012 Data */ 
   
    /* Data set for BreastCancer Compliance */
      
     DATA out1.BC_DATA;
		SET
  	    out1.consolidated_2012 (KEEP = DUPERSID SEX AGE12X AGE53X AGE42X AGE31X EDUCYR RACEV1X HISPANX HAVEUS42
											 LANGHM42 POVCAT12 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU12X INS31X INS42X INS53X INS12X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT12F 
									rename=(PERWT12F=PERWTF AGE12X=AGEX RACEV1X=RACEX INS12X=INSX POVCAT12=POVCAT FTSTU12X=FTSTUX ))
	    out1.consolidated_2011 (KEEP = DUPERSID SEX AGE11X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT11 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU11X INS31X INS42X INS53X INS11X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT11F 
									rename=(PERWT11F=PERWTF AGE11X=AGEX  INS11X=INSX POVCAT11=POVCAT FTSTU11X=FTSTUX))	;	
 
		label MAMOGR53 = 'MAMMOGRAM';		
		if SEX=2 & AGEX > 50 & AGEX < 74 & MAMOGR53 in (1,2,3,4,5) & HAVEUS42 in (1, 2);
		income=POVCAT;
		RUN;  
    
    /* Data set for Cervical Cancer Compliance */
    
     DATA out1.CeC_DATA;
	  SET								  			  
	  	    out1.consolidated_2012 (KEEP = DUPERSID SEX AGE12X AGE53X AGE42X AGE31X EDUCYR RACEV1X HISPANX HAVEUS42
											 LANGHM42 POVCAT12 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU12X INS31X INS42X INS53X INS12X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT12F 
									rename=(PERWT12F=PERWTF AGE12X=AGEX RACEV1X=RACEX  INS12X=INSX POVCAT12=POVCAT FTSTU12X=FTSTUX))
 			out1.consolidated_2011 (KEEP = DUPERSID SEX AGE11X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT11 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU11X INS31X INS42X INS53X INS11X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT11F 
									rename=(PERWT11F=PERWTF AGE11X=AGEX  INS11X=INSX POVCAT11=POVCAT FTSTU11X=FTSTUX));						  			  
			if SEX=2 & AGEX > 21 & AGEX < 65 & PAPSMR53 in (1,2,3,4,5) & HYSTER53=2 & HAVEUS42 in (1, 2);
			income=POVCAT;
			
		RUN;  
        
      /* Data set for Colon Cancer Compliance */   
      
      DATA out1.CC_DATA;
		SET  							  			  
	  	    out1.consolidated_2012 (KEEP = DUPERSID SEX AGE12X AGE53X AGE42X AGE31X EDUCYR RACEV1X HISPANX HAVEUS42
											 LANGHM42 POVCAT12 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU12X INS31X INS42X INS53X INS12X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT12F 
									rename=(PERWT12F=PERWTF AGE12X=AGEX RACEV1X=RACEX  INS12X=INSX POVCAT12=POVCAT FTSTU12X=FTSTUX))
			out1.consolidated_2011 (KEEP = DUPERSID SEX AGE11X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT11 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU11X INS31X INS42X INS53X INS11X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT11F 
									rename=(PERWT11F=PERWTF AGE11X=AGEX  INS11X=INSX POVCAT11=POVCAT FTSTU11X=FTSTUX));							  			  
			if AGEX > 50 & AGEX < 75 & HAVEUS42 in (1, 2) & (  CLNTST53 in (1 , 2, 3, 4, 5,6) | SGMTST53 in (1 , 2, 3, 4, 5,6) | 
BSTST53 in  (1 , 2, 3, 4, 5,6) );
income=POVCAT;
			RUN;
      
      
      /* Data set for Prostate  Cancer Compliance */
      
      DATA out1.PC_DATA;
		SET								  			  
	  	    out1.consolidated_2012 (KEEP = DUPERSID SEX AGE12X AGE53X AGE42X AGE31X EDUCYR RACEV1X HISPANX HAVEUS42
											 LANGHM42 POVCAT12 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU12X INS31X INS42X INS53X INS12X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT12F 
									rename=(PERWT12F=PERWTF AGE12X=AGEX  RACEV1X=RACEX  INS12X=INSX POVCAT12=POVCAT FTSTU12X=FTSTUX))
  	        out1.consolidated_2011 (KEEP = DUPERSID SEX AGE11X AGE53X AGE42X AGE31X EDUCYR RACEX HISPANX HAVEUS42
											 LANGHM42 POVCAT11 EMPST31 EMPST42 EMPST53 FTSTU31X FTSTU42X 
											 FTSTU53X FTSTU11X INS31X INS42X INS53X INS11X PSA53 HYSTER53
											 PAPSMR53 BRSTEX53 MAMOGR53 BSTST53 CLNTST53 SGMTST53 VARSTR VARPSU PERWT11F 
									rename=(PERWT11F=PERWTF AGE11X=AGEX  INS11X=INSX POVCAT11=POVCAT FTSTU11X=FTSTUX));							  			  
			if AGEX > 50 & AGEX < 75 & PSA53  in (1 , 2, 3, 4, 5) & HAVEUS42 in (1, 2);
			income=POVCAT;
		RUN;
	
	/* Expences Data PRE_ACA  EVNTIDX */ 
	
	 DATA out1.EXPENCES_PRE_ACA;
		SET	out1.office_2009(keep = DUPERSID EVNTIDX SEETLKPV OBICD1X OBICD2X OBICD3X OBICD4X 
									 OBPRO1X OBCCC1X OBSF09X PERWT09F VARSTR VARPSU MAMMOG
							 rename=(OBCCC1X=CCC1X OBICD1X=ICD1X OBICD2X=ICD2X OBICD3X=ICD3X  OBICD4X=ICD4X
									 OBPRO1X=PRO1X PERWT09F=PERWTF OBSF09X=OFF_AMT)) 
		 out1.outpatient_2009(keep = DUPERSID EVNTIDX SEETLKPV OPICD1X OPICD2X OPICD3X OPICD4X 
									 OPPRO1X OPCCC1X OPFSF09X OPDSF09X  PERWT09F  VARSTR VARPSU OPXP09X OPTC09X MAMMOG
							 rename=(OPCCC1X = CCC1X OPICD1X=ICD1X OPICD2X=ICD2X OPICD3X=ICD3X  OPICD4X=ICD4X
									 OPPRO1X=PRO1X PERWT09F=PERWTF OPFSF09X=OPFSFX OPDSF09X=OPDSFX ) ) ;
		OP_TOT_AMT=sum(OPXP09X,OPTC09X);
		label OP_TOT_AMT= 'Total Amount PD, Family - OUTPATIENT';
		label OFF_AMT= 'Total Amount PD, Family - OFFICE-BASED';
		/*IF ICD1X EQ "V76";*/
		IF MAMMOG in (1, 2); 
		status='Pre ';
	RUN;
	
	/* Expences Data POST_ACA  */  
	
	 DATA out1.EXPENCES_POST_ACA; /*OBICD1X OPICD1X*/
		SET	
			out1.office_2011(keep = OBSF11X OBTC11X DUPERSID EVNTIDX SEETLKPV OBICD1X OBICD2X OBICD3X OBICD4X  
									 OBPRO1X OBCCC1X OBSF11X PERWT11F VARSTR VARPSU MAMMOG
							 rename=( OBSF11X = cost
OBCCC1X=CCC1X OBICD1X=ICD1X OBICD2X=ICD2X OBICD3X=ICD3X OBICD4X=ICD4X
									 OBPRO1X=PRO1X PERWT11F=PERWTF OBSF11X=OFF_AMT)) 	
			out1.office_2012(keep = OBSF12X OBTC12X DUPERSID EVNTIDX SEETLKPV OBICD1X OBICD2X OBICD3X OBICD4X  
									OBPRO1X OBCCC1X OBSF12X PERWT12F VARSTR VARPSU MAMMOG
							rename=( OBSF12X = cost
OBCCC1X=CCC1X OBICD1X=ICD1X OBICD2X=ICD2X OBICD3X=ICD3X  OBICD4X=ICD4X
									OBPRO1X=PRO1X PERWT12F=PERWTF OBSF12X=OFF_AMT))         
			out1.outpatient_2011(keep = OPXP11X OPTC11X DUPERSID EVNTIDX SEETLKPV OPICD1X OPICD2X OPICD3X OPICD4X
									  	 OPPRO1X OPCCC1X OPFSF11X OPDSF11X PERWT11F  VARSTR VARPSU MAMMOG
								rename=( OPCCC1X = CCC1X OPICD1X=ICD1X OPICD2X=ICD2X OPICD3X=ICD3X  OPICD4X=ICD4X
									  	  OPPRO1X=PRO1X PERWT11F=PERWTF OPFSF11X=OPFSFX OPDSF11X=OPDSFX ) )			
			out1.outpatient_2012(keep = OPXP12X OPTC12X  DUPERSID EVNTIDX SEETLKPV OPICD1X OPICD2X OPICD3X OPICD4X 
									  	OPPRO1X OPCCC1X OPFSF12X OPDSF12X PERWT12F  VARSTR VARPSU MAMMOG
								rename=(OPXP12X = cost OPCCC1X = CCC1X OPICD1X=ICD1X OPICD2X=ICD2X OPICD3X=ICD3X  OPICD4X=ICD4X
									  	  OPPRO1X=PRO1X PERWT12F=PERWTF OPFSF12X=OPFSFX OPDSF12X=OPDSFX ) ) ;
		OP_TOT_AMT=sum(OPXP11X,OPTC11X, OPXP12X, OPTC12X,OBTC11X ,OBTC12X); 
		label OP_TOT_AMT= 'Total Amount PD, Family - OUTPATIENT';
		label OFF_AMT= 'Total Amount PD, Family - OFFICE-BASED';
		/*IF ICD1X ='V76'; /* look up what this variable is */
		IF MAMMOG in (1, 2);
		status='Post';
	RUN;

		/* PRE_ACA V/S POST_ACA  */ 
	
	DATA out1.PRE_VS_POST;
		SET  out1.EXPENCES_PRE_ACA (keep = DUPERSID EVNTIDX status MAMMOG OFF_AMT OP_TOT_AMT VARSTR VARPSU PERWTF)			
			 out1.EXPENCES_POST_ACA (keep = DUPERSID EVNTIDX status MAMMOG OFF_AMT OP_TOT_AMT VARSTR VARPSU PERWTF);
	RUN;		
	
/****DOING THE COST PART AGAIN 12-9-15***********************************/

libname out1 'F:\Projects\Trinh\MEPS\__MACOSX';
libname meps 'F:\Projects\Trinh\MEPS';
options nofmterr;

/*** Run these code scripts one at a time to run out of pocket and out of patient analysis ***/

/* 1 */
/* Data cutting for out of office out of pocket costs */
data meps.costs0; /*pre aca*/
set OUT1.OFFICE_2009  (keep = OBSF09X PID);
status='Pre';
ACA_CAT_OF=2;
outpocket=	OBSF09X;
logoutpocket = LOG(outpocket);
run;
	
data meps.costs; /*post aca*/
set OUT1.OFFICE_2011  (keep = OBSF11X PID)
OUT1.OFFICE_2012 (keep = OBSF12X PID);
status='Post';
ACA_CAT_OF=1;
if OBSF11X ne . then 	outpocket=	OBSF11X ;
else outpocket=	OBSF12X;
logoutpocket = LOG(outpocket);
run;

data meps.cost_all;
set meps.costs0 meps.costs;
keep pid status outpocket logoutpocket ACA_CAT_OF;
run;

/* 2 */
/* Data cutting for out patient costs */
data meps.costs2; /*pre aca*/
set OUT1.OUTPATIENT_2009 (keep = OPXP09X PID);
status='Pre';
ACA_CAT_PAT=2;
outpatient= OPXP09X;
logoutpatientt = LOG(outpatient);
run;

data meps.costs3; /*pre post*/
set OUT1.OUTPATIENT_2011 (keep = OPXP11X PID)
OUT1.OUTPATIENT_2012 (keep= OPXP12X PID);
status='Post';
ACA_CAT_PAT=1;
if OPXP11X ne . then outpatient = OPXP11X ;
else outpatient= OPXP12X;
logoutpatient = LOG(outpatient);
run;

data meps.cost_all_pat;
set meps.costs2 meps.costs3;
keep pid status outpatient logoutpatient ACA_CAT_PAT;
run;

/* 3 */
/* Data cutting for out of office out of pocket costs for mammography */
data meps.costsMAMPRE; /*pre aca*/
set OUT1.OFFICE_2009  (keep = OBSF09X MAMMOG PID);
status='Pre';
ACA_CAT_OF=2;
if MAMMOG in (1, 2);
outpocket=	OBSF09X;
logoutpocket = LOG(outpocket);
run;
	
data meps.costsMAMPOST; /*post aca*/
set OUT1.OFFICE_2011  (keep = OBSF11X MAMMOG PID)
OUT1.OFFICE_2012 (keep = OBSF12X MAMMOG PID);
status='Post';
ACA_CAT_OF=1;
if MAMMOG in (1, 2);
if OBSF11X ne . then 	outpocket=OBSF11X ;
else outpocket=	OBSF12X;
logoutpocket = LOG(outpocket);
run;

data meps.cost_all;
set meps.costsMAMPRE meps.costsMAMPOST;
keep pid status outpocket logoutpocket ACA_CAT_OF MAMMOG;
run;

/* 4 */
/* Data cutting for out of office out of patient costs for mammography */
data meps.costsMAMPRE; /*pre aca*/
set OUT1.OUTPATIENT_2009  (keep = OPXP09X MAMMOG PID);
status='Pre';
ACA_CAT_PAT=2;
outpatient=	OPXP09X;
if MAMMOG in (1, 2);
logoutpatientt = LOG(outpatient);
run;
	
data meps.costsMAMPOST; /*post aca*/
set OUT1.OUTPATIENT_2011  (keep = OPXP11X MAMMOG PID)
OUT1.OUTPATIENT_2012 (keep = OPXP12X MAMMOG PID);
status='Post';
ACA_CAT_PAT=1;
if OPXP11X ne . then 	outpocket=OPXP11X;
else outpatient= OPXP12X;
logoutpatient = LOG(outpatient);
if MAMMOG in (1, 2);
run;

data meps.cost_all_pat;
set meps.costsMAMPRE meps.costsMAMPOST;
keep pid status outpatient logoutpatient ACA_CAT_PAT MAMMOG;
run;

/***merging with cohorts outpocket*/

%macro blah(type);

data meps.&type;
set out1.&type;
pidc= substr(DUPERSID,6,3);
pid=input(pidc,best9.);
run;

proc sort data = meps.&type;
by pid;
run;

proc sort data = meps.cost_all;
by pid;
run;

data meps.cost_&type;
merge meps.cost_all meps.&type (in=a);
by pid;
if a; 
run;

%mend; 
%blah(breast);  %blah(prostate); %blah(colon);  %blah(Cervical);

/***merging with cohorts outpatient*/

%macro blah(type);

data meps.&type;
set out1.&type;
pidc= substr(DUPERSID,6,3);
pid=input(pidc,best9.);
run;

proc sort data = meps.&type;
by pid;
run;

proc sort data = meps.cost_all_pat;
by pid;
run;

data meps.cost_&type;
merge meps.cost_all_pat meps.&type (in=a);
by pid;
if a; 
run;

%mend; 
%blah(breast);  %blah(prostate); %blah(colon);  %blah(Cervical);

proc contents data=meps.cost_breast;
run;

/****KEVIN NEEDS TO DO**/
/**** Outpocket ****/

ods pdf body='F:\Projects\Trinh\MEPS\Code\Cost_outpocket.pdf';

%macro blah(type);

 TITLE " &Type expences - Pre ACA Out-of-Pocket Costs, Descriptive Statistics";
	PROC SURVEYMEANS DATA=meps.cost_&type missing SUM STD MEAN STDERR median quartiles;
	CLASS ACA_CAT_OF;
	STRATA VARSTR ;
	CLUSTER VARPSU;
	WEIGHT PERWTF;
	VAR outpocket;
	DOMAIN ACA_CAT_OF;
	RUN;
OPTIONS nofmterr; 

/* Wilcoxon Scores (Rank Sums)  */ 
TITLE " &Type expences - Pre ACA Out-of-Pocket Costs, Wilcoxon";
	PROC npar1way data=meps.cost_&type wilcoxon;
	CLASS ACA_CAT_OF;
	VAR outpocket;
	RUN;	

TITLE " &Type expences out office - Pre ACA Out-of-Pocket Costs, Regression";
	PROC SURVEYreg DATA=meps.cost_&type;
	WEIGHT PERWTF;
	CLUSTER VARPSU;
	STRATA VARSTR;
	CLASS ACA_CAT_OF AGECAT NEWRACE HIGHEDUC LANG HAVEUS INSUR EMPSTA;
    MODEL outpocket = ACA_CAT_OF AGECAT NEWRACE HIGHEDUC LANG HAVEUS INSUR EMPSTA /CLPARM SOLUTION;
	WHERE HAVEUS in (1,2);
	FORMAT MAMOGR53 TestDone. AGECAT AGECAT. NEWRACE RACEF. HIGHEDUC EDUCF. LANG LANGHM. 
HAVEUS YESNO. POVCAT09 povcat9h. INSUR YESNO. EMPSTA EMPSTCAT. STUDENT STUDENTCAT.;
	RUN;

	   %mend; 
%blah(breast);  %blah(prostate); %blah(colon);  %blah(Cervical); 


/**** Outpatient ****/

ods pdf body='F:\Projects\Trinh\MEPS\Code\Cost_outpatient.pdf';

%macro blah(type);

 TITLE " &Type expences - Pre ACA Out-Patient Costs, Descriptive Statistics";
	PROC SURVEYMEANS DATA=meps.cost_&type missing SUM STD MEAN STDERR median quartiles;
	CLASS ACA_CAT_PAT;
	STRATA VARSTR ;
	CLUSTER VARPSU;
	WEIGHT PERWTF;
	VAR outpatient;
	DOMAIN ACA_CAT_PAT;
	RUN;
OPTIONS nofmterr; 

/* Wilcoxon Scores (Rank Sums)  */ 
TITLE " &Type expences - Pre ACA Out-Patient Costs, Wilcoxon";
	PROC npar1way data=meps.cost_&type wilcoxon;
	CLASS ACA_CAT_PAT;
	VAR outpatient;
	RUN;	

TITLE " &Type expences out office - Pre ACA Out-Patient Costs, Regression";
	PROC SURVEYreg DATA=meps.cost_&type;
	WEIGHT PERWTF;
	CLUSTER VARPSU;
	STRATA VARSTR;
	CLASS ACA_CAT_PAT AGECAT NEWRACE HIGHEDUC LANG HAVEUS INSUR EMPSTA;
    model outpatient = ACA_CAT_PAT AGECAT NEWRACE HIGHEDUC LANG HAVEUS INSUR EMPSTA /CLPARM SOLUTION;
	WHERE HAVEUS in (1,2);
	FORMAT MAMOGR53 TestDone. AGECAT AGECAT. NEWRACE RACEF. HIGHEDUC EDUCF. LANG LANGHM. 
HAVEUS YESNO. POVCAT09 povcat9h. INSUR YESNO. EMPSTA EMPSTCAT. STUDENT STUDENTCAT.  ;
	RUN;

	   %mend; 
%blah(breast);  %blah(prostate); %blah(colon);  %blah(Cervical); 

/* Combine breast prostate colon and cervical patients for general analysis */
/* Do over for each out of pocket and out patient */
data meps.cost_all_together;
set meps.cost_breast meps.cost_prostate meps.cost_colon meps.cost_Cervical meps.costs_all;
run;

TITLE " All expences - Pre/Post ACA Out-of-Pocket Costs, Descriptive Statistics";
	PROC SURVEYMEANS DATA=meps.cost_all_together missing SUM STD MEAN STDERR MEDIAN;
	CLASS ACA_CAT_OF;
	STRATA VARSTR ;
	CLUSTER VARPSU;
	WEIGHT PERWTF;
	VAR outpocket;
	DOMAIN ACA_CAT_OF;
	RUN;
OPTIONS nofmterr; 

TITLE " All expences - Pre/Post ACA Out Patient Costs, Descriptive Statistics";
	PROC SURVEYMEANS DATA=meps.cost_all_together missing SUM STD MEAN STDERR MEDIAN;
	CLASS ACA_CAT_PAT;
	STRATA VARSTR ;
	CLUSTER VARPSU;
	WEIGHT PERWTF;
	VAR outpatient;
	DOMAIN ACA_CAT_PAT;
	RUN;
OPTIONS nofmterr; 

/* Mammo compliant patients and breast cancer screening */
ods pdf body='F:\Projects\Trinh\MEPS\Code\Cost_outpocket_mammo.pdf';

TITLE "MAMMO + BC OUTPOCKET COMPLIANT";
	PROC SURVEYMEANS DATA=meps.cost_breast (WHERE=(MAMMOG=1)) missing SUM STD MEAN STDERR MEDIAN NOBS;
	CLASS ACA_CAT_OF;
	STRATA VARSTR ;
	CLUSTER VARPSU;
	WEIGHT PERWTF;
	VAR outpocket;
	DOMAIN ACA_CAT_OF;
	RUN;

/* Mammo compliant patients and breast cancer screening */
ods pdf body='F:\Projects\Trinh\MEPS\Code\Cost_outpatient_mammo.pdf';

TITLE "MAMMO + BC OUTPATIENT COMPLIANT";
	PROC SURVEYMEANS DATA=meps.cost_breast (WHERE=(MAMMOG=1)) missing SUM STD MEAN STDERR MEDIAN NOBS;
	CLASS ACA_CAT_PAT;
	STRATA VARSTR ;
	CLUSTER VARPSU;
	WEIGHT PERWTF;
	VAR outpatient;
	DOMAIN ACA_CAT_PAT;
	RUN;
