### R Graphs here.
###
### P.S.: Need to divide the data by groups when plotting to exclude 'Simpson's paradox'
### (trend that appears in different groups of data disappears when these groups are combined)

heatmap(some_matrix) # orginize! & draw heatmap using hieararchial clustering by rows & columns values close together
image(some_matrix[, nrow(some_matrix):1]) # draw the heatmap of the the matrix with specified order of rows

## Graphical Decices
?Devices # see the list of graphical devieces: pdf/png/jpeg/tiff/bmp/... svg (xml-based scalable vector format)
dev.cur() # get the number-id of currently active device
dev.set(1) # set device 1 as the currently active 

dev.copy(png, file = "myplot.png", width=600, height=480) # copy plot to .png from the active device (with specified size)
dev.off()
dev.copy2pdf(file = "s.pdf")
dev.off()

quartz() # open an individual screen! device window on Mac (windows() - on Windows, x11() - on Linux)

png(filename = "Plot1.png", height = 480, width = 600)
dev.off() 

pdf(file = "myplot.pdf") # open the pdf device and create .pdf file in working directory
 plot(x, y, pch = 20) # draw into pdf device
 title("X and Y")
dev.off() # close the pdf device (file is created now)

dev.new(height = 5, width = 7) # set specified proportions for all future plots
dev.off() # drop current device and all 'par' settings


### The Base Plotting System
?par # all graphics functions parameters (as arguments)

par("col") # see setted value 
par(col = "green") # specify global! graphics parameters
# More useful parameters:
# las - orientation of the axis labels on the plot
# mar - margin sizes (bottom, left, top, right sides)
# oma - outer margin sizes (default = 0)
# mfrow - number of plots by row x col (going from left to right); can be used 'mfcol' - going from top to bottom
# pch - plotting symbol (as number/chr symbol)
# lty - line type: "solid", "dashed", "dotted", "dotdash", "longdash", "twodash", "blank" (invisible)
# lwd - line width (as integer)
# xlab - x-axis text label
# ylab - y-axis text label
# col - plotting color (as number/chr name/hexcode)
# bg - background colors

opar <- par() # make a copy of current settings
par(opar) # restore settings (may not be working if new device was created)

example(points) # different points-plotting parameters auto demonstration
demo ("colors") # different colors & its names demonstartion

colors() # get supported colors' character names
heat.colors(12, alpha = 1) # get the vector of 12 heat colors hex names
rainbow(12) # get the vector of 12 rainbow colors hex names
pie(rep(1, 12), col = rainbow(12)) # get the pie chart

rgb(0, 125, 255, 0.05) # get hex color with sparency level (alpha) = 0.05

library(grDevices)
pal <- colorRampPalette(c("red", "blue")) # create a special func to blend few colors (use integer argument as number of generated colors)
pie(rep(1, 12), col = pal(12)) # get gradient coloring

pal <- colorRamp(c("red", "blue")) # create a special func to blend few colors (use numeric argument from 0 to 1 to set special color intensity)
pal(0) # get the red color as RGB matrix row
pal(1) # get the blue color as RGB matrix row
pal(seq(0, 1, length = 10)) # get 10 blended colors as RGB matrix
rgb(pal(seq(0, 1, length = 10)), max = 255) # get hex names of 10 blended colors (it's necessary to use max = 255!)

library(RColorBrewer)
brewer.pal.info # get names of colors' palettes (incl. sequential, diverging and qualitative sets)
colors <- brewer.pal(3, "BuGn") # get 3 colors from specified Brewer's palette
pal <- colorRampPalette(colors) # create a special func to blend colors 
pie(rep(1, 12), col = pal(12)) # get gradient coloring
image(volcano, col = pal(20)) # get gradient coloring for sample image


## Plot (график)
plot(DF$vectval, type = "l", main = "Title here") # draw plot as "line" graphic (1)
plot(DF$vectval, type = "l", ylim = c(-3, 3)) # set y-axis visible diapason

plot(DF$vectval, type = "b") # draw points and lines!

plot(DF$vectval, type = "n") # draw empty plot
  lines(DF$vectval) # draw lines -- is the same as above (2)

plot(DF$vectval, type = "n") # draw empty plot
  points(DF$vectval, type = "l") # draw points as lines  -- is the same as above (3)

plot(DF$vectval, type = "l", xaxt = "n") # don't draw x-axes

plot(DF$date, DF$val, type = "l", axes = FALSE) # don't draw any axes
  axis(side = 2, at = 0:8) # set left axis parameters 
  axis.POSIXct(side = 1, at = seq(as.POSIXlt(min(dmy(data$Date))),
                                  as.POSIXlt(max(dmy(data$Date))), by = "days"), format="%a") # set below axis parameters for DATE
  box() # draw plot frame border

  text(x + 0.05, y + 0.05, labels = as.character(1:12)) # draw labels for each point (as numbers in this example)

plot(DF$year, DF$val, type = "b", xaxt = "n") # draw without x-axis labels (because of xaxt="n")
  axis(side = 1, at = DF$year, labels = PM$year) # draw only specified labels in specified ('at') points


## Scatterplot (диаграмма рессеивания)
with(DF, plot(vectlatitude, vectval)) # evaluate func in data environments (no need to use DF$... names)
  abline(h = 12, lwd = 2, lty = 2) # lty = 2 means a dotted line type

with(DF, plot(vectlatitude, vectval, col = vectregion)) # draw 'vectval' values by factor 'vectregion' using different colors
plot(DF$vectval, col = DF$vectregion) # another example with coloring by factor

with(DF, plot(Wind, Ozone)) # draw with default color (DF is 'airquality' in this example)
with(subset(DF, Month == 5), points(Wind, Ozone, col = "blue")) # redraw some points with specified color

with(airquality, plot(Wind, Ozone, type = "n")) # make the plot but do not! draw any points (only canvas/labels)
with(subset(DF, Month == 5), points(Wind, Ozone, col = "blue")) # draw points on the existing plot
with(subset(DF, Month != 5), points(Wind, Ozone, col = "green"))

  legend("topright", col = c("blue", "green"), pch = 1, legend = c("May", "Other months")) # draw the legend to the yet drawed plot
  legend("topright", col = c("blue", "green"), pch = 1, legend = c("May", "Other months"), bty = "n") # draw without legend box border ('bty')
  legend("topright", col = c("blue", "green"), lwd = 1, legend = colnames(data)[7:8]) # draw lines ('lwd') rather symbols in the legend
  legend('topright', col = c('black', 'red', 'blue'), c('Sub1', 'Sub2', 'Sub3'), lty = 1, cex = 1.5) # draw lines ('lty' is the same as 'lwd') & increased font size ('cex' is relative to par("cex"))
  legend("bottomleft", col = c("blue", "green", "red"), bty = "n", lwd = 2, 
         lty = c(1, 1, NA), pch = c(NA, NA, 8), legend = c("line1", "line2", "symbol here")) # draw different symbols in the legend
  legend("bottomright", col = unique(DF$activity), legend = unique(DF$activity), pch = 1)
  text(-2, -2, "Some text") # draw the text label with specified coordinates

with(DF, plot(wind, ozone, ann = FALSE)) # set off font style and set up it below with title()
  title(main = "Ozone and Wind in NY", ylab = "Ozone", xlab = "Wind",
        family = "serif", font = 2) # set specified font (may be "sans"/"serif"/"mono" and font 1:4 corresponding to normal(default)/bold/italic/bpld+italic))

with(DF, plot(Wind, Ozone, pch = 20)) # draw little points (pch = 20)

model <- lm(Ozone ~ Wind, DF) # get standard linear regression model! line
  abline(model, lwd = 2, lty = 2) # draw regression line

model <- loess(Average.Total.Payments ~ Average.Covered.Charges, data = NYdata) # get Local Polynomial regression fitting
model <- fitted(model) # extract model fitted values
ord <- order(NYdata$Average.Covered.Charges)
  lines(NYdata$Average.Covered.Charges[ord], model[ord], lwd = 2, lty = 2) # draw polynomial regression


x <- rnorm(10000)
y <- rnorm(10000)
plot(x, y, col = rgb(0, 0, 0, 0.05), pch = 19) # draw overlapping points with transparency level (alpha) = 0.05

library(RColorBrewer)
smoothScatter(x, y) # draw overlapping points with smoothing


## Multiple drawings
par(mfrow = c(1, 2)) # set options for drawings -- near each other (1 row x 2 cols)
  with(subset(DF, vectregion == "east"), plot(vectlatitude, vectval, main = "East")) 
  with(subset(DF, vectregion == "west"), plot(vectlatitude, vectval, main = "West")) 

par(mfrow = c(1, 3), mar = c(5, 4, 2, 1), oma = c(0, 0, 2, 0)) # decrease margins for more free space
with(DF, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in NY", outer = TRUE) # draw common! title
})

# Drawing table of scatterplots
par(mfrow = c(6,6), mar = c(0, 0, 0, 0), oma = c(5, 5, 6, 2))
for (i in statenames) {
  for (j in diseases) {
    with(subset(DF, Provider.State == i & DRG.Definition == j),
         plot(Average.Covered.Charges, Average.Total.Payments, 
              xaxt = "n", yaxt = "n", col = rgb(0, 0, 0, 0.09), pch = 19,
              ylim = range(DF$Average.Total.Payments),
              xlim = range(DF$Average.Covered.Charges))
    )
    abline(lm(Average.Total.Payments ~ Average.Covered.Charges,
              subset(DF, Provider.State == i & DRG.Definition == j)), lwd = 2, lty = 2, col = "brown")
    coord <- par("usr") # get current plot margins' coordinates
    text(-2*coord[1], coord[4]*0.95, paste(i,j), adj = c( 0, 1 ), font = 2, cex = 1.2) # draw the text at top left position of the plot
    if (j == diseases[1])
      axis(side = 2) # draw y axis labels
    if (i == statenames[length(statenames)])
      axis(side = 1) # draw x axis labels
  } 
}
    mtext("Trends between Mean Covered Charges\n and Mean Total Payments\n by State & Medical Condition\n", 
          side = 3, line = 0, outer = TRUE, font = 2)
    mtext("Mean Covered Charges", side = 1, line = 3, outer = TRUE)
    mtext("Mean Total Payments", side = 2, line = 3, outer = TRUE)

# Aligning of axis' ranges during multiple drawings (выравнивание масштабов осей)
rng <- range(DF1$vect, DF2$vect, na.rm = TRUE) # get the common range (maximum range)

par(mfrow = c(1, 2))
  plot(datesVect, DF1$vect, ylim = rng) # draw 2 plots with the same ranges below
    abline(h = median(DF1$vect, na.rm = TRUE))
  plot(datesVect, DF2$vect, ylim = rng)
    abline(h = median(DF2$vect, na.rm = TRUE))

# Connecting points of different data sets during multiple drawings in one! plot
plot(rep(1999, 100), DF_1999$val, xlim = c(1998, 2013)) # set all x values as 1999 and x-axis: 1999 through 2013
  points(rep(2012, 100), DF_2012$val) # set all x values as 2012
  segments(rep(1999, 100), DF_1999$val, rep(2012, 100), DF_2012$val) # draw (x1,y1)-(x2,y2) connecting lines



## Boxplot (диаграмма размахов/коробчатая - показывает количество(повторяемость) различных значений в выборке)
# The top and bottom lines of the box indicate the 25% and 75% quartiles of the data, 
# and the horizontal line in the box shows the 50% (median)
boxplot(DF$vectval, col = "blue")
  abline(h = 12) # draw additionally the line on the boxplot as a specified level (значимый уровень, например, допустимое значение)

boxplot(vectval ~ vectregion, data = DF, col = "blue",
        ylab = "Vectval", xlab = "Vectregion") # draw multiple boxplots (one boxplot of vectval for each vectregion value - as categorial! vector)

stripchart(vectval ~ vectregion, data = DF, method="stack", add = TRUE,
           pch = 1, col = "gray60", vertical = TRUE) # draw data points over the boxplot


## Histogram
hist(datesVector, "month") # draw the histogram deviding by months on x-axis

hist(DF$vectval, col = "green") # draw histogram: values <-> frequency (демонстрирует распределение)
rug(DF$vectval) # draw histogram with a rug ('коврик' значений переменной в виде засечек под шистошраммой - наглядно демонстрирует плотность реализации значений  определенных окрестностях)

hist(DF$vectval, col = "green", breaks = 100) # set discretisation (quantity) of hist bars (столбцов) 
  abline(v = 15, lwd = 2) # draw vertical line on the hist at value 15 with width = 2
  abline(v = median(DF$vectval, na.rm = TRUE), col = "magenta", lwd = 4) # draw one more (additionally) line on the hist

par(mfrow = c(2, 1), mar = c(4, 4, 2, 1)) # set options for the canvas for drawing multiple histograms -- under each other (2 rows x 1 col)
  hist(subset(DF, vectregion == "east")$vectval, col = "green") 
  hist(subset(DF, vectregion == "west")$vectval, col = "green")


## Barplot (столбчатая диаграмма)
barplot(table(DF$vectval), col = "wheat", main = "Number of Counties in Each Region")


## Spinning plot
# ...?



### The Lattice System
library(lattice)

trellis.par.set() # modify graphical parameters for fine control of all Trellis displays

p <- xyplot(y ~ x, data) # save the plot as a 'trellis' object
print(p) # draw the plot


## Plot (график)
xyplot()
dotplot() # draw dots as "violin strings"


## Scatterplot (диаграмма рассеивания)
xyplot(y ~ x, DF) # draw the basic scatterplot (need to use formula notation)

xyplot(y ~ x | f, DF) # draw y ~ x graphic for every level of f values
xyplot(y ~ x | f * g, DF) # draw y ~ x graphic for every level of f & g values

xyplot(valLife.Exp ~ valIncome | valRegion, data = DF,
       layout = c(4, 1)) # draw multiple (4) panel with scatterplots of valLife.Exp <-> valIncome dependence (in one row) with for corresponding Regions (as a condition/categorical vector)

splom() # draw scatterplots' matrix - like pairs() in Base Plotting System ...?


## Multiple drawings ('panels' in lattice)
DF <- data.frame(x = rnorm(75),
                 y = rbinom(75, 1000, 0.5),
                 f = factor(rep(0:2, each = 25), labels = c("Group 1", "Group 2", "Group 3")))
xyplot(y ~ x | f, DF) # draw plots by factor 'f' value from left to right & from the bottom to the top (as matrix 2 x 2 - by default)
xyplot(y ~ x | f, DF, layout = c(3, 1)) #  draw plots by factor 'f' from the left to the right (in 1 column)
xyplot(y ~ x | f, DF, layout = c(1, 3)) #  draw plots by factor 'f' from the top to the bottom (in 1 column)

# Custom panel function
xyplot(y ~ x | f, DF, panel =  function(x, y, ...) {
  panel.xyplot(x, y, ...) # first call the default panel function for 'xyplot'
  panel.abline(h = median(y, na.rm = TRUE), lty = 2) # add a horizontal line at the median on every plot
})

xyplot(y ~ x | f, DF, panel =  function(x, y, ...) {
  panel.xyplot(x, y, ...)
  panel.lmline(x,y, col = 2) # add a regression line on every plot
})


## Boxplot (диаграмма размахов/коробчатая)
bwplot() # box-and-whiskers plot
stripplot() # like a boxplot but with actual points

## Histogram
histogram()

## Barplot
#...?

## Spinning plot
# ...

# ...
levelplot() # for plotting "image" data
contourplot() # the same



### The ggplot2 System ("Shorten the distance from the mind to the page")
library(ggplot2)

g <- ggplot(DF, aes(x, y)) # generate empty plot - aesthetic mappings that describe how variables in the data are mapped to visual properties (aesthetics) of geoms
summary(g) # show summary of ggplot object
p <- g + geom_point() # draw points on the plot
print(p)

ggsave(file = "plot.png", p)

# Base
xlab("X label") # set lable (use as + to ggplot object)
ylab(expression(log[e] * X)) # set text label with mathematical fomulas' notation (with upper^ & downv symbols' drawing)
ylab(expression("log " * Var[2.5])) # set text label with mathematical fomulas' notation (with upper^ & downv symbols' drawing)
ggtitle("Title here")
labs(list(title = "Title", x = "X label", y = "Y label", color = "Legend title")) # may be just: labs(x = "X label")

?theme # func to modify theme settings for all future plots - like par() in the Base Plotting System
theme(legend.position = "left")
theme(panel.background = element_rect(colour = "pink"))
theme(plot.title = element_text(family = "Times", size = rel(2), # rel(n) - relative size (else - in pixels)
                                face = "bold", colour = "blue")) # font-families: "Avenir", "Times", "Helvetica" (default)
# element_text params:
# axis.title = ... 
# axis.text = ...
# legend.title = ...
# legend.text = ...

theme_gray() # set default theme (use as + to ggplot object)
theme_bw()
theme_light(base_family = "Times", base_size = 12) # only 2 parameters are supported
            
        
# Plot (график)
qplot(x, data = DF, geom = "density") # draw density function graphic ('функция плотности')
qplot(log(x), data = DF, geom = "density")
qplot(log(x), data = DF, geom = "density", color = y) # draw many density graphics in one plot for each 'y' value

ggplot(DF, aes(x, y)) + geom_line() + ylim(-3, 3) # set y-axis visible values' diapason 
ggplot(DF, aes(x, y)) + geom_line() + coord_cartesian(ylim = c(-3, 3)) # the same


## Scatterplot (диаграмма рассеивания)
qplot(x, y, data = DF)

data(mpg) # load sample data set
qplot(displ, hwy, data = mpg) # draw scatterplot where X = 'displ', Y = 'hwy'
qplot(displ, hwy, data = mpg) + geom_point(color = "steelblue", size = 4, alpha = 0.5)  # set color, size & sparency level

qplot(displ, hwy, data = mpg, color = drv) # draw by factor (each value) 'drv' using different colors 
qplot(displ, hwy, data = mpg) + geom_point(aes(color = drv), size = 3, alpha = 0.5) # the same with sparency
qplot(displ, hwy, data = mpg, shapes = drv) # use different ponts' shapes by factor 'drv'

qplot(displ, hwy, data = mpg, geom = c("point", "smooth")) # add the trend

ggplot(DF, aes(x, y, color = z)) + geom_point() +  geom_line() # draw points & lines by factor 'z'

qplot(x, y, data = DF) + geom_smooth() # add non linear smoother (regression)
qplot(x, y, data = DF, color = z) + geom_smooth(method = "lm") # add linear regressions by factor 'z' (in one plot) with confidence levels ('доверительные интервалы')

ggplot(DF, aes(x, y)) + geom_point(aes(color = z)) + geom_smooth() # the same as above but with non linear regression
ggplot(DF, aes(x, y)) + geom_point(aes(color = z)) + geom_smooth(method = "lm")
ggplot(DF, aes(x, y)) + geom_point(aes(color = z)) + geom_smooth(method = "lm", se = FALSE) # turn off confidence levels
ggplot(DF, aes(x, y)) + geom_point(aes(color = z)) + geom_smooth(method = "lm", size = 4, linetype = 3) +

ggplot(DF, aes(x, y)) + geom_point(aes(color = z))


## Histogram
qplot(displ, hwy, data = mpg, fill = drv) # draw colored by each value of 'drv' histogram


## Multiple drawings ('facets' in ggplot2)
qplot(displ, hwy, data = mpg, facets = . ~ drv) # draw 3 scatterplots in 1 row ('.' means default settings) for data separated by 'drv' values

qplot(displ, hwy, data = mpg, facets = drv ~ .,
      bindwidth = 2) # draw 3 histograms in 3 rows (because data separated by 'drv' values) & in 1 column (see '.'); 'bindwidth' sets bars' width

qplot(x, y, data = DF, facets = . ~ z) + geom_smooth(method = "lm") # draw separate facets of scatterplot for each value of "z" & add linear regressions in corresponding facets
qplot(x, y, data = DF, facets = . ~ z, geom = c("point", "smooth"), method = "lm") # the same separation but with black color only

ggplot(DF, aes(x, y)) + geom_point() + facet_grid(. ~ z) # the same as above
ggplot(DF, aes(x, y)) + geom_point() + facet_wrap(f ~ z, nrow = 2, ncol = 5) # multiple plots for each f~z values' combination

ggplot(DF, aes(x, y)) + geom_point() + facet_grid(. ~ z) +
  geom_text(data = data.frame(x = c(2002, 2002), y = c(65, 1400), # specified coord of text comments for two facets 
                              label = c("66% Reduction: 1999-2008","34% Reduction: 1999-2008"), 
                              County = c("Baltimore","Los Angeles")),
            aes(x, y , label = label), inherit.aes = FALSE) # draw individual text comments on two facets

plot1 <- 


### Plot_ly Interactive System
### Examples: https://plot.ly/r
# signup(username, email, save = TRUE) # to register as new user and get the API key
library(plotly)
Sys.setenv("plotly_username" = "atreshchev")
Sys.setenv("plotly_api_key" = "wu6bv19l9k")

## Plot (basic)
data <- data.frame(x = c(1:100), random_y = rnorm(100, mean = 0))

p <- plot_ly(data, x = ~x, y = ~random_y, type = 'scatter', mode = 'lines')
p

plotly_IMAGE(p, width = 600, height = 480, format = "png", scale = 1, "myplot2.png")

## Plot (basic multiple graphs in one plot)
data <- data.frame(x = c(1:100), trace_0 = rnorm(100, mean = 5), trace_1 = rnorm(100, mean = 0), 
                   trace_2 = rnorm(100, mean = -5), trace_3 = sample(c(-5, -5.5), 100, replace = TRUE))

plot_ly(data, x = ~x, y = ~trace_0, name = 'trace 0', type = 'scatter', mode = 'lines') %>%
  add_trace(y = ~trace_1, name = 'trace 1', mode = 'lines+markers') %>%
  add_trace(y = ~trace_2, name = 'trace 2', mode = 'markers') %>%
  add_trace(y = ~trace_3, name = 'trace 3', 
            line = list(color = 'rgb(205, 12, 24)', width = 4, dash = "dash")) %>% # can use dash = "dash" too
  layout(title = "Sample traces", xaxis = list(title = "Some obs."), yaxis = list(title = "Temperature (degrees C)"))

# Plot (Density)
dens <- with(diamonds, tapply(price, INDEX = cut, density))
df <- data.frame(x = unlist(lapply(dens, "[[", "x")), y = unlist(lapply(dens, "[[", "y")),
                 cut = rep(names(dens), each = length(dens[[1]]$x)))

plot_ly(df, x = ~x, y = ~y, color = ~cut) %>%
  add_lines()


## Scatterplot
set.seed(100)
d <- diamonds[sample(nrow(diamonds), 1000), ]
plot_ly(d, x = ~carat, y = ~price, size = ~carat, color = ~carat, text = ~paste("Clarity: ", clarity))

# ggplotly2 interactive visualization
p <- ggplot(data = d, aes(x = carat, y = price)) +
  geom_point(aes(text = paste("Clarity:", clarity))) +
  geom_smooth(aes(colour = cut, fill = cut)) + facet_wrap(~ cut)
ggplotly(p)


## 3D Scatterplot
set.seed(123)

n <- 100
theta <- runif(n, 0, 2*pi)
u <- runif(n, -1, 1)
x <- sqrt(1 - u^2)*cos(theta)
y <- sqrt(1 - u^2)*sin(theta)
z <- u

plot_ly(x = x, y = y, z = z, type = "scatter3d", mode = "markers", color = z) %>% 
  layout(title = "Layout options in a 3d scatter plot",
         scene = list(
           xaxis = list(title = "Cos"), 
           yaxis = list(title = "Sin"), 
           zaxis = list(title = "Z")))


## 3D WebGL
plot_ly(z = ~volcano, type = "surface")


## Filled area plots
## Range sliders & selectors
## Horizontal Bar Charts
## Pie charts
## Dashboards
## ...

