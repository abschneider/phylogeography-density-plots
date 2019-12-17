# Phylogeography Density Plots

Generate density plots from BEAST phylogeography logfiles with Bayesian Factor threshold

Functions on bayesian_functions.R:

rateextract(logfile,burningpercentage,locations,traitname)

Input:

logfile <- BEAST phylogeography logfile
burninpercentage <- number from 0-100
locations <- list of locations
traitname <- trait from phylogeography

Output:

product of rates and indicators in CSV format

---------

Function:

calculateBF(logfile,burninpercentage,locations,traitname)

Input:

logfile <- BEAST phylogeography logfile
burninpercentage <- number from 0-100
locations <- list of locations
traitname <- trait from phylogeography

Output:

transitions and BFs in CSV format

---------

Function:

filterrates(BFlist,rates,BFthreshold)

Input:

BFlist <- output from calculateBFonly
rates <- output from rateextract
BFthreshold <- numeric value

Output:

product of rates and indicators filtered by BF threshold in CSV format

---------

Function:

plotmigrationevents(plotList,colorscheme)

Input:

plotList <- output from filterrates
colorscheme <- one of the colorschemes from RColorBrewer

# Color schemes from R Color Brewer:
Sequential palettes (first list of colors), which are suited to ordered data that progress from low to high (gradient). The palettes names are : Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu YlOrBr, YlOrRd.
Qualitative palettes (second list of colors), which are best suited to represent nominal or categorical data. They not imply magnitude differences between groups. The palettes names are : Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3.
Diverging palettes (third list of colors), which put equal emphasis on mid-range critical values and extremes at both ends of the data range. The diverging palettes are : BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral

