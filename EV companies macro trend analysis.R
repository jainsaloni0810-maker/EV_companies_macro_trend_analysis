

# EV Companies: Macroeconomic & Inflation Trend Analysis
# Statistical Models in R

# --- Libraries ---

library(jsonlite)


set.seed(42)
years <- 2019:2024
n_years <- length(years)

companies <- c("Tesla", "BYD", "Rivian", "NIO", "Lucid", "Li Auto")


# 1. SYNTHETIC DATA (representative of real filings / Bloomberg)


data <- list(
  Tesla = list(
    revenue        = c(24.58, 31.54, 53.82, 81.46, 96.77, 97.69),   # $B
    ebitda_margin  = c(0.038, 0.128, 0.197, 0.172, 0.133, 0.112),
    rd_spending    = c(1.34,  1.49,  2.59,  3.08,  3.97,  4.21),    # $B
    carbon_index   = c(100,   88,    74,    61,    52,    45),        # indexed 100=2019
    market_cap     = c(76,    669,   1061,  390,   248,   310)        # $B
  ),
  BYD = list(
    revenue        = c(22.6,  25.1,  33.6,  63.2,  84.9,  107.2),
    ebitda_margin  = c(0.052, 0.048, 0.071, 0.082, 0.089, 0.098),
    rd_spending    = c(1.21,  1.33,  1.78,  2.54,  3.21,  4.05),
    carbon_index   = c(100,   95,    83,    70,    59,    49),
    market_cap     = c(31,    49,    103,   114,   88,    105)
  ),
  Rivian = list(
    revenue        = c(0,     0,     0.055, 1.66,  4.43,  5.77),
    ebitda_margin  = c(NA,    NA,    -8.2,  -1.86, -0.62, -0.18),
    rd_spending    = c(0.13,  0.59,  1.37,  1.40,  1.34,  1.28),
    carbon_index   = c(NA,    NA,    100,   88,    75,    64),
    market_cap     = c(0,     0,     80,    15,    12,    17)
  ),
  NIO = list(
    revenue        = c(1.12,  2.49,  5.44,  7.31,  8.05,  9.18),
    ebitda_margin  = c(-0.89, -0.52, -0.21, -0.28, -0.35, -0.22),
    rd_spending    = c(0.44,  0.74,  1.32,  2.06,  2.34,  2.11),
    carbon_index   = c(100,   91,    80,    69,    61,    54),
    market_cap     = c(7.7,   68,    57,    18,    9,     11)
  ),
  Lucid = list(
    revenue        = c(0,     0,     0.027, 0.608, 0.595, 0.807),
    ebitda_margin  = c(NA,    NA,    -21.4, -5.12, -4.33, -2.87),
    rd_spending    = c(0.04,  0.19,  0.72,  0.848, 0.791, 0.734),
    carbon_index   = c(NA,    NA,    100,   85,    73,    62),
    market_cap     = c(0,     0,     24,    6.5,   4.2,   5.8)
  ),
  `Li Auto` = list(
    revenue        = c(0.28,  1.50,  3.58,  6.59,  17.46, 21.1),
    ebitda_margin  = c(-0.20, 0.011, 0.049, 0.062, 0.094, 0.108),
    rd_spending    = c(0.12,  0.38,  0.72,  1.33,  2.01,  2.45),
    carbon_index   = c(100,   93,    84,    72,    61,    51),
    market_cap     = c(0,     28,    35,    26,    20,    24)
  )
)

# Macro variables
macro <- data.frame(
  year         = years,
  cpi_yoy      = c(2.3, 1.2, 7.0, 8.0, 3.4, 2.9),           # US CPI %
  fed_rate     = c(2.25, 0.25, 0.25, 4.5, 5.25, 5.25),       # Fed Funds %
  lithium_idx  = c(100, 95, 240, 480, 210, 145),              # Lithium price index
  ev_subsidy   = c(7.5, 7.5, 7.5, 7.5, 7.5, 3.75),           # Avg US EV subsidy $k
  gdp_growth   = c(2.3, -2.8, 5.9, 2.1, 2.5, 2.8)            # US GDP %
)


# 2. STATISTICAL MODELS


results <- list()

# --- Model A: Revenue Growth OLS vs Macro ---
tesla_df <- data.frame(
  rev_growth   = c(NA, diff(data$Tesla$revenue) / head(data$Tesla$revenue, -1) * 100),
  cpi          = macro$cpi_yoy,
  fed_rate     = macro$fed_rate,
  lithium      = macro$lithium_idx,
  subsidy      = macro$ev_subsidy,
  gdp          = macro$gdp_growth
)
tesla_df <- na.omit(tesla_df)

model_rev <- lm(rev_growth ~ cpi + fed_rate + lithium + subsidy + gdp, data = tesla_df)
results$revenue_model_summary <- capture.output(summary(model_rev))
results$revenue_coefs <- coef(model_rev)
results$revenue_r2 <- summary(model_rev)$r.squared

# Model B: EBITDA Margin vs Inflation 
panel_rows <- list()
for (co in companies) {
  m   <- data[[co]]$ebitda_margin
  rev <- data[[co]]$revenue
  rd  <- data[[co]]$rd_spending
  valid <- !is.na(m) & m > -10  
  if (sum(valid) >= 3) {
    panel_rows[[co]] <- data.frame(
      company    = co,
      year       = years[valid],
      ebitda     = m[valid],
      rev        = rev[valid],
      rd_ratio   = rd[valid] / pmax(rev[valid], 0.1),
      cpi        = macro$cpi_yoy[valid],
      fed_rate   = macro$fed_rate[valid]
    )
  }
}
panel_df <- do.call(rbind, panel_rows)

model_ebitda <- lm(ebitda ~ cpi + fed_rate + rd_ratio + log1p(rev), data = panel_df)
results$ebitda_model_coefs <- coef(model_ebitda)
results$ebitda_r2          <- summary(model_ebitda)$r.squared

# Model C: Market Cap Elasticity 

mc_rows <- list()
for (co in companies) {
  mc  <- data[[co]]$market_cap
  rev <- data[[co]]$revenue
  valid <- mc > 0 & rev > 0
  if (sum(valid) >= 3) {
    mc_rows[[co]] <- data.frame(
      mc_growth = c(NA, diff(log(mc[valid]))),
      rev_growth= c(NA, diff(log(rev[valid]))),
      cpi       = macro$cpi_yoy[valid],
      fed_rate  = macro$fed_rate[valid]
    )
  }
}
mc_df <- na.omit(do.call(rbind, mc_rows))
model_mc <- lm(mc_growth ~ rev_growth + cpi + fed_rate, data = mc_df)
results$mc_model_coefs <- coef(model_mc)
results$mc_r2          <- summary(model_mc)$r.squared

#  Model D: Carbon Reduction Trend (log-linear) 
carbon_rows <- list()
for (co in companies) {
  ci <- data[[co]]$carbon_index
  valid <- !is.na(ci)
  if (sum(valid) >= 3) {
    carbon_rows[[co]] <- data.frame(
      log_carbon = log(ci[valid]),
      t          = seq_len(sum(valid))
    )
  }
}
carbon_df <- do.call(rbind, carbon_rows)
model_carbon <- lm(log_carbon ~ t, data = carbon_df)
carbon_annual_pct <- (exp(coef(model_carbon)["t"]) - 1) * 100
results$carbon_decay_pct_pa <- round(carbon_annual_pct, 2)
results$carbon_r2 <- summary(model_carbon)$r.squared

#  Model E: R&D Intensity Over Time 
rd_rows <- list()
for (co in companies) {
  rd  <- data[[co]]$rd_spending
  rev <- data[[co]]$revenue
  valid <- rev > 0.1
  if (sum(valid) >= 3) {
    rd_rows[[co]] <- data.frame(
      rd_intensity = rd[valid] / rev[valid],
      year         = years[valid],
      cpi          = macro$cpi_yoy[valid]
    )
  }
}
rd_df <- do.call(rbind, rd_rows)
model_rd <- lm(rd_intensity ~ year + cpi, data = rd_df)
results$rd_model_coefs <- coef(model_rd)
results$rd_r2 <- summary(model_rd)$r.squared

# 3. COMPILE METRICS TABLE

metrics_table <- lapply(companies, function(co) {
  rev <- data[[co]]$revenue
  rev_growth <- mean(diff(rev) / head(rev, -1) * 100, na.rm = TRUE)
  ebitda_mean <- mean(data[[co]]$ebitda_margin, na.rm = TRUE)
  rd_mean <- mean(data[[co]]$rd_spending, na.rm = TRUE)
  carbon_drop <- if (!is.na(data[[co]]$carbon_index[1]) && !is.na(tail(data[[co]]$carbon_index, 1)))
    round((1 - tail(data[[co]]$carbon_index, 1) / data[[co]]$carbon_index[which(!is.na(data[[co]]$carbon_index))[1]]) * 100, 1)
  else NA
  mc_cagr <- {
    mc <- data[[co]]$market_cap
    valid_mc <- mc[mc > 0]
    if (length(valid_mc) >= 2) round((tail(valid_mc, 1) / valid_mc[1])^(1 / (length(valid_mc) - 1)) * 100 - 100, 1) else NA
  }
  data.frame(
    company = co,
    avg_rev_growth_pct = round(rev_growth, 1),
    avg_ebitda_margin_pct = round(ebitda_mean * 100, 1),
    avg_rd_bn = round(rd_mean, 2),
    carbon_reduction_pct = carbon_drop,
    mc_cagr_pct = mc_cagr
  )
})
metrics_df <- do.call(rbind, metrics_table)

# 4. OUTPUT JSON for Dashboard

output <- list(
  companies      = companies,
  years          = years,
  raw_data       = data,
  macro          = macro,
  metrics_table  = metrics_df,
  model_results  = list(
    revenue = list(
      coefs = as.list(results$revenue_coefs),
      r2    = round(results$revenue_r2, 3)
    ),
    ebitda = list(
      coefs = as.list(results$ebitda_model_coefs),
      r2    = round(results$ebitda_r2, 3)
    ),
    market_cap = list(
      coefs = as.list(results$mc_model_coefs),
      r2    = round(results$mc_r2, 3)
    ),
    carbon = list(
      annual_decay_pct = results$carbon_decay_pct_pa,
      r2 = round(results$carbon_r2, 3)
    ),
    rd = list(
      coefs = as.list(results$rd_model_coefs),
      r2    = round(results$rd_r2, 3)
    )
  )
)

cat(toJSON(output, auto_unbox = TRUE, pretty = FALSE))