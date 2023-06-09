rm(list = ls())

library(raster)
library(gstat)
"%>%" = magrittr::`%>%`

source('./src/010/Merging/MG_make_covariables.R')
source('./src/010/Merging/MG_RK.R')

# obs (anomalies = value - normal value)
## sample of 2015-11-15 to 2015-12-15
qc_data <- readRDS("./data/point_station_example/Anomalies_OBS_example.RDS")

## plot xy
class(qc_data$xyz)
raster::spplot(qc_data$xyz[,"ALT"])

## plot time series (single station all time)
class(qc_data$values$tmax)
class(qc_data$values$tmin)
lattice::xyplot(cbind(qc_data$values$tmax[, 30], 
                      qc_data$values$tmin[, 30]))

## plot time series (all station single time)
xy_exp <- qc_data$xyz[,"ALT"]
xy_exp@data["Tmax"] <- as.numeric(qc_data$values$tmax[5,])
xy_exp@data["Tmin"] <- as.numeric(qc_data$values$tmin[5,])
raster::spplot(xy_exp[,c("Tmax", "Tmin")])

# gridded (spatial predictors)
LST_day <- raster::brick("data/covariables/010/LST_DAY.nc")
LST_night <- raster::brick("data/covariables/010/LST_NIGHT.nc")
DEM <- raster::raster("data/covariables/010/DEM.nc")
X <- raster::raster("data/covariables/010/X.nc")
Y <- raster::raster("data/covariables/010/Y.nc")
tdi <- raster::raster("data/covariables/010/TDI.nc")

# gridded (climatologies)
tmax_normals <- raster::brick("data/climatologies/tmax_mean_1981-2010_010.nc") 
tmin_normals <- raster::brick("data/climatologies/tmin_mean_1981-2010_010.nc")

# making list of covs
covs_list_tmax <- list(dynamic = list(LST = LST_day),
                       static = list(DEM = DEM, X = X, Y = Y, TDI = tdi))

covs_list_tmin <- list(dynamic = list(LST = LST_night),
                       static = list(DEM = DEM, X = X, Y = Y, TDI = tdi))

# crs? should be the same for all dataset
raster::crs(qc_data$xyz) <- raster::crs(LST_day)
raster::crs(tmax_normals) <- raster::crs(LST_day)
raster::crs(tmin_normals) <- raster::crs(LST_day)

# merging
i = 5 # example time step = 5
date_i <- time(qc_data$values$tmax)[i]
month_value_i <- as.numeric(format(as.Date(date_i), "%m"))
### Tmax
### making covariables for selected time step
tmax_i <- make_Anomaly_coVariables(day_date = date_i,
                                   var = "tmax",
                                   covs_list = covs_list_tmax,
                                   obs = qc_data)
### estimating actual value, value = anomalies + normal value
tmax_value <- (RK(obs_cov_data = tmax_i, resFitting = 1) + tmax_normals[[month_value_i]])
raster::spplot(tmax_value)

### Tmin
### making covariables for selected time step
tmin_i <- make_Anomaly_coVariables(day_date = date_i,
                                   var = "tmin",
                                   covs_list = covs_list_tmin,
                                   obs = qc_data)
### estimating actual value, value = anomalies + normal value
tmin_value <- (RK(obs_cov_data = tmin_i, resFitting = 1) + tmin_normals[[month_value_i]])
raster::spplot(tmin_value)
