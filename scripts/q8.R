# ---------- Q8: Segment-level metrics used for CLV ----------
# Average spend per visit, average visits per month and average monthly retention per segment
avg_spend_foodie     <- mean(foodie$average_spend)
avg_freq_foodie      <- mean(foodie$eat_frequency)
avg_retention_foodie <- mean(foodie$retention_rate)

avg_spend_non     <- mean(non_foodie$average_spend)
avg_freq_non      <- mean(non_foodie$eat_frequency)
avg_retention_non <- mean(non_foodie$retention_rate)

# Monthly average spending = average spend per visit x average visits per month
monthly_spend_foodie <- avg_spend_foodie * avg_freq_foodie
monthly_spend_non    <- avg_spend_non * avg_freq_non

segment_metrics <- data.frame(
  segment       = c("Foodie", "Non-foodie"),
  avg_spend     = c(avg_spend_foodie, avg_spend_non),
  avg_frequency = c(avg_freq_foodie, avg_freq_non),
  monthly_spend = c(monthly_spend_foodie, monthly_spend_non),
  avg_retention = c(avg_retention_foodie, avg_retention_non))
print(segment_metrics, digits = 4)

# Robustness: mean of individual monthly spend (spend x frequency per respondent)
tapply(survey$average_spend * survey$eat_frequency, survey$foodie, mean)
