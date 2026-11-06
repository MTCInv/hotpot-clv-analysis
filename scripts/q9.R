# ---------- Q9: CLV for FOODIE customers ----------
COGS <- 0.50          # cost of goods sold = 50% of revenue
N    <- 24            # 2-year customer life, measured in monthly periods
k_annual <- 0.10      # HSBC SME loan rate (annual)
k    <- k_annual / 12 # monthly discount rate (Week 1 Apple-case conversion: annual rate / 12)
c    <- 0             # no variable marketing cost per period after acquisition

M <- monthly_spend_foodie * (1 - COGS)  # monthly gross margin per foodie
g <- M - c                              # monthly profit net of variable marketing cost
g_seq <- rep(g, N)                      # profit sequence for all 24 periods
g_seq

r <- avg_retention_foodie               # segment-average monthly retention rate
r
# Period 1 revenue is earned (booked at the end of month 1) by every newly acquired customer,
# so the survival probability for period t is r^(t-1): 1, r, r^2, ..., r^(N-1)
g_seq_after_retention <- g_seq * r^(0:(N - 1))
round(g_seq_after_retention, 3)

d <- 1 / (1 + k)^(1:N)                  # discount factors: cash flows arrive at the END of each month
g_seq_after_retention_discount <- g_seq_after_retention * d
round(g_seq_after_retention_discount, 3)

CLV_foodie <- sum(g_seq_after_retention_discount)  # customer lifetime value of a foodie
CLV_foodie

# Profitability check against the planned SEM acquisition cost
CLV_foodie - CAC_SEM                    # net value per acquired foodie
CLV_foodie / CAC_SEM                    # CLV-to-CAC ratio
CLV_foodie > CAC_SEM                    # profitable to acquire?
