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
library(rio) #adds rio which allows import and export

options(max.print=500);
panderOptions('table.split.table',Inf); panderOptions('table.split.cells',Inf);

#' # Section 1

#' Creating Simulated Patient Demographic
# This is how you create simulated patient data for 25 patients from a start to end date using pipes
n_patients<-25
start_date<-as.Date("2023-02-20")
end_date<-as.Date("2023-08-03")
Demographics <-seq(start_date, end_date, by=1) %>% sample(n_patients, replace=TRUE) %>% 
  data.frame(
    id=seq_len(n_patients)
    ,Enrolled=.
    ,Age=rnorm(n_patients, 65, 10)) %>% 
    mutate(DOB=Enrolled-Age);



#' # Section 1

#' Date Formatting
# This is how you convert text string to standard date format
# as.Date("1/22/2024","%m/%d/%Y")


#' # Section 2: Data Import
#' 
# export(mtcars,"mtcars.xlsx"
# Dt <- import("mtcars.xlsx")

#' # Section 3:
#' Simulated Data Script Variables
# This is where we create our script variables


#' # Section 4:
#' Simulated Data Using Curly Brackets
# This is where we learn how to use curly brackets which ignore line ends and set the last expression to the entire curly bracket term

#{foo<-sqrt(25);
#  if(pi>-Inf) bar<-foo-2 else bar <-runif(1)
#bar
#}

# This is an example of a wrapped expression instead of piped
#' (sample(seq(start_date, end_date, by=1), n_patients, replace = true));



