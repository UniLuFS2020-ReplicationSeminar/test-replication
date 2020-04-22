# Load data
library(tidyverse)

# dat <- readRDS("dat_toprocess.Rdata")
load(file = here::here("data_recoded", 'dat_toprocess.Rdata'))


# 1. Select only the three key variables (something else?)
dat <- as_tibble(dat)
dat <- dat %>% 
  select(party_ch_all_voters_t, emp_ch1_10, interpolated_expert_ch1_10, country_name, year, partyname) %>% 
  # 2. Drop missing values
  drop_na()

# 3. Save
save(dat, 
     file = here::here("data_recoded", "dat_rec.Rdata"))
