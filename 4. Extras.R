##Extras
#Deaths time series examination with the top 3 industries

business_corr_agr <- business_energy_dx %>% filter(industry == "Agriculture..forestry.and.fishing") %>% select (deaths)
business_corr_retail <- business_energy_dx %>% filter(industry == "Retail") %>% select (deaths)
business_corr_estate <- business_energy_dx %>% filter(industry == "Real.estate") %>% select (deaths)


business_ts_agr <- ts(business_corr_agr, start=c(2017), end=c(2023, 2), frequency = 4)
business_ts_retail <- ts(business_corr_retail, start=c(2017), end=c(2023, 2), frequency = 4)
business_ts_estate <- ts(business_corr_estate, start=c(2017), end=c(2023, 2), frequency = 4)
business_ts_agr
business_ts_retail
business_ts_estate

mk_agr <- MannKendall(business_ts_agr)
mk_retail <- MannKendall(business_ts_retail)
mk_estate <- MannKendall(business_ts_estate)
summary(mk_agr)
summary(mk_retail)
summary(mk_estate)

plot(business_ts_agr)
plot(business_ts_retail)
plot(business_ts_estate)