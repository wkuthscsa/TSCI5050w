#'---
#' title: "TSCI 5050: ExampleDataAnalysis"
#' author: 'William Kelly'
#' date: "1/22/24"
#' abstract: |
#'  | Import data from RedCAP and create Kaplan Meyer Curves and then perform 
#'  | basic survival statistics on continuous variables with independent sample
#'  | data.
#' documentclass: article
#' description: 'Manuscript'
#' clean: false
#' self_contained: true
#' number_sections: true
#' keep_md: true
#' fig_caption: true
#' output:
#'  html_document:
#'    toc: true
#'    toc_float: true
#'    code_folding: show
#' ---
#'
#+ init, echo=FALSE, message=FALSE, warning=FALSE
# init ----
# This part does not show up in your rendered report, only in the script,
# because we are using regular comments instead of #' comments
debug <- 0;
knitr::opts_chunk$set(
  echo = debug > -1,
  warning = debug > 0,
  message = debug > 0,
  class.output = "scroll-20",
  attr.output = 'style="max-height: 150px; overflow-y: auto;"'
)

library(ggplot2); # visualisation
library(GGally);
library(pander); # format tables
#library(printr); # set limit on number of lines printed
library(broom); # allows to give clean dataset
library(dplyr); #add dplyr library

options(max.print=500);
panderOptions('table.split.table',Inf); panderOptions('table.split.cells',Inf);




#' # Section 1

#' Date Formatting
# This is how you convert text string to standard date format
as.Date("1/22/2024","%m/%d/%Y")


#' # Section 2: Data Import
#' 
export(mtcars,"mtcars.xlsx")
Dt <- import("mtcars.xlsx")

