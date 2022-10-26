library(tidyverse)

data <- read_csv("2021_Buckley.csv")

# list of species 
data %>%
  filter(substring(BirdCode,1,2)!='UN') %>%
  filter(BirdCode != "NOBI") %>%
  distinct(Species)

# species
data %>%
  filter(substring(BirdCode,1,2)!='UN') %>%
  filter(BirdCode != "NOBI") %>%
  summarise(n_species = n_distinct(Species))

# n individuals
data %>%
  filter(substring(BirdCode,1,2)!='UN') %>%
  filter(BirdCode != "NOBI") %>%
  summarise(n_indiv = n())

# of individuals per species
n.species <- data %>%
  filter(substring(BirdCode,1,2)!='UN') %>%
  filter(BirdCode != "NOBI") %>%
  group_by(Species) %>%
  summarise(n_indiv = n()) 

# start date
data %>%
  summarise(min(date))

# end data
data %>%
  summarise(max(date))

species <- read_csv("CPW_SpeciesStatus_Designations.csv")

data <- data %>%
  left_join(species)

data %>%
  select(Species, CPW_Designation) %>%
  filter(CPW_Designation != "NA") %>%
  distinct()

n.species <- n.species %>%
  left_join(species)

write.csv(n.species, file = "n.species.csv" )
