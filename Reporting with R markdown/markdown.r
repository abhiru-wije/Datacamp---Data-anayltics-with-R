#1

---
title: "Investment Report"
output: html_document
---

```{r data, include = FALSE}
library(readr)

investment_annual_summary <- read_csv("https://assets.datacamp.com/production/repositories/5756/datasets/d0251f26117bbcf0ea96ac276555b9003f4f7372/investment_annual_summary.csv")
investment_services_projects <- read_csv("https://assets.datacamp.com/production/repositories/5756/datasets/78b002735b6f620df7f2767e63b76aaca317bf8d/investment_services_projects.csv")
```


## Datasets 

### Investment Annual Summary

The `investment_annual_summary` dataset provides a summary of the dollars in millions provided to each region for each fiscal year, from 2012 to 2018.
```{r}
investment_annual_summary
```

### Investment Services Projects

The `investment_services_projects` dataset provides information about each investment project from the 2012 to 2018 fiscal years. Information listed includes the project name, company name, sector, project status, and investment amounts.
```{r}
investment_services_projects 
```


