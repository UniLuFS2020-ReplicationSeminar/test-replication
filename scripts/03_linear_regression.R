###
# Replication Seminar 
# Session 9 - 22/04/2020
###

# install.packages("stargazer")
# install.packages("sjPlot")
load(file = here::here("data_recoded", 'dat_rec.Rdata'))


# Estimate a linear model in R using the lm()function.
# fit <- lm(formula, data)
fit1 <- lm(formula = party_ch_all_voters_t ~ emp_ch1_10, data = dat)
fit2 <- lm(formula = party_ch_all_voters_t ~ interpolated_expert_ch1_10, data = dat)
fit3 <- lm(formula = party_ch_all_voters_t ~ emp_ch1_10 + interpolated_expert_ch1_10, data = dat)