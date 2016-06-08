library(nycflights13)
data(flights)
help(flights)

num_rows = nrow(flights)
num_vars = nrow(flights) * ncol(flights)
dep_delays = (flights$dep_delay)
dep_delays[is.na(dep_delays)] = 0
longest_dep_delay = max(dep_delays)
longest_flights = sort(flights$air_time, decreasing = TRUE)[1:10]
ua_delay = flights$dep_delay[which(flights$carrier == "UA")]
ua_delay[is.na(ua_delay)] = 0
ua_delay = mean(ua_delay)
month_delay = rep(0, 12)
for(i in 1:12){
  month_i_delay = flights$dep_delay[which(flights$month == i)]
  month_i_delay[is.na(month_i_delay)] = 0
  month_delay[i] = mean(month_i_delay)
}
month_delay = order(month_delay)
num_planes_aa = length(unique(flights$tailnum[which(flights$carrier == "AA")]))
jfk_1000mi = length(flights$distance[which(flights$origin == "JFK" & flights$distance > 1000)])
num_lga_dfw = length(flights$carrier[which(flights$origin == "LGA" & flights$dest == "DFW")])
most_flights_jfk = flights$carrier[which.max(length(flights$origin == "JFK"))]
