# Example using prophet::
# prophet forecasts time series based on an additive model where nonlinear trends are fit with yearly and weekly seasonality, 
# plus holidays. It works best with daily data.
library(prophet)
library(readr)
df <- read_csv('~/prophet/examples/example_air_passengers.csv')
# df has time steps of monthly data from Jan 1949 to December 1960.
glimpse(df)
model <- prophet(df)

#3 construct dataframe for future periods
future <- make_future_dataframe(model, periods = 24, freq = "month")
# future now has time steps of monthly data from Jan 1949 to December 1962.
head(future)
tail(future)

forecast <- predict(model, future)
head(forecast)
tail(forecast)

plot(model, forecast)
prophet_plot_components(model, forecast)
dyplot.prophet(model, forecast)

# WHERE IS THE SUMMARY FUNCTION??
?prophet::performance_metrics()
?cross_validation()

# perform cross validation 
# horizon is integer size of horizon..
#notes:
dim(df) # is 144 rows
dim(forecast) # is 168 rows
dim(forecast)-dim(df) # is 24 rows = horizon

cv <- cross_validation(model=model, horizon=24, units = "days", period = 144) # note month not available. WORKS BEST ON DAILY DATA!!
performance_metrics(cv)

# horizon is integer size of horizon..
dim(df) # is 144 rows
dim(forecast) # is 168 rows
dim(forecast)-dim(df) # is 24 rows

# perform performance_metrics on df1 from cross validation 
performance_metrics(cv)


# Example using CausalImpact::  see- https://google.github.io/CausalImpact/CausalImpact.html
library(pacman)
pacman::p_load(CausalImpact)


#https://robjhyndman.com/hyndsight/tscv/
#https://www.jstatsoft.org/article/view/v072i04