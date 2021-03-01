# Phylogeography Density Plots

#### Purpose: Generate density plots from BEAST Bayesian Stochastic Search Variable Selection (BSSVS) logfiles with Bayes Factor approximation (BF) threshold

User can run `densityplot.R` which calls the functions present in `bayesian_functions.R`, creating intermediary files, or run `densityplot_nointermediaryfiles.R` which only creates the final density plot files and spreadsheet with rate values filtered with BF.

Hint: If the user only wants to calculate BF, he can simply run the function `calculateBF` in `bayesian_functions.R` which calculates a Bayes Factor approximation (as implemented in [SpreaD3](https://academic.oup.com/mbe/article/33/8/2167/2579258)).

Note: These scripts are currently being implemented at [StrainHub](strainhub.io) R package.

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

### How To Cite

If you used any of the current functions please cite the reference below.

=======

Text Citation:

```
Adriano de Bernardi Schneider, Colby T Ford, Reilly Hostager, John Williams, Michael Cioce, Ümit V Çatalyürek, Joel O Wertheim, Daniel Janies, StrainHub: A phylogenetic tool to construct pathogen transmission networks, Bioinformatics, btz646, https://doi.org/10.1093/bioinformatics/btz646
```

BibTex Citation:

```
@article{10.1093/bioinformatics/btz646,
    author = {de Bernardi Schneider, Adriano and Ford, Colby T and Hostager, Reilly and Williams, John and Cioce, Michael and Çatalyürek, Ümit V and Wertheim, Joel O and Janies, Daniel},
    title = "{StrainHub: A phylogenetic tool to construct pathogen transmission networks}",
    journal = {Bioinformatics},
    year = {2019},
    month = {08},
    abstract = "{In exploring the epidemiology of infectious diseases, networks have been used to reconstruct contacts among individuals and/or populations. Summarizing networks using pathogen metadata (e.g., host species and place of isolation) and a phylogenetic tree is a nascent, alternative approach. In this paper, we introduce a tool for reconstructing transmission networks in arbitrary space from phylogenetic information and metadata. Our goals are to provide a means of deriving new insights and infection control strategies based on the dynamics of the pathogen lineages derived from networks and centrality metrics. We created a web-based application, called StrainHub, in which a user can input a phylogenetic tree based on genetic or other data along with characters derived from metadata using their preferred tree search method. StrainHub generates a transmission network based on character state changes in metadata, such as place or source of isolation, mapped on the phylogenetic tree. The user has the option to calculate centrality metrics on the nodes including betweenness, closeness, degree, and a new metric, the source/hub ratio. The outputs include the network with values for metrics on its nodes and the tree with characters reconstructed. All of these results can be exported for further analysis.strainhub.io and https://github.com/abschneider/StrainHub}",
    issn = {1367-4803},
    doi = {10.1093/bioinformatics/btz646},
    url = {https://doi.org/10.1093/bioinformatics/btz646},
    eprint = {http://oup.prod.sis.lan/bioinformatics/advance-article-pdf/doi/10.1093/bioinformatics/btz646/29171171/btz646.pdf},
}
```
=======

Additionally, if you use the _plotmigrationevents_ function also cite the reference below:

Text Citation:

```
Hostager, Reilly, et al. "Hepatitis C virus genotype 1 and 2 recombinant genomes and the phylogeographic history of the 2k/1b lineage." Virus evolution 5.2 (2019): vez041.
```

BibTex Citation:

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
