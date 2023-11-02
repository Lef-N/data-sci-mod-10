#Visualisation via line chart of industry deaths
industry_deaths_lc <- business_energy_dx %>% ggplot(aes(x=date, y=change_deaths, group=industry, color = industry)) +
  geom_line(lwd = 1.5) + 
  coord_cartesian(ylim= c(50, 500)) + #Ensuring scales remain the same across charts as we will be having them side by side
  ylab("Percentage Change in Enterprise Deaths") +
  xlab("Year") +
  labs (colour = "Industry") +
  scale_x_date(date_breaks = "1 year") +
  geom_vline(xintercept=as.numeric(business_energy_dx$date[c(15, 21)]),
             linetype=4, colour="black")

elec_change_lc <- business_energy_dx %>% ggplot(aes(x=date, y=change_elec)) +
  geom_line(lwd = 1.5) + 
  coord_cartesian(ylim= c(50, 500)) + #Ditto
  ylab("Percentage Change in Electricity Average Price") +
  xlab("Year") +
  scale_x_date(date_breaks = "1 year") + 
  geom_vline(xintercept=as.numeric(business_energy_dx$date[c(15, 21)]),
             linetype=4, colour="black")

gas_change_lc <- business_energy_dx %>% ggplot(aes(x=date, y=change_gas)) +
  geom_line(lwd = 1.5) + 
  ggtitle("Over time percentage change by Energy Type and Sector between 2017 - 2023 inclusive of quarters up to Q2 2023 (2017 equals 100%)") +
  coord_cartesian(ylim= c(50, 500)) + #Ditto
  ylab("Percentage Change in Gas Average Price") +
  xlab("Year") + 
  scale_x_date(date_breaks = "1 year") +
  geom_vline(xintercept=as.numeric(business_energy_dx$date[c(15, 21)]),
             linetype=4, colour="black")


deaths_gas_elec <- gas_change_lc + elec_change_lc + industry_deaths_lc + plot_layout(ncol = 1) #Side by side

deaths_int <- ggplotly(industry_deaths_lc) #Interactive Deaths
elec_int <- ggplotly(elec_change_lc) #Interactive Change in Electricity
gas_int <- ggplotly(gas_change_lc) #Interactive chage n Gas
