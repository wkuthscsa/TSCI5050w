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
#Data Columns

Data_columns<- c(
  start='Enrolled',
  followup='Individual_end_date_follow_up',
  dob='DOB',
  date1='Date_of_progression',
  date2='Date_of_death'
)

Covariates<-c(
  "Race","Sex"
  )


# Import data ----
#' # Import Data
#' 
#' 
#+ This is where we import data
dat0<-import(Inputdata) %>%
rename(any_of(Data_columns)) %>% 
  mutate(age=as.numeric((start-dob)/365.25),
         maxfollowup=as.numeric(followup-start),
         censor1=!is.na(date1),
         censor2=!is.na(date2),
         #event1 and event2 are days that have elapsed since enrollment
         event2=coalesce(as.numeric(date2-start),maxfollowup),
         event1=coalesce(as.numeric(date1-start),event2)
  )
         
head(dat0)

fit0<-survfit(Surv(event1,censor1)~Sex,dat0)


c()
