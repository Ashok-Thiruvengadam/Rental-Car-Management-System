plot_d <- thirdplot %>% 
  pivot_longer(cols=`2019`:`2020`,
               names_to="Year",values_to = "Number_of_rentals")

ggplot(plot_d) +
  geom_bar(position="dodge",aes(x=as.factor(Month), y=Number_of_rentals, fill=Year),stat="identity") +
  ggtitle("Rental comparison between 2019 & 2021") +
  labs(x = 'Month', y='Number of Rentals') +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())

