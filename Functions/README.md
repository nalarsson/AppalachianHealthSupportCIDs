# Functions for Climate Impact Driver index calculations are in the "ClimateCalculations" folder
# Functions run best using R's "apply" functions parallelized across multiple console cores
#
# Setup Files:
# "analysisSetup.R" includes all libraries and variables needed to run the functions
# "hindcastDataRetrieval.R" generates specifically hindcast CSV years to make analysis easier (may be useful to have)
# "makeLocationCSV.R" generates the overarching list of locations and coordinates. Edit this R script to
# append/change the locations of interest for the functions to run. 
# 
# ALL FUNCTIONS ARE WRITTEN BASED OFF OF THE LOCATION CSV FILE
# FILE PATHS WILL NEED TO BE EDITED FOR EACH UNIQUE MACHINE
#