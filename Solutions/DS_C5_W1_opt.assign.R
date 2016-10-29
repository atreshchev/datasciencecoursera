# DS_C5_W1_opt.assign
# Plotting of the relationship between payments & charges
# Very smart multiple plot: 
# https://s3.amazonaws.com/coursera-uploads/peer-review/-4ffSHNYEeWIfhKr_WcYsQ/78dfefc418eec84d25193fe953192421/plot2.pdf

DF <- read.table("data/payments_charges.csv", sep =  "," , header = TRUE) 
head(DF)
str(DF)


# 1. Make a plot that answers the question: 
#    what is the relationship between mean covered charges (Average.Covered.Charges) 
#    and mean total payments (Average.Total.Payments) in New York?
pdf(file = "plot1.pdf") # open device

DF_NY <- subset(DF, Provider.State == "NY")

model1 <- lm(Average.Total.Payments ~ Average.Covered.Charges, data = DF_NY)

model2 <- loess(Average.Total.Payments ~ Average.Covered.Charges, data = DF_NY)
model2 <- fitted(model2)
ord <- order(DF_NY$Average.Covered.Charges)

plot(DF_NY$Average.Covered.Charges, DF_NY$Average.Total.Payments,
     main = 'Summary of Spend in NewYork', xlab = 'Average Covered Charges', ylab = 'Average Total Payments',
     col = 'midnightblue')
  abline(model1, lwd = 2, lty = 2, col = "brown")
  lines(DF_NY$Average.Covered.Charges[ord], model2[ord], lwd = 2, lty = 2, col = "green")
  
dev.off() # turn off device


# 2. Make a plot (possibly multi-panel) that answers the question: 
#    how does the relationship between mean covered charges (Average.Covered.Charges) 
#    and mean total payments (Average.Total.Payments) vary by medical condition (DRG.Definition) 
#    and the state in which care was received (Provider.State)?
pdf(file = "plot2.pdf")

levels(DF$DRG.Definition) <- gsub(" -.*", "", unique(DF$DRG.Definition)) # rename medical conditions to make more manageable
statenames <- unique(DF$Provider.State) # extract unique instances of state and condition to store for looping
diseases <- unique(DF$DRG.Definition)

par(mar = c(0,0,0,0), oma = c(5,5,5,2), mfrow = c(6,6)) # open graphic device and sets plotting parameters
for (i in statenames) {
  for (j in diseases) {
    with(subset(DF, Provider.State == i & DRG.Definition == j),
         plot(Average.Covered.Charges, Average.Total.Payments, 
              xaxt = "n", yaxt = "n", col = rgb(0, 0, 0, 0.09), pch = 19,
              ylim = range(DF$Average.Total.Payments),
              xlim = range(DF$Average.Covered.Charges))
    )
    abline(lm(Average.Total.Payments ~ Average.Covered.Charges,
              subset(DF, Provider.State == i & DRG.Definition == j)), lwd = 2, col = "brown")
    coord <- par("usr") # get current plot margins' coordinates
    text(-2*coord[1], coord[4]*0.95, paste(i,j), adj = c( 0, 1 ), font = 2, cex = 1.2) # draw the text at top left position of the plot
    if (j == diseases[1])
      axis(side = 2) # draw y axis labels
    if (i == statenames[length(statenames)])
      axis(side = 1) # draw x axis labels
  } 
}
  mtext("Trends between Mean Covered Charges and Mean Total Payments\n by State & Medical Condition\n", 
        side = 3, line = 0, outer = TRUE, font = 2)
  mtext("Mean Covered Charges", side = 1, line = 3, outer = TRUE)
  mtext("Mean Total Payments", side = 2, line = 3, outer = TRUE)

dev.off()

