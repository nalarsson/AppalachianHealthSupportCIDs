The files in this folder show how to download data from NASA's NEX-GDDP Amazon Web Server.

To use the R files to download data:
- Use "GDDP_setup.R" to establish parameters like desired climate conditions, desired models, AND SPATIAL EXTENT (DEFAULT IS MIDATLATNIC REGION! CHANGE IF NECESSARY) 
- Use "GDDP_run.R", which calls "GDDP_setup.R", to download the data.

Note: Be sure to check filepaths so that data downloads in the proper place. Detailed comments are included in the code.

"ModelsUsed.txt" includes a list of all NEX-GDDP CMIP6 models used to complete the 2024 analysis, as well as a listed of models removed and reason for removal.
"gddp-cmip6-files.csv" includes the links required for data download.

Read the included NEX-GDDP Technical Note for data specifications.