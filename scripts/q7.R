# ---------- Q7: Load the survey data and summarise by segment ----------
survey <- read.csv("survey_data.csv")   # load the 5,000 survey responses
str(survey)                              # check variable types
colSums(is.na(survey))                   # check for missing values
table(survey$foodie)                     # segment sizes (1 = foodie, 0 = non-foodie)
prop.table(table(survey$foodie))         # segment shares

foodie     <- subset(survey, foodie == 1)  # foodie segment
non_foodie <- subset(survey, foodie == 0)  # non-foodie segment
vars <- c("last_visit", "eat_frequency", "average_spend", "retention_rate")

summary(foodie[, vars])       # summary statistics - foodies
summary(non_foodie[, vars])   # summary statistics - non-foodies

# Standard deviations, to compare dispersion between segments
round(sapply(foodie[, vars], sd), 3)
round(sapply(non_foodie[, vars], sd), 3)

# Data-quality checks relevant to the survey design (Q6)
sum(survey$eat_frequency == 0)                  # respondents claiming 0 visits/month
tapply(survey$eat_frequency == 0, survey$foodie, sum)  # ... by segment
sum(survey$eat_frequency %% 1 != 0)             # slider gives only whole numbers?
range(survey$average_spend)                     # spend range vs 0-200 slider
