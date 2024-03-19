#'---
#' title: "TSCI 5050: ExampleDataAnalysis"
#' author: 'William Kelly'
#' date: "3/19/24"
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
Script_seed<-8675309
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
library(printr); # set limit on number of lines printed
library(broom); # allows to give clean dataset
library(dplyr); #add dplyr library
library(rio) #adds rio which allows import and export
library(survival); #time to event or survival data
library(survminer)
options(max.print=500);
panderOptions('table.split.table',Inf); panderOptions('table.split.cells',Inf);
panderOptions('missing','_')
panderOptions('table.alignment.default','left')
panderOptions('table.alignment.rownames','left')
Inputdata<-"Exported_Patient_Data.xlsx"
# Import data ----
#' # Import Data
#' 
#' 
#+ This is where we import data
dat0<-import(Inputdata)
#dat0
head(dat0)
#pander(head(dat0))




c()
