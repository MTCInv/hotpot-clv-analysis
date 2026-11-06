# ---------- Q10: CLV for NON-FOODIE customers ----------
# COGS, N, k and c are unchanged from Q9
M <- monthly_spend_non * (1 - COGS)     # monthly gross margin per non-foodie
g <- M - c                              # monthly profit net of variable marketing cost
g_seq <- rep(g, N)                      # profit sequence for all 24 periods
g_seq

r <- avg_retention_non                  # segment-average monthly retention rate
r
g_seq_after_retention <- g_seq * r^(0:(N - 1))  # survival-weighted profit (same timing as Q9)
round(g_seq_after_retention, 4)

d <- 1 / (1 + k)^(1:N)                  # end-of-month discount factors
g_seq_after_retention_discount <- g_seq_after_retention * d
round(g_seq_after_retention_discount, 4)

CLV_non_foodie <- sum(g_seq_after_retention_discount)  # CLV of a non-foodie
CLV_non_foodie

CLV_non_foodie - CAC_SEM                # net value per acquired non-foodie
CLV_non_foodie / CAC_SEM                # CLV-to-CAC ratio
CLV_non_foodie > CAC_SEM                # profitable to acquire via SEM?
# Compare with the other channels too
c(blanket = CLV_non_foodie > CAC_blanket, targeted = CLV_non_foodie > CAC_targeted)
