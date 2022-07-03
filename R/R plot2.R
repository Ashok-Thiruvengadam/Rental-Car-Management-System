library(ggplot2)
library(magrittr)
library(tidyr)
library(dplyr)
mydata2 <- mydata %>%
  group_by(city) %>% 
  summarise(Rental_duration = sum(Rental_duration))



#ggplot(data=secondplot, aes(x=reorder(City,number_of_rentals), y=number_of_rentals, group=1)) + 
 # geom_line(color="red")+
 # geom_point() + 
 # theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
 # ggtitle("Top rented cities based on pickup location") +
 # labs(x = 'City', y='Number of Reantals') +
#theme(panel.grid.major = element_blank(), 
    #  panel.grid.minor = element_blank()) 

ggplot(data=secondplot, aes(x=reorder(City,number_of_rentals), y=number_of_rentals))+
                              geom_bar(stat="identity", fill="purple") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("             Number of rentals per city") +
  labs(x = 'City', y='Number of Rentals') +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
    
