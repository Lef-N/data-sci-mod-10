##Data Wrangling##

#Removing anything pre 2017 from energy data
quarterly_energy_2017 <- subset(quarterly_energy, Year %in% c(2017, 2018, 2019, 2020, 2021, 2022, 2023))

##Adding quarterly non-dom energy prices per quarter
quarterly_deaths_energy <- quarterly_deaths_industry %>% mutate(elec_avg = case_when(Quarter == "Q1 2017" ~ 10.55,
                                                                                     Quarter == "Q2 2017" ~ 10.38,
                                                                                     Quarter == "Q3 2017" ~ 10.38,
                                                                                     Quarter == "Q4 2017" ~ 10.89,
                                                                                     Quarter == "Q1 2018" ~ 11.06,
                                                                                     Quarter == "Q2 2018" ~ 11.12,
                                                                                     Quarter == "Q3 2018" ~ 11.35,
                                                                                     Quarter == "Q4 2018" ~ 11.94,
                                                                                     Quarter == "Q1 2019" ~ 12.42,
                                                                                     Quarter == "Q2 2019" ~ 11.61,
                                                                                     Quarter == "Q3 2019" ~ 11.68,
                                                                                     Quarter == "Q4 2019" ~ 13.25,
                                                                                     Quarter == "Q1 2020" ~ 13.66,
                                                                                     Quarter == "Q2 2020" ~ 12.70,
                                                                                     Quarter == "Q3 2020" ~ 12.22,
                                                                                     Quarter == "Q4 2020" ~ 13.56,
                                                                                     Quarter == "Q1 2021" ~ 14.09,
                                                                                     Quarter == "Q2 2021" ~ 12.87,
                                                                                     Quarter == "Q3 2021" ~ 13.22,
                                                                                     Quarter == "Q4 2021" ~ 17.04,
                                                                                     Quarter == "Q1 2022" ~ 17.45,
                                                                                     Quarter == "Q2 2022" ~ 18.63,
                                                                                     Quarter == "Q3 2022" ~ 21.52,
                                                                                     Quarter == "Q4 2022" ~ 24.06,
                                                                                     Quarter == "Q1 2023" ~ 23.66,
                                                                                     Quarter == "Q2 2023" ~ 27.26
)
) %>%
  mutate(gas_avg = case_when(Quarter == "Q1 2017" ~ 2.13,
                             Quarter == "Q2 2017" ~ 2.13,
                             Quarter == "Q3 2017" ~ 2.04,
                             Quarter == "Q4 2017" ~ 1.98,
                             Quarter == "Q1 2018" ~ 2.19,
                             Quarter == "Q2 2018" ~ 2.36,
                             Quarter == "Q3 2018" ~ 2.44,
                             Quarter == "Q4 2018" ~ 2.46,
                             Quarter == "Q1 2019" ~ 2.45,
                             Quarter == "Q2 2019" ~ 2.30,
                             Quarter == "Q3 2019" ~ 2.25,
                             Quarter == "Q4 2019" ~ 2.33,
                             Quarter == "Q1 2020" ~ 2.41,
                             Quarter == "Q2 2020" ~ 2.20,
                             Quarter == "Q3 2020" ~ 2.19,
                             Quarter == "Q4 2020" ~ 2.31,
                             Quarter == "Q1 2021" ~ 2.30,
                             Quarter == "Q2 2021" ~ 2.40,
                             Quarter == "Q3 2021" ~ 2.91,
                             Quarter == "Q4 2021" ~ 3.98,
                             Quarter == "Q1 2022" ~ 3.93,
                             Quarter == "Q2 2022" ~ 4.77,
                             Quarter == "Q3 2022" ~ 6.54,
                             Quarter == "Q4 2022" ~ 5.81,
                             Quarter == "Q1 2023" ~ 7.03,
                             Quarter == "Q2 2023" ~ 5.86
  )
  ) %>%
  na.omit

#Checking totals make sense and we didn't miss any numbers with all the hard coding
sum(quarterly_deaths_energy$gas_avg) #811.7
sum(quarterly_energy_2017$Gas..Average..Pence.per.kWh.) #81.7
sum(quarterly_deaths_energy$elec_avg) #378.57
sum(quarterly_energy_2017$Electricity..Average..Pence.per.kWh.) #378.57

#Changing to long
quarterly_deaths_energy_long <- gather(quarterly_deaths_energy, key = "industry", value = "deaths",
                                       Agriculture..forestry.and.fishing, Production, Construction, Motor.trades,
                                       Wholesale, Retail, Transportation.and.storage, Accommodation.and.food.services,
                                       Information.and.communication, Finance.and.insurance, Real.estate,
                                       Professional..scientific.and.technical.activities,
                                       Business.administration.and.support.services, Education,
                                       Health.and.social.care, Arts..entertainment..recreation.and.other.services,
) %>%
  select (elec_avg, gas_avg, Quarter, industry, deaths)

#Create indices of deaths, energy prices, with a baseline of 2017
business_energy_dx <- quarterly_deaths_energy_long %>% 
  group_by(industry) %>% 
  mutate (change_deaths = deaths*100/deaths[Quarter=="Q1 2017"],
          change_elec = elec_avg*100/elec_avg[Quarter=="Q1 2017"],
          change_gas = gas_avg*100/gas_avg[Quarter=="Q1 2017"]) %>% 
  ungroup()

#Shapiro test - Not normal
shapiro.test(business_energy_dx$change_deaths)
shapiro.test(business_energy_dx$change_elec)
shapiro.test(business_energy_dx$change_gas)

#Inspection of deaths data - Not normal
deaths_qq <- ggqqplot(business_energy_dx$change_deaths)
elec_qq <- ggqqplot(business_energy_dx$change_elec)
gas_qq <- ggqqplot(business_energy_dx$change_gas)

#Changing Quarter column to a date format 

business_energy_dx$Quarter <- gsub('\\s+', '/', business_energy_dx$Quarter #To make it easier to format
)
business_energy_dx <- business_energy_dx %>% mutate(date = as.Date(as.yearqtr(Quarter, format = "Q%q/%Y"))) #Formatting
