Visualizing Likert scale responses using __likert__ R package
========================================================

Diverging stacked bar chart is arguably the best way to plot Likert scale responses. I am using the **Likert** package to visualize responses of a survey on perception of climate change that I am carrying out for my PhD. This is the code I am using to generate the charts. I will update the code as I progress with my research.

The sample data used here is a dummy data and not the data from my research.

Required packages
-----------------
The required packages can be installed using the following commands.
```{r eval=FALSE}
install.packages("likert")
install.packages("xlsx")
```

Code
-----------

First step is to load the packages.
```{r}
require(xlsx) #only if excel file is to be read
require(likert)
```


Next step is to read the data and to process the data as factor.
```{r}
dataFile <- "C:/Users/Lenovo/Dropbox/Napier/PhD/Data Entry/randomData.xlsx"
myData.full <- read.xlsx(dataFile, sheetName = "Sheet2") #read excel sheet
#forcing NA
myData.full[] <- lapply(myData.full, function(x){replace(x, x == "NA", NA)})
myData <- myData.full[,c(-1,-2,-3)] #dropping first three columns
names(myData) <- c("1. Hotness of summer", "2. Coldness of winter",
                   "3. Length of summer", "4. Length of winter",
                   "5. Monsoon rainfall", "7. Winter rainfall",
                   "6. Monsoon river flow", "8. Winter river flow")
#factor levels defined in the data
textChoices <- c("Decreased a lot", "Decreased",
                 "Stayed same",  "Increased", "Increased a lot")
#columns to factor
for (i in 1:length(myData)) {
  myData[,i] <- factor(myData[,i], levels=textChoices)
}
```

Now to use the **likert** function.
```{r}
myLikert <- likert(myData)
```
And finally, generating the plots.
```{r fig.width=8, fig.height=5}
plot(myLikert, low.color="darkslategray4", neutral.color="gainsboro",
     high.color="firebrick", ordered=FALSE,
     panel.arrange = "h") +
  ggtitle("How has the following changed in the past 5 years?")
```
![R plot](Plots/Rplot01.png)

For density plots for individual responses.
```{r fig.width=8, fig.height=16}
plot(myLikert, type="density")
```
![R plot](Plots/Rplot02.png)

Density plot for all resposes in one graph.
```{r fig.width=10, fig.height=5}
plot(myLikert, type="density", facet=FALSE)
```
![R plot](Plots/Rplot03.png)


Grouping of responses
---------------

Grouping the responses according to gender.
```{r fig.width=10, fig.height=7}
myLikert.gen <- likert(myData, grouping=myData.full$Gender)
plot(myLikert.gen, low.color="darkslategray4", neutral.color="gainsboro",
     high.color="firebrick", ordered=FALSE,
     panel.arrange = "v")
```

![R plot](Plots/Rplot04.png)

Grouping the responses according to location.
```{r fig.width=10, fig.height=16}
myLikert.loc <- likert(myData, grouping=myData.full$Location)
plot(myLikert.loc, low.color="darkslategray4", neutral.color="gainsboro",
     high.color="firebrick", ordered=FALSE)
```

![R plot](Plots/Rplot05.png)