library(ggplot2)
library(magrittr)
library(tidyr)
library(dplyr)
mydata2 <- mydata %>%
  group_by(car) %>% 
  summarise(Rental_duration = sum(Rental_duration))
  


  ggplot(data=mydata2, aes(x=reorder(car,Rental_duration), y=Rental_duration)) +
  geom_bar(stat="identity", fill="steelblue")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    ggtitle("Rental duration of cars") +
    labs(x = 'Car', y='Renatl Duration') +
    theme(panel.grid.major = element_blank(), 
                 panel.grid.minor = element_blank())+coord_flip()
  
    