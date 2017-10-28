# Setup -------------------------------------------------------------------

# Change as necessary
setwd("D:/mdsi/github/36102_iLab1/R")

library(tidyverse)

set.seed(19690720)

# Create a dummy data frame, with one column coming from a normal distribution
data <- tibble(group = factor("B", levels = c("A", "B")),
               value = rnorm(40, mean = 5, sd = 2)) %>%
    arrange(value)

# Cherry-pick some of the lower values for group A
data[seq(1, by = 4, length.out = 6),'group'] <- 'A'

# Plot the data
p <- ggplot(data) +
    geom_bar(aes(x = group,
                 y = value,
                 fill = group),
             stat="summary",
             fun.y = "mean") +
    labs(title = "Mean Value by Group") +
    scale_fill_manual(values = c("#4E92CF", "#F07622")) +
    theme_minimal() +
    theme(legend.position = "none",
          plot.title = element_text(hjust = 0.5))
p

# Save the generated plot
ggsave("ks_test.png", plot = p, device = "png", path = "out")


# Extract the data for the Kolmogorov-Smirnov test
group_A_values <- data %>% filter(group == 'A') %>% pull(value)
group_B_values <- data %>% filter(group == 'B') %>% pull(value)

# Run the Kolmogorov-Smirnov test
ks.test(group_A_values, group_B_values)



# One-sample KS test ------------------------------------------------------

sample <- rnorm(10, mean = 10, sd = 2)
ks.test(sample, "pnorm", mean = 9, sd = 3)

sample <- rnorm(50, mean = 10, sd = 2)
ks.test(sample, "pnorm", mean = 9, sd = 3)


