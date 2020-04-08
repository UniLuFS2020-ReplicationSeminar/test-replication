# Load data

library(tidyverse)

# dat <- readRDS("dat_toprocess.Rdata")
load(file = here::here("data_recoded", 'dat_toprocess.Rdata'))


# 1. Select only the three key variables (something else?)
dat <- as_tibble(dat)
dat %>% 
  select(party_ch_all_voters_t, emp_ch1_10, interpolated_expert_ch1_10) 

# 2. Drop missing values

# 3. Save

