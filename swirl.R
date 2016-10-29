# SWIRL
library(swirl)
packageVersion("swirl") # need to be 2.2.1 or later

install_from_swirl("R Programming")
install_from_swirl("Exploratory Data Analysis")

swirl() # run SWIRL
# name: Alexander

bye() # bye() to exit and save your progress
skip() # allows you to skip the current question.
play() # lets you experiment with R on your own; swirl will ignore what you do... 
       # UNTIL you type nxt() which will regain swirl's attention.
main() # returns you to swirl main menu.
info() # displays these options again.

help.start() # open a menu of resources if you'd like more information on a particular topic related to R