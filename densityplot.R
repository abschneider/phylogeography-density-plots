# File: densityplot_nointermediaryfiles.R
# Date created: 12/6/19
# Last update: 12/17/19 by Adriano Schneider
# Authors: Adriano Schneider

setwd("YOUR WORKING DIRECTORY")
setwd('/Users/schneider/GitHub/phylogeography-density-plots/')
source('bayesian_functions.R')
setwd('/Users/schneider/GitHub/phylogeography-density-plots/Example_files')


#### STEP 1 - CALCULATE BAYES FACTOR APPROXIMATION AND EXTRACT PRODUCT OF RATES AND INDICATORS AS TWO INDIVIDUAL CSV FILES ####

logfile = "example_phylogeo.log"
burninpercentage = 10
locations = scan("example_locations.txt",what="", sep="\n")
traitname = "City" #Name trait of interest

rateextract(logfile,burninpercentage,locations,traitname)
calculateBF(logfile,burninpercentage,locations,traitname)

#### STEP 2 - FILTER PRODUCT OF RATES AND INDICATORS USING BAYES FACTOR THRESHOLD ####

BFlist = "City.BFs.csv" # Output from calculateBF function
rates = "City.product.indicator.rates.csv" # Output from rateextract function
BFthreshold = 4 #Select minimum Bayes Factor threshold

filterrates(BFlist,rates,BFthreshold)

#### STEP 3 - BUILD DENSITY PLOTS WITH SELECT COLOR SCHEME

plotList = "City.filtered.product.indicator.rates.csv" #Output from filterrates function
colorscheme = "Dark2"

plotmigrationevents(plotList,colorscheme)
