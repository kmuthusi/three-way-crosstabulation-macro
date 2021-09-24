capture program drop sas_rep
program define sas_rep, rclass
di as err " SAS failed to create clean_nhanes " 
di as err " Look at {view C:\NHANES III\SAS\data\xpt\clean_nhanes_infile.log:C:\NHANES III\SAS\data\xpt\clean_nhanes_infile.log} to see what error occurred. " 
local sas_rep_error= 1 
return local sas_rep_error "`sas_rep_error\'" 
end
