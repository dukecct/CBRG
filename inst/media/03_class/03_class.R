library(tidyverse)
library(tidybiology)
data(proteins)

lm_df <- tibble(
  condition = factor(c("control", "control", "control", "treated", "treated", "treated"),
                     levels = c("control", "treated")),
  reading = c(1.2, 1.6, 0.9, 3.4, 3.1, 2.4)
)

lm_output <- lm(reading ~ condition, data = lm_df)
summary(lm_output)

lm_output$coefficients[1] - lm_output$coefficients[2]

lm_df %>%
  ggplot(aes(condition, reading)) +
  geom_boxplot() +
  geom_abline(intercept = lm_output$coefficients[1] - lm_output$coefficients[2],
              slope = lm_output$coefficients[2]) +
  geom_point(data = data.frame(x = c(1, 2), y = c(1.2333, 1.2333 + 1.7333)),
             aes(x = x, y = y),
             colour = "red", size = 5) +
  labs(x = "",
       y = "Reading") +
  theme_bw()
# save this and annotate in ppt
# import this modified image as a pang into this folder
ggsave(here::here("inst/media/03_class/regression_plot.png"))

# make and save plot WITHOUT the regression line
lm_df %>%
  ggplot(aes(condition, reading)) +
  geom_boxplot() +
  labs(x = "",
       y = "Reading") +
  theme_bw()
# save this and annotate in ppt
# import this modified image as a pang into this folder
ggsave(here::here("inst/media/03_class/regression_plot_simple.png"))

# regression model for `length` and `mass` for `proteins`
ggplot(proteins, aes(length, mass)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Length",
       y = "Mass") +
  theme_bw()
ggsave(here::here("inst/media/03_class/regression_plot_proteins.png"))

lm_proteins <- lm(mass ~ length, data = proteins)
summary(lm_proteins)
