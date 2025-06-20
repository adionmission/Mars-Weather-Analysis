# Code written by Aditya Kakde, owner of account @Onnamission

library(janitor)
library(lubridate)
library(readxl)


# Setting working directory

# print(getwd())
# setwd("D:/Projects/Mars-Weather-Analysis")
# print(getwd())

df = read_excel('Dataset/mars-weather.xlsx')

# View(df)


# Data Cleaning Pipeline

data_clean = df %>%
  janitor::clean_names()

# View(data_clean)

sapply(data_clean, class)


# Converting data type

data_clean$terrestrial_date = as.Date(data_clean$terrestrial_date)

data_clean$min_temp = as.numeric(data_clean$min_temp)

data_clean$max_temp = as.numeric(data_clean$max_temp)

data_clean$pressure = as.numeric(data_clean$pressure)

# View(data_clean)

sapply(data_clean, class)


# Removing unnecessary columns

data_clean = subset(data_clean, select = -c(month, wind_speed))

# View(data_clean)


# Again data cleaning

data_clean = na.omit(data_clean)

# View(data_clean)


# converting ls number into strings

data_clean$ls = data_clean$ls[order(data_clean$ls)]

which(data_clean == 90, arr.ind=TRUE)

# View(data_clean)

# finding row and col number where 180 lies for specifying range

which(data_clean == 180, arr.ind=TRUE)

# View(data_clean)

which(data_clean == 270, arr.ind=TRUE)

# View(data_clean)

# converts first in the list for put it in ascending order

data_clean$ls[data_clean$ls %in% data_clean$ls[0:550]] = "autumnal equinox"

data_clean$ls[data_clean$ls %in% data_clean$ls[551:1037]] = "winter solstice"

data_clean$ls[data_clean$ls %in% data_clean$ls[1038:1456]] = "spring equinox"

data_clean$ls[data_clean$ls %in% data_clean$ls[1457:1867]] = "summer solstice"

# View(data_clean)


## making col autumnal equinox

data_clean$autumnal_equinox = c(data_clean$ls)

data_clean$autumnal_equinox[data_clean$autumnal_equinox == "autumnal equinox"] = 1

data_clean$autumnal_equinox[data_clean$autumnal_equinox == "winter solstice"] = 0

data_clean$autumnal_equinox[data_clean$autumnal_equinox == "spring equinox"] = 0

data_clean$autumnal_equinox[data_clean$autumnal_equinox == "summer solstice"] = 0

# View(data_clean)


## making col winter solstice

data_clean$winter_solstice = c(data_clean$ls)

data_clean$winter_solstice[data_clean$winter_solstice == "autumnal equinox"] = 0

data_clean$winter_solstice[data_clean$winter_solstice == "winter solstice"] = 1

data_clean$winter_solstice[data_clean$winter_solstice == "spring equinox"] = 0

data_clean$winter_solstice[data_clean$winter_solstice == "summer solstice"] = 0

# View(data_clean)


## making col spring equinox

data_clean$spring_equinox = c(data_clean$ls)

data_clean$spring_equinox[data_clean$spring_equinox == "autumnal equinox"] = 0

data_clean$spring_equinox[data_clean$spring_equinox == "winter solstice"] = 0

data_clean$spring_equinox[data_clean$spring_equinox == "spring equinox"] = 1

data_clean$spring_equinox[data_clean$spring_equinox == "summer solstice"] = 0

# View(data_clean)


## making col summer solstice

data_clean$summer_solstice = c(data_clean$ls)

data_clean$summer_solstice[data_clean$summer_solstice == "autumnal equinox"] = 0

data_clean$summer_solstice[data_clean$summer_solstice == "winter solstice"] = 0

data_clean$summer_solstice[data_clean$summer_solstice == "spring equinox"] = 0

data_clean$summer_solstice[data_clean$summer_solstice == "summer solstice"] = 1

# View(data_clean)


# writing changes to excel file

# write.csv(data_clean, "mars_weather.csv", row.names = FALSE)

