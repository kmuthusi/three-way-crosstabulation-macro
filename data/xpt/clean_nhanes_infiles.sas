
/********************************************************
** program: C:\NHANES III\SAS\data\xpt\clean_nhanes_infiles.sas  
** programmer: savasas  
** date: 23 Oct 2019 
** comments: SAS program to read and label:  
**  C:\NHANES III\SAS\data\xpt\clean_.xpt 
**           which contains data from a Stata dataset
********************************************************/

options nofmterr nocenter linesize=max;


 ** this version of _infile_report.do will be overwritten if all goes well. **; 
 data _null_;
file "C:\NHANES III\SAS\data\xpt\clean_nhanes_infile_report.do"; 
 put "capture program drop sas_rep"; 
 put "program define sas_rep, rclass"; 
 put "di as err "" SAS failed to create clean_nhanes "" "; 
 put "di as err "" Look at {view C:\NHANES III\SAS\data\xpt\clean_nhanes_infile.log:C:\NHANES III\SAS\data\xpt\clean_nhanes_infile.log} to see what error occurred. "" "; 
 put "local sas_rep_error= 1 "; 
 put "return local sas_rep_error ""`sas_rep_error\'"" "; 
 put "end"; 

libname library v9 "C:\NHANES III\SAS\data\xpt\" ;  

options fmtsearch=(out.clean_nhanes);  

libname out v9 "C:\NHANES III\SAS\data\xpt\"  ;  

libname raw xport "C:\NHANES III\SAS\data\xpt\clean_.xpt";  


options NoQuoteLenMax;
data formats;
length fmtname $32 start end 8 label $32000;
infile "C:\NHANES III\SAS\data\xpt\clean_nhanes_formats.txt" lrecl=32075 truncover ; 
input fmtname 1-32 start 34-53 end 55-74 label 76-32000;
run; 


proc format library= library.clean_nhanes cntlin= work.formats(where= (fmtname ^= ""));
run; quit;

%macro redo;
 ** Check for this error message:
  * upcase(error:) File LIBRARY.clean_nhanes.CATALOG was created for a different operating system. **;
 %if &syserr.= 3000 %then %do;
   proc datasets library= library 
                 memtype= catalog 
                 nodetails nolist nowarn;
     delete clean_nhanes;
   run;
   ** now try it! **;
   proc format library= library.clean_nhanes cntlin= work.formats(where= (fmtname ^= ""));
   run; quit;
 %end;
%mend redo;
%redo;

data out.clean_nhanes  (label= "-savasas- created dataset on %sysfunc(date(), date9.)"  rename=(
 SEQN= seqn SDDSRVYR= sddsrvyr RIDSTATR= ridstatr RIAGENDR= riagendr RIDAGEYR= ridageyr
 RIDAGEMN= ridagemn RIDRETH1= ridreth1 RIDRETH3= ridreth3 RIDEXMON= ridexmon RIDEXAGM= ridexagm
 DMQMILIZ= dmqmiliz DMQADFC= dmqadfc DMDBORN4= dmdborn4 DMDCITZN= dmdcitzn DMDYRSUS= dmdyrsus
 DMDEDUC3= dmdeduc3 DMDEDUC2= dmdeduc2 DMDMARTL= dmdmartl RIDEXPRG= ridexprg SIALANG= sialang
 SIAPROXY= siaproxy SIAINTRP= siaintrp FIALANG= fialang FIAPROXY= fiaproxy FIAINTRP= fiaintrp
 MIALANG= mialang MIAPROXY= miaproxy MIAINTRP= miaintrp AIALANGA= aialanga DMDHHSIZ= dmdhhsiz
 DMDFMSIZ= dmdfmsiz DMDHHSZA= dmdhhsza DMDHHSZB= dmdhhszb DMDHHSZE= dmdhhsze DMDHRGND= dmdhrgnd
 DMDHRAGE= dmdhrage DMDHRBR4= dmdhrbr4 DMDHREDU= dmdhredu DMDHRMAR= dmdhrmar DMDHSEDU= dmdhsedu
 WTINT2YR= wtint2yr WTMEC2YR= wtmec2yr SDMVPSU= sdmvpsu SDMVSTRA= sdmvstra INDHHIN2= indhhin2
 INDFMIN2= indfmin2 INDFMPIR= indfmpir AGE20_PL= age20_plus LBXHA= lbxha DOM_MILI= dom_miliz
 RIDAGEY1= ridageyrcat RIDAGEY2= ridageyrcat2 AGE_15_6= age_15_64_dom
 ));
 length  SEQN 6 SDDSRVYR 3 RIDSTATR 3 RIAGENDR 3 RIDAGEYR 3 RIDAGEMN 3 RIDRETH1 3 RIDRETH3 3
 RIDEXMON 3 RIDEXAGM 4 DMQMILIZ 3 DMQADFC 3 DMDBORN4 3 DMDCITZN 3 DMDYRSUS 3 DMDEDUC3 3
 DMDEDUC2 3 DMDMARTL 3 RIDEXPRG 3 SIALANG 3 SIAPROXY 3 SIAINTRP 3 FIALANG 3 FIAPROXY 3
 FIAINTRP 3 MIALANG 3 MIAPROXY 3 MIAINTRP 3 AIALANGA 3 DMDHHSIZ 3 DMDFMSIZ 3 DMDHHSZA 3
 DMDHHSZB 3 DMDHHSZE 3 DMDHRGND 3 DMDHRAGE 3 DMDHRBR4 3 DMDHREDU 3 DMDHRMAR 3 DMDHSEDU 3
 WTINT2YR 8 WTMEC2YR 8 SDMVPSU 3 SDMVSTRA 4 INDHHIN2 3 INDFMIN2 3 INDFMPIR 8 AGE20_PL 3
 LBXHA 3 DOM_MILI 8 RIDAGEY1 3 RIDAGEY2 3 AGE_15_6 8
  ;;;
 set raw.clean_; 


 LABEL 
  SEQN='Respondent sequence number' 
  SDDSRVYR='Data release cycle' 
  RIDSTATR='Interview/Examination status' 
  RIAGENDR='Gender' 
  RIDAGEYR='Age in years at screening' 
  RIDAGEMN='Age in months at screening - 0 to 24 mos' 
  RIDRETH1='Race/Hispanic origin' 
  RIDRETH3='Race/Hispanic origin w/ NH Asian' 
  RIDEXMON='Six month time period' 
  RIDEXAGM='Age in months at exam - 0 to 19 years' 
  DMQMILIZ='Served active duty in US Armed Forces' 
  DMQADFC='Served in a foreign country' 
  DMDBORN4='Country of birth' 
  DMDCITZN='Citizenship status' 
  DMDYRSUS='Length of time in US' 
  DMDEDUC3='Education level - Children/Youth 6-19' 
  DMDEDUC2='Education level - Adults 20+' 
  DMDMARTL='Marital status' 
  RIDEXPRG='Pregnancy status at exam' 
  SIALANG='Language of SP Interview' 
  SIAPROXY='Proxy used in SP Interview?' 
  SIAINTRP='Interpreter used in SP Interview?' 
  FIALANG='Language of Family Interview' 
  FIAPROXY='Proxy used in Family Interview?' 
  FIAINTRP='Interpreter used in Family Interview?' 
  MIALANG='Language of MEC Interview' 
  MIAPROXY='Proxy used in MEC Interview?' 
  MIAINTRP='Interpreter used in MEC Interview?' 
  AIALANGA='Language of ACASI Interview' 
  DMDHHSIZ='Total number of people in the Household' 
  DMDFMSIZ='Total number of people in the Family' 
  DMDHHSZA='# of children 5 years or younger in HH' 
  DMDHHSZB='# of children 6-17 years old in HH' 
  DMDHHSZE='# of adults 60 years or older in HH' 
  DMDHRGND='HH ref person''s gender ' 
  DMDHRAGE='HH ref person''s age in years ' 
  DMDHRBR4='HH ref person''s country of birth ' 
  DMDHREDU='HH ref person''s education level ' 
  DMDHRMAR='HH ref person''s marital status ' 
  DMDHSEDU='HH ref person''s spouse''s education level ' 
  WTINT2YR='Full sample 2 year interview weight' 
  WTMEC2YR='Full sample 2 year MEC exam weight' 
  SDMVPSU='Masked variance pseudo-PSU' 
  SDMVSTRA='Masked variance pseudo-stratum' 
  INDHHIN2='Annual household income' 
  INDFMIN2='Annual family income' 
  INDFMPIR='Ratio of family income to poverty' 
  LBXHA='Hepatitis A antibody' 
  RIDAGEY1='Age in years at screening' 
  RIDAGEY2='Age in years at screening' 
 ;;;

format  RIDSTATR ridstatrf. RIAGENDR riagendrf. RIDRETH1 ridreth1f. RIDEXMON ridexmonf. DMQMILIZ dmqmilizf.
 DMQADFC dmqadfcf. DMDBORN4 dmdborn4f. DMDCITZN dmdcitznf. DMDYRSUS dmdyrsusf. DMDEDUC2 dmdeduc2f.
 DMDMARTL dmdmartlf. SIAPROXY siaproxyf. LBXHA lbxhaf. RIDAGEY1 ridageyrcat. RIDAGEY2 ridageyrcat2_.

 ;;;

format  SEQN BEST12. SDDSRVYR BEST8. RIDAGEYR BEST8. RIDAGEMN BEST8. RIDRETH3 BEST8.
 RIDEXAGM BEST8. DMDEDUC3 BEST8. RIDEXPRG BEST8. SIALANG BEST8. SIAINTRP BEST8.
 FIALANG BEST8. FIAPROXY BEST8. FIAINTRP BEST8. MIALANG BEST8. MIAPROXY BEST8.
 MIAINTRP BEST8. AIALANGA BEST8. DMDHHSIZ BEST8. DMDFMSIZ BEST8. DMDHHSZA BEST8.
 DMDHHSZB BEST8. DMDHHSZE BEST8. DMDHRGND BEST8. DMDHRAGE BEST8. DMDHRBR4 BEST8.
 DMDHREDU BEST8. DMDHRMAR BEST8. DMDHSEDU BEST8. WTINT2YR BEST10. WTMEC2YR BEST10.
 SDMVPSU BEST8. SDMVSTRA BEST8. INDHHIN2 BEST8. INDFMIN2 BEST8. INDFMPIR BEST10.
 AGE20_PL BEST8. DOM_MILI BEST9. AGE_15_6 BEST9.
  ;;; 
run;
 %let lib_error=&syserr.; 


proc printto print= "C:\NHANES III\SAS\data\xpt\clean_nhanes_SAScheck.lst" new; 

 title "data= C:\NHANES III\SAS\data\xpt\clean_nhanes: Compare results with Stata output."; 

 proc means    data= out.clean_nhanes; run;

 proc contents data= out.clean_nhanes; run;

 proc print    data= out.clean_nhanes (obs=5); run; 

 proc printto; run; 
