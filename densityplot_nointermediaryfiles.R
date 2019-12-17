# File: densityplot_nointermediaryfiles.R
# Date created: 12/6/19
# Last update: 12/17/19 by Adriano Schneider
# Authors: Adriano Schneider, Reilly Hostager & Simon Dellicour

library(knitr)
library(tidyverse)
library(RColorBrewer)

densityplotfromlogfile <- function(logfile,burninpercentage,locations,traitname, BFthreshold, colorscheme) {
  print("Loading data...")
  N_traits = as.numeric(length(locations))
  locations = as.data.frame(locations) 
  burnin = as.numeric(burninpercentage)
  threshold = as.numeric(BFthreshold)
  log = read.table(logfile, header=T) 
  print("Removing burn-in...")
  log = log[(round((dim(log)[1]/100)*burnin)+1):dim(log)[1],] # to remove the burn-in

#Calculate product of rate and indicators
  print("Creating Product of rates and indicators empty matrix...")
  df <- data.frame(matrix(NA, nrow = dim(log)[1], ncol = 1))
  df <- as_tibble(df)
  print("Extracting rates and indicators from logfile...") 
  for (i in 1:dim(locations)[1]) { #for all locations in list of locations
    for (j in 1:dim(locations)[1]) { #and all locations in list of locations
      if (i != j) { #if location of i is different from location of j, extract rates from i to j from logfile and add column to matrix
        ratelabel = combine_words(c(traitname,".rates.",as.character(locations[i,]),".",as.character(locations[j,])), sep="", and="")
        index1 = match(ratelabel,names(log)) # has to be the column index of the transition rate from location i to j
        rateindex <- as_tibble(log[index1]) #transforms the current column from a list into a tibble
        indicatorslabel = combine_words(c(traitname,".indicators.",as.character(locations[i,]),".",as.character(locations[j,])), sep="", and="")
        index2 = match(indicatorslabel,names(log)) # has to be the column index of the transition rate from location i to j
        indicatorsindex <- as_tibble(log[index2]) #transforms the current column from a list into a tibble
        currentindex <- mapply('*',indicatorsindex,rateindex) #multiplies rates with indicators
        newlabel <- as.character(combine_words(c(as.character(locations[i,]),"to",as.character(locations[j,])),sep=".",and="")) 
        currentindex <- as_tibble(currentindex)
        currentindex <- currentindex %>% rename(!!newlabel := indicatorslabel) #relabel header with name of places only
        df <- cbind(df,currentindex) #joins the columnn 
      }}}
  print("Storing the product of rates and indicators...")
  productratesindicators <- subset(df, select = -1) #removes empty column from list
  print("Rates successfully extracted.")

#calculateBF is a function to calculate the Bayes Factor Approximation of BEAST BSSVS logfiles
  print("Creating BF empty matrix...")
  BFdata <- tibble("Transition" = character(),"BayesFactor" = numeric()) #creates empty BF tibble
  print("Calculating Bayes Factor Approximation...")
  for (i in 1:dim(locations)[1])
  {
    for (j in 1:dim(locations)[1])
    {
      if (i != j)
      {
        indicatorlabel = combine_words(c(traitname,".indicators.",as.character(locations[i,]),".",as.character(locations[j,])), sep="", and="")
        index1 = match(indicatorlabel,names(log)) # has to be the column index of the indicator for transition from location i to j
        p = sum(log[,index1]==1)/dim(log)[1]
        K = N_traits # K should be divided by 2 if "symetric" case
        q = (log(2)+K-1)/(K*(K-1))
        BF = (p/(1-p))/(q/(1-q))
        label <- as.character(combine_words(c(as.character(locations[i,]),"to",as.character(locations[j,])),sep=".",and="")) 
        BFdata <- add_row(BFdata,Transition = label, BayesFactor = BF)
      }
    }
  }

# Filter rates using Bayes Factor Approximation threshold
  BF = as_tibble(BFdata)
  print("Reducing BF matrix to selected threshold...")
  filteredBF = BF %>% filter(BayesFactor >= threshold)
  filteredBF = droplevels(filteredBF)  
  print("Creating last empty matrix...")
  df1 <- data.frame(matrix(NA, nrow = dim(rates)[1], ncol = 1))
  df1 <- as_tibble(df)
  print("Filtering rates of transitions to selected threshold...")
  for (i in 1:dim(filteredBF)[1]){
    test <- as.character(filteredBF$Transition[i]) #figure out how to extract transition...
    index = match(test,names(rates))
    filteredrate <- rates[,index]
    df1 <- cbind(df1,filteredrate)
  }
  df1 <- as.data.frame(subset(df1, select = -1)) #removes empty column from list
  write.csv(df1,file = combine_words(c(traitname,".filtered.product.indicator.rates.csv"), sep="", and=""),row.names=FALSE) #print column from list
  plotList = as.character(combine_words(c(traitname,".filtered.product.indicator.rates.csv"), sep="", and=""))

# Plot migration events from filtered rates
  for (plotName in plotList){
    cooPlot<-read.csv(plotName,sep=',')
    cList <- colorRampPalette(brewer.pal(dim(cooPlot)[2],colorscheme))(dim(cooPlot)[2])
    
    for (p in 1:dim(cooPlot)[2]) {
      d <- density(cooPlot[[p]][cooPlot[[p]]>0]) #Creates variable with density for all values above zero for each column
      z <- length(cooPlot[[p]][cooPlot[[p]]==0])/dim(cooPlot)[1] #
      plot(d,main=names(cooPlot[p]),xlab="Migration events",ylab="Density",xaxt="n",yaxt="n",xlim=c(0,max(d$x)),ylim=c(0,max(d$y,z)), cex.lab=1.25, cex.main=1.25)
      #plot(d,main=names(cooPlot[p]),xlab="Migration events",ylab="Density",xaxt="n",yaxt="n",xlim=c(0,12),cex.lab=1.25, cex.main=1.25) #option to replace max(cooPlot) with actual value for x axis limit so all plots look the same.
      polygon(d, col=cList[p], border=cList[p]) #Plots polygon with density values above zero, optional col for coloring and border for line coloring can be used
      rect(-0.1,0,0.1,z,col=cList[p]) #optional border=NA to remove border and have rectangle behind polygon(curve)
      axis(1,at=c(0,2,4,6,8,10,12),labels=c("0","2","4","6","8","10","12")) #Can increase the number if a higher number of migration events is observed
      axis(2,at=c(0.0,0.2,0.4,0.6,0.8,1.0),labels=c("0.0","0.2","0.4","0.6","0.8","1.0"))
      dev.copy(pdf,combine_words(c(names(cooPlot[p]),".pdf"),sep="",and=""))
      dev.off()
    }
  }
}

##### Input needed to run function above ####

setwd("YOUR PATH")

logfile = "example_phylogeo.log"
burninpercentage = 10
locations = scan("example_locations.txt",what="", sep="\n")
traitname = "City"
BFthreshold = 4
colorscheme = "Dark2"

densityplotfromlogfile(logfile,burninpercentage,locations,traitname, BFthreshold, colorscheme)

########################
