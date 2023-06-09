rm(list = ls())

library(raster)
library(gstat)
"%>%" = magrittr::`%>%`

source('./src/001/Merging/MG_make_covariables.R')
source('./src/001/Merging/MG_RK.R')

# gridded
LST_day <- raster::brick("data/covariables/001/LST_DAY.nc")
LST_night <- raster::brick("data/covariables/001/LST_NIGHT.nc")
DEM <- raster::raster("data/covariables/001/DEM.nc")
X <- raster::raster("data/covariables/001/X.nc")
Y <- raster::raster("data/covariables/001/Y.nc")
tdi <- raster::raster("data/covariables/001/TDI.nc")

# gridded
tmax_normals <- raster::brick("data/climatologies/tmax_mean_1981-2010.nc") 
tmin_normals <- raster::brick("data/climatologies/tmin_mean_1981-2010.nc")

# making list of covs
covs_list_tmax <- list(dynamic = list(LST = LST_day),
                       static = list(DEM = DEM, X = X, Y = Y, TDI = tdi))

covs_list_tmin <- list(dynamic = list(LST = LST_night),
                       static = list(DEM = DEM, X = X, Y = Y, TDI = tdi))
