# Phylogeography Density Plots

#### Purpose: Generate density plots from BEAST phylogeography logfiles with Bayes Factor (BF) threshold

User can run `densityplot.R` which calls the functions present in `bayesian_functions.R`, creating intermediary files, or run `densityplot_nointermediaryfiles.R` which only creates the final density plot files and spreadsheet with rate values filtered with BF.

Hint: If the user only wants to calculate BF, he can simply run the function `calculateBF` in `bayesian_functions.R` which calculates a Bayes Factor approximation (as implemented in [SpreaD3](https://academic.oup.com/mbe/article/33/8/2167/2579258)).

### Manual:

Function on `densityplot_nointermediaryfiles.R`:

`densityplotfromlogfile(logfile,burninpercentage,locations,traitname, BFthreshold, colorscheme)`

Input:

logfile <- BEAST phylogeography logfile;

burninpercentage <- number from 0-100;

locations <- list of locations;

traitname <- trait from phylogeography;

BFthreshold <- numeric value for Bayes Factor threshold;

colorscheme <- one of the colorschemes from RColorBrewer.

Output:

Product of rates and indicators filtered by BF threshold in CSV format;

Density plots in PDF format.



Functions on `bayesian_functions.R`:

`rateextract(logfile,burningpercentage,locations,traitname)`

Input:

logfile <- BEAST phylogeography logfile;

burninpercentage <- number from 0-100;

locations <- list of locations;

traitname <- trait from phylogeography.

Output:

Product of rates and indicators in CSV format.



`calculateBF(logfile,burninpercentage,locations,traitname)`

Input:

logfile <- BEAST phylogeography logfile;

burninpercentage <- number from 0-100;

locations <- list of locations;

traitname <- trait from phylogeography.

Output:

Transitions and BFs in CSV format.


`filterrates(BFlist,rates,BFthreshold)`

Input:

BFlist <- output from calculateBF;

rates <- output from rateextract;

BFthreshold <- numeric value for Bayes Factor threshold.

Output:

Product of rates and indicators filtered by BF threshold in CSV format.


`plotmigrationevents(plotList,colorscheme)`

Input:

plotList <- output from filterrates;

colorscheme <- one of the colorschemes from RColorBrewer.

Output:

Density plots in PDF format.

### Color schemes from R Color Brewer:
Sequential palettes (first list of colors), which are suited to ordered data that progress from low to high (gradient). The palettes names are : Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu YlOrBr, YlOrRd.

Qualitative palettes (second list of colors), which are best suited to represent nominal or categorical data. They not imply magnitude differences between groups. The palettes names are : Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3.

Diverging palettes (third list of colors), which put equal emphasis on mid-range critical values and extremes at both ends of the data range. The diverging palettes are : BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral

### Reference:

```
@article{hostager2019hepatitis,
  title={Hepatitis C virus genotype 1 and 2 recombinant genomes and the phylogeographic history of the 2k/1b lineage},
  author={Hostager, Reilly and Ragonnet-Cronin, Manon and Murrell, Ben and Hedskog, Charlotte and Osinusi, Anu and Susser, Simone and Sarrazin, Christoph and Svarovskaia, Evguenia and Wertheim, Joel O},
  journal={Virus Evolution},
  volume={5},
  number={2},
  pages={vez041},
  year={2019},
  publisher={Oxford University Press}
}
```
