# Hotpot Restaurant — CAC / CLV Analysis (R)

Marketing analytics coursework for a fictional hotpot restaurant. Calculates customer acquisition cost (CAC) for three channels, summarises an anonymised survey, and builds customer lifetime value (CLV) / sensitivity checks in R.

## Data

`survey_data.csv` — 5,000 anonymised rows:

| Column | Meaning |
|--------|---------|
| customer_id | integer id |
| last_visit | years since last visit |
| eat_frequency | visits per year |
| average_spend | GBP |
| retention_rate | estimated retention |
| foodie | 1/0 segment flag |

No names or contact details.

## Scripts

```
driver.R           # runs each block and writes .out files
scripts/
  q3.R / q3.out    # CAC: blanket menu, targeted list, SEM
  q7.R / q7.out    # survey summary by segment
  q8.R … q11.R     # CLV and related questions
  sens.R           # sensitivity
```

Sample console output is checked in as `*.out` so you can read results without running R.

## Run

```bash
# from this folder
Rscript driver.R
```

Or source individual files inside RStudio with the working directory set here.

## Notes

- Assessed marketing-analytics coursework. Keep **private** unless the module allows public solutions.
- The Word/PDF write-up builder is not included; this repo is the analysis code and data only.
