# ---------- Q11: 10% discount promotion ----------
discount <- 0.10                 # customers receive 10% off every bill
# Food cost (COGS) is driven by the food served, i.e. 50% of the ORIGINAL menu price, so it does not fall
# with the discount. Margin per GBP of original spend = (1 - discount) - COGS = 0.40
margin_rate_promo <- (1 - discount) - COGS
margin_rate_promo

# Promotion-adjusted retention (+10 percentage points foodies, +5 pp non-foodies), capped at 1
r_foodie_promo <- min(avg_retention_foodie + 0.10, 1)
r_non_promo    <- min(avg_retention_non + 0.05, 1)
c(r_foodie_promo, r_non_promo)

# Re-usable CLV function with the same steps and timing conventions as Q9/Q10
clv_fun <- function(monthly_spend, margin_rate, r, N, k, c) {
  M <- monthly_spend * margin_rate                 # monthly gross margin
  g <- M - c                                       # monthly profit
  g_seq <- rep(g, N)                               # profit sequence
  g_seq_after_retention <- g_seq * r^(0:(N - 1))   # apply retention
  d <- 1 / (1 + k)^(1:N)                           # end-of-month discounting
  g_seq_after_retention_discount <- g_seq_after_retention * d
  sum(g_seq_after_retention_discount)              # CLV
}

# Check: the function reproduces the Q9/Q10 results without promotion
clv_fun(monthly_spend_foodie, 1 - COGS, avg_retention_foodie, N, k, c)
clv_fun(monthly_spend_non,    1 - COGS, avg_retention_non,    N, k, c)

# New CLVs under the promotion (purchase frequency and spend before discount unchanged)
CLV_foodie_promo     <- clv_fun(monthly_spend_foodie, margin_rate_promo, r_foodie_promo, N, k, c)
CLV_non_foodie_promo <- clv_fun(monthly_spend_non,    margin_rate_promo, r_non_promo,    N, k, c)

comparison <- data.frame(segment = c("Foodie", "Non-foodie"),
                         CLV_before = c(CLV_foodie, CLV_non_foodie),
                         CLV_after  = c(CLV_foodie_promo, CLV_non_foodie_promo))
comparison$change     <- comparison$CLV_after - comparison$CLV_before
comparison$pct_change <- 100 * comparison$change / comparison$CLV_before
comparison$after_minus_CAC_SEM <- comparison$CLV_after - CAC_SEM
print(comparison, digits = 4)

# Overall profitability: weight by the segment mix observed in the survey
share_foodie <- mean(survey$foodie)
share_non    <- 1 - share_foodie
CLV_avg_before <- share_foodie * CLV_foodie       + share_non * CLV_non_foodie
CLV_avg_after  <- share_foodie * CLV_foodie_promo + share_non * CLV_non_foodie_promo
c(share_foodie = share_foodie, before = CLV_avg_before, after = CLV_avg_after,
  change = CLV_avg_after - CLV_avg_before)

# Break-even foodie share: promotion adds value overall if foodie share exceeds this level
share_breakeven <- -comparison$change[2] / (comparison$change[1] - comparison$change[2])
share_breakeven

# Sensitivity: if COGS were 50% of the DISCOUNTED price (margin = 0.9 x 0.5 = 0.45)
c(foodie = clv_fun(monthly_spend_foodie, (1 - discount) * (1 - COGS), r_foodie_promo, N, k, c),
  non_foodie = clv_fun(monthly_spend_non, (1 - discount) * (1 - COGS), r_non_promo, N, k, c))
