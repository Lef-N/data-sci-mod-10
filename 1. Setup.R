##Setup##
work_dir = setwd("C:/Users/NomLe/Desktop/Data Sci Mod 10") #Set your own working directory as needed
quarterly_deaths_industry = read.table(file = "clipboard", sep = "\t", header=TRUE) #Copied 'Deaths Industry Counts' sheet from 'Business demography, quarterly experimental statistics, UK' link: https://www.ons.gov.uk/businessindustryandtrade/business/activitysizeandlocation/datasets/businessdemographyquarterlyexperimentalstatisticsuk
quarterly_deaths_geography = read.table (file = "clipboard", sep = "\t", header = TRUE) #Copied 'Deaths Geography' sheet from 'Business demography, quarterly experimental statistics, UK' link: https://www.ons.gov.uk/businessindustryandtrade/business/activitysizeandlocation/datasets/businessdemographyquarterlyexperimentalstatisticsuk
quarterly_energy = read.table (file = "clipboard", sep ="\t", header = TRUE) #Copied ''3.4.1' sheet from table 3.4.1 in https://assets.publishing.service.gov.uk/media/5a822cf140f0b62305b92e1a/QEP_March_2017_Tables_Annex.pdf

#Writing out above tables for use in future replications
write.csv(quarterly_deaths_industry, file = "quarterly_deaths_industry.xlsx")
write.csv(quarterly_energy, file = "quarterly_energy.xlsx")
write.csv(quarterly_deaths_geography, file ="quarterly_deathsgeography.xlsx")

#Data paths for reading
path_deaths_ind = "C:/Users/NomLe/Desktop/Data Sci Mod 10/data-sci-mod-10/quarterly_deaths_industry.xlsx"
path_energy = "C:/Users/NomLe/Desktop/Data Sci Mod 10/data-sci-mod-10/quarterly_energy.xlsx"
path_deaths_geog = "C:/Users/NomLe/Desktop/Data Sci Mod 10/data-sci-mod-10/quarterly_deaths_geography.xlsx"

#Reading in from written out tables
quarterly_deaths_industry = read.table(file = path_deaths_ind, sep = "\t", header=TRUE) #Copied 'Deaths Industry Counts' sheet from 'Business demography, quarterly experimental statistics, UK' link: https://www.ons.gov.uk/businessindustryandtrade/business/activitysizeandlocation/datasets/businessdemographyquarterlyexperimentalstatisticsuk
quarterly_deaths_geography = read.table (file = path_energy, sep = "\t", header = TRUE) #Copied 'Deaths Geography' sheet from 'Business demography, quarterly experimental statistics, UK' link: https://www.ons.gov.uk/businessindustryandtrade/business/activitysizeandlocation/datasets/businessdemographyquarterlyexperimentalstatisticsuk
quarterly_energy = read.table (file = path_deaths_geog, sep ="\t", header = TRUE) #Copied ''3.4.1' sheet from table 3.4.1 in https://assets.publishing.service.gov.uk/media/5a822cf140f0b62305b92e1a/QEP_March_2017_Tables_Annex.pdf

##Turn off Sci Notation
options(scipen=999)

##Packages##
library(data.table)
library(tidyverse)
library(ggpubr)
library(ggplot2)
library(dplyr)
library(patchwork)
library(hrbrthemes)
library(dplyr)
library(purrr)
library(plyr)
library(readxl)
library(fable)
library(plotly)
library(ggrepel)
library(colorspace)
library(cowplot)
library(zoo)
library(lubridate)
library(ggcorrplot)
library(ggstatsplot)
library(Kendall)
