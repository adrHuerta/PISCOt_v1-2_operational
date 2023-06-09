rm(list = ls())

library(raster)

X <- file.path(".", "data", "covariables", "001", "X.nc")
X <- raster(X)
X <- aggregate(X, 10)

writeRaster(X,
            filename = file.path(".", "data", "covariables", "010", "X.nc"),
            format = "CDF",
            overwrite = TRUE,
            datatype = 'FLT4S', force_v4 = TRUE, compression = 7)

Y <- file.path(".", "data", "covariables", "001", "Y.nc")
Y <- raster(Y)
Y <- aggregate(Y, 10)

writeRaster(Y, 
            filename = file.path(".", "data", "covariables", "010", "Y.nc"),
            format = "CDF",
            overwrite = TRUE,
            datatype = 'FLT4S', force_v4 = TRUE, compression = 7)

elv <- file.path(".", "data", "covariables", "001", "DEM.nc")
elv <- raster(elv)
elv <- aggregate(elv, 10)

writeRaster(elv, 
            filename = file.path(".", "data", "covariables", "010", "DEM.nc"),
            format = "CDF",
            overwrite = TRUE,
            datatype = 'FLT4S', force_v4 = TRUE, compression = 7)

tdi <- file.path(".", "data", "covariables", "001", "TDI.nc")
tdi <- raster(tdi)
tdi <- aggregate(tdi, 10)

writeRaster(tdi, 
            filename = file.path(".", "data", "covariables", "010", "TDI.nc"),
            format = "CDF",
            overwrite = TRUE,
            datatype = 'FLT4S', force_v4 = TRUE, compression = 7)


lst_day <- file.path(".", "data", "covariables", "001", "LST_DAY.nc")
lst_day <- brick(lst_day)
lst_day <- aggregate(lst_day, 10)

writeRaster(lst_day, 
            filename = file.path(".", "data", "covariables", "010", "LST_DAY.nc"),
            format = "CDF",
            overwrite = TRUE,
            datatype = 'FLT4S', force_v4 = TRUE, compression = 7)

lst_night <- file.path(".", "data", "covariables", "001", "LST_NIGHT.nc")
lst_night <- brick(lst_night)
lst_night <- aggregate(lst_night, 10)

writeRaster(lst_night, 
            filename = file.path(".", "data", "covariables", "010", "LST_NIGHT.nc"),
            format = "CDF",
            overwrite = TRUE,
            datatype = 'FLT4S', force_v4 = TRUE, compression = 7)
