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
         #date1 is progression, date2 is death
         censor1=!is.na(date1),
         censor2=!is.na(date2),
         censor3=case_when(!is.na(date1)~"progressed",
                           !is.na(date2)~"died",
                           TRUE~"censored"
                           ) %>% factor(levels=c("censored","progressed","died")),
         #event1 and event2 are days that have elapsed since enrollment
         #censor is event occured, if occured=TRUE, if not =FALSE
         event2=coalesce(as.numeric(date2-start),maxfollowup),
         event1=coalesce(as.numeric(date1-start),event2)
  )
         
head(dat0)

fit0<-survfit(Surv(event1,censor1)~Sex,dat0)
summary(fit0) 
pander(fit0)
ggsurvplot(fit0,data=dat0)
#' Bells and whistles for plot
ggsurvplot(fit0,data=dat0,censor.size=10,risk.table=TRUE,conf.int=TRUE,palette=c("#FF00FF","blue"))
update(fit0,conf.int=0.9) %>% ggsurvplot(.,data=dat0,censor.size=10,risk.table=TRUE,conf.int=TRUE)
fitcr<-update(fit0,Surv(event1,censor3)~.)
plot(fitcr,col=c("pink","limegreen","orange","lightblue"),lty=c(1,2,3,4))
legend("bottomright",legend=c("female progressed","male progressed","female died","male died"),
       title="Legend",
       bty="n",
       col=c("pink","limegreen","orange","lightblue"),
       lty=c(1,2,3,4)
       )
table(dat0$censor3)
print(fitcr)
c()
