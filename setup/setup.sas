
* create a working directory;
%let dir=C:\NHANES III\SAS;

* reference library with formats;
libname nhanes v9 "&dir.\data\xpt\";

* load formats file;
%include "&dir.\data\xpt\clean_nhanes_infile.sas";

* data steps ...;
options fmtsearch=(WORK nhanes.clean_ out.clean_nhanes library);

data clean_nhanes;
set out.clean_nhanes;
* format agecat5 AGECAT. agecat10 AGECATA.;
* condition;
run;

data nhanes.clean_nhanes;
set clean_nhanes;
run;
