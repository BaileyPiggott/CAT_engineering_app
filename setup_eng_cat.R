# set up data frames

library(magrittr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(grid)# load libraries


# load data and tidy ------------

all_eng_cat <- read.csv("ENG CAT 1-2.csv") %>% select(-year) #consenting CAT scores with disciplines

eng_1 <- all_eng_cat %>% 
  filter(course == 101) %>%
  select(studentid, discipline, score) %>%
  mutate(year = 1)

eng_2 <- all_eng_cat %>% 
  filter(course == 200) %>%
  select(studentid, discipline, score) %>%
  mutate(year = 2)

all_eng <- bind_rows(eng_1, eng_2)


# discipline data frames  -------------------------------------------

mech <- all_eng %>% filter(discipline == "MECH-M-BSE") 

elec <- all_eng %>% filter(discipline == "ELEC-M-BSE") 

cmpe <- all_eng %>% filter(discipline == "CMPE-M-BSE") 

civl <- all_eng %>% filter(discipline == "CIVL-M-BSE") 

chee <- all_eng %>% filter(discipline == "CHEE-M-BSE") 

ench <- all_eng %>% filter(discipline == "ENCH-M-BSE") 

mine <- all_eng %>% filter(discipline == "MINE-M-BSE") 

geoe <- all_eng %>% filter(discipline == "GEOE-M-BSE") 

enph <- all_eng %>% filter(discipline == "ENPH-M-BSE") 

mthe <- all_eng %>% filter(discipline == "MTHE-M-BSE")


# ALL ENGINEERING ---------------------------------------------------------

all_eng <- all_eng %>% mutate(discipline = "Z_ENG") #start with Z so all eng is right of discipline

# all engineering sample sizes:
n_eng_1 <-  sum(with(all_eng, year == 1 & score > 1), na.rm = TRUE)  
n_eng_2 <-  sum(with(all_eng, year == 2 & score > 1), na.rm = TRUE) 
n_eng_3 <-  sum(with(all_eng, year == 3 & score > 1), na.rm = TRUE) 
n_eng_4 <-  sum(with(all_eng, year == 4 & score > 1), na.rm = TRUE) 

# need null data for 3rd year to plot properly:
fix <- data.frame(c(NA,NA,NA,NA), c(NA,NA,NA,NA), c(NA,NA,NA,NA),c(1,2,3,4))
colnames(fix) <- colnames(all_eng)

