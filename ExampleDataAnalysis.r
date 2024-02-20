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
#library(printr); # set limit on number of lines printed
library(broom); # allows to give clean dataset
library(dplyr); #add dplyr library
library(rio) #adds rio which allows import and export
library(survival); #time to event or survival data

options(max.print=500);
panderOptions('table.split.table',Inf); panderOptions('table.split.cells',Inf);

#' # Section 1

#' Creating Simulated Patient Demographic Data
# This is how you create simulated patient data for 25 patients from a start to end date using pipes
# Variables----
n_patients<-100
start_date_enrollment<-as.Date("2020-02-20")
end_date_enrollment<-as.Date("2020-08-03")
end_date_follow_up<-as.Date("2024-02-06")
#' # Functions
#Generate_event_old<-function(xx,threshold){(runif(xx)<threshold) %>% which() %>%
    #min() %>% ifelse(is.infinite(.),NA,.)}
#Generate_event_old (100,.25)

# Demographics dataframe ----
set.seed(Script_seed)
Demographics <-seq(start_date_enrollment,end_date_enrollment, by=1) %>% sample(.,n_patients,replace=TRUE) %>% 
  data.frame(
    id=seq_len(n_patients),
    Enrolled=.,
    #For 2/27 add a column for individual_end_date_followup that is exactly 2 years after Enrolled. Add integer to date
    Age=rnorm(n_patients, 65, 10),
    Sex=sample(c("M","F"),n_patients,replace=TRUE),
    Race=sample(c("White","Hispanic, or Latino","Black","American Indian, Aleutian, or Eskimo",
                  "Hawaiian or Pacific Islander","Other Asian","Other","Unknown"),
                n_patients,replace=TRUE,prob=c(0.6,0.18,0.13,0.06,0.01,0.01,0.02,0)),
    Baseline_risk=rnorm(n_patients, 0.001,0.001)%>% abs()
    

    
  ) %>% 
  mutate(DOB=Enrolled-Age,
         Final_risk=Baseline_risk*ifelse(Sex=="F",0.8,1),
         # asnumeric converts the number of follow ups a number format, 
         # runif generates a list of uniform distribution (between 0 and 1) for each day they are enrolled. and the <final_risk returns a boolean. 
         # Which then tells us the position and min takes the lowest position  If there is no True events piped into which then it returns infite which we need to account for
         #Day_of_progression=as.numeric(end_date_follow_up-Enrolled) %>% 
           #mapply(Generate_event,.,Final_risk)
         # Day_of_progression=ifelse(is.infinite(Day_of_progression),NA,Day_of_progression)
         Day_of_progression=(rgeom(n=n(),prob=Final_risk)+1),
         #temp_Day_of_progression=Day_of_progression+Enrolled,
         #end_date_follow_up=end_date_follow_up,
         Day_of_progression=ifelse(Enrolled+Day_of_progression>end_date_follow_up,NA,Day_of_progression)
           );
survfit(Surv(Day_of_progression)~Sex,data=Demographics) %>% plot()




#' # Section 2

#' Creating Simulated Patient Progression and Overall Survival Data
# Assuming p=50% risk of progression in a year, we can calculate the risk per day 
1-(0.5)^(1/365)
#This frequency (0.00189) is equal to 1 in 500 odds



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



