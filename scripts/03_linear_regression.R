###
# Replication Seminar 
# Session 9 - 22/04/2020
###

# install.packages("stargazer")
# install.packages("sjPlot")
library(tidyverse)
load(file = here::here("data_recoded", 'dat_rec.Rdata'))


# Estimate a linear model in R using the lm()function.
# fit <- lm(formula, data)
fit1 <- lm(formula = party_ch_all_voters_t ~ emp_ch1_10, data = dat)
fit2 <- lm(formula = party_ch_all_voters_t ~ interpolated_expert_ch1_10, data = dat)
fit3 <- lm(formula = party_ch_all_voters_t ~ emp_ch1_10 + interpolated_expert_ch1_10, data = dat)


# Creating a regression table ---------------------------------------------------------------------
stargazer::stargazer(fit1, fit2, fit3, 
                     type = "text",   # user style = "text" for printing the table in the console
                     style = "apsr") 

stargazer::stargazer(fit1, fit2, fit3, 
                     type = "html",    # this will create an html table (easy to copy/paste into Word)
                     style = "apsr",
                     out = here::here("output", "table1.html"))   # path where to store the table


# Predicting citizens perceptions (plot) ----------------------------------------------------------

dat$fitted <- predict(fit3)    # Store the fitted values
fit3$fitted.values             # (Same thing)

dat$resid <- resid(fit3)       # Store the residuals
fit3$residuals                 # (same thing)

# Diagnostics: inspect fitted values vs. residuals:
#    -> errors should be around 0 with constant variance
ggplot(dat, aes(x = fitted, y = resid)) + 
  geom_point() + 
  geom_smooth(method = "lm") +  
  theme_bw()

# (Same thing and more)
plot(fit3)

# Predict ------------------------------------------------------------------------------------------

# Based on model fit3, what is the average perception of a citizen for the party
# whose perceived position by an expert is between -2 and -1? 
# (Parties with positions against further EU integration)
dat$fitted <- predict(fit3)    # (same as before)
dat %>% 
  filter(interpolated_expert_ch1_10 < -1) %>% 
  summarize(mean_citizen_perception = mean(party_ch_all_voters_t), 
            mean_expert_perception = mean(interpolated_expert_ch1_10),
            mean_citizen_predicted_perception = mean(fitted))

# Would would be the predicted citizens'perception of a hypothetical party whose
# expert perception is 0 and the manifesto position is also 0, based on model fit3?
hypothetical_case <- tibble(
  interpolated_expert_ch1_10 = 0, 
  emp_ch1_10 = 0
)

predict(fit3, newdata = hypothetical_case)
# The predicted citizens' perception for such a party is 0.095.

# Predicted values with sjPLot----------------------------------------------------------
sjPlot::plot_model(fit3, type = "pred", terms = "emp_ch1_10")
sjPlot::plot_model(fit3, type = "pred", terms = "interpolated_expert_ch1_10")

