library('xts')
library('lubridate')

# read in the usal data file in CSV
file  <- 'tageswerte-1948-2012.csv'
data  <- read.csv(file, header = TRUE, sep = ',')

# create the simplest possible time series with "ts" - for rain and temperature
temp <- ts(data$LUFTTEMPERATUR, frequency = 12, start = c(1948, 1))
rain <- ts(data$NIEDERSCHLAGSHOEHE, frequency = 12, start = c(1948, 1))

# put two plots onto one canvas
par(mfrow = c(2, 1))

# plot data
plot(rain, ylab = "Niederschlagsmenge", xlab = "Meßdatum", main = "Niederschlagsmenge Tempelhof")
plot(temp, ylab = "Lufttemperatur", xlab = "Meßdatum", main = "Temperatur Tempelhof")

# use time series module xts
temp <- xts(data$LUFTTEMPERATUR, as.Date(data$MESS_DATUM))
rain <- xts(data$NIEDERSCHLAGSHOEHE, as.Date(data$MESS_DATUM))

# just get a chunk of the data with "window"
temperature.1948 <- window(temp, start="1948-01-01", end="1948-01-31")
temperature.2012 <- window(temp, start="2012-01-01", end="2012-01-31")
rain.1948        <- window(rain, start="1948-01-01", end="1948-01-31")

# simple plot for xts-based data
plot(rain.1948, ylab = "Niederschlagsmenge", xlab = "Meßdatum", main = "Niederschlagsmenge Tempelhof")
plot(temperature.1948, ylab = "Lufttemperatur", xlab = "Meßdatum", main = "Temperatur Tempelhof")

# now plot two temperature curves onto one in different colors
plot(temperature.1948, xaxt = "n", yaxt = "n", main = "", type="n")
lines(temperature.1948, col="blue")

par(new=TRUE)

plot(temperature.2012, ylab = "Lufttemperatur", xaxt = "n", main = "Temperatur Jan. 1948/2012")
lines(temperature.2012, col="red")

# add a legend
legend('topright', c("1948","2012"), lty = c(1,1), lwd = c(2.5,2.5), col = c("blue","red"))
