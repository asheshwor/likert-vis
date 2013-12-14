#* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#*     Load packages
#* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
require(xlsx) #only if excel file is to be read
require(likert)
#* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#*     Reading data
#* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
dataFile <- "C:/Users/Lenovo/Dropbox/Napier/PhD/Data Entry/randomData.xlsx"
myData <- read.xlsx(dataFile, sheetName = "Sheet1") #read excel sheet
#* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#*     Preparing data
#* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
myData <- myData[,-1]
myData <- data.frame(myData)
names(myData) <- c("1. Hotness of summer", "2. Coldness of winter",
                   "3. Length of summer", "4. Length of winter",
                   "5. Monsoon rainfall", "7. Winter rainfall",
                   "6. Monsoon river flow", "8. Winter river flow")
#factor levels defined in the data
textEntered <- c("Decreased a lot", "Decreased",
                 "Stayed same",  "Increased", "Increased a lot")
#factorize columns except for the first column which is ID
for (i in 1:length(myData)) {
  myData[,i] <- factor(myData[,i], levels=textEntered)
}
sumr <- likert(myData)
#png("likertPlot.png",1280,720)
plot(sumr, low.color="darkslategray4", neutral.color="gainsboro",
     high.color="firebrick", ordered=FALSE,
     panel.arrange = "h") +
  ggtitle("How has the following changed in the past 5 years?")
#dev.off()