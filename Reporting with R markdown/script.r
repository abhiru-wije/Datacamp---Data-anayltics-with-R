---
  title: "Investment Report"
output: html_document
---
  
  ```{r data, include = FALSE}
library(readr)

investment_annual_summary <- read_csv("https://assets.datacamp.com/production/repositories/5756/datasets/d0251f26117bbcf0ea96ac276555b9003f4f7372/investment_annual_summary.csv")
investment_services_projects <- read_csv("https://assets.datacamp.com/production/repositories/5756/datasets/78b002735b6f620df7f2767e63b76aaca317bf8d/investment_services_projects.csv")
```


```{r}
names(investment_annual_summary)
print(investment_services_projects)

#2
