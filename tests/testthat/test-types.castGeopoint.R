library(stringr)
library(tableschema.r)
library(testthat)
library(foreach)
library(config)

context("types.castGeopoint")

# Constants

TESTS <- list(
  list('default', list(180, 90), list(180, 90) ),
  list('default', '180,90', list(180, 90) ),
  list('default', '180, -90', list(180, -90) ),
  list('default', list(lon = 180, lat = 90), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")) ),
  list('default', list(181,90), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")) ),
  list('default', '0,91', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")) ),
  list('default', 'string', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")) ),
  list('default', 1, config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")) ),
  list('default', '3.14', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")) ),
  list('default', '', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")) ),
  list('array', list(180, 90), list(180, 90) ),
  list('array', '[180, -90]', list(180, -90)),
  list('array', list(lon = 180, lat = 90), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('array', list(181, 90), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('array', list(0, 91), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  
  list('array', '180,90', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('array', 'string', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('array', 1, config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('array', '3.14', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('array', '', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  
  list('object', list(lon = 180, lat = 90), list(180, 90)),
  list('object', '{"lon": 180, "lat": 90}', list(180, 90)),
  #list('object', '[180, -90]', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  
  list('object', "{'lon': 181, 'lat': 90}", config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('object', "{'lon': 180, 'lat': -91}", config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  
  #list('object', list(180, -90), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('object', '180,90', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('object', 'string', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('object', 1, config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('object', '3.14', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('object', '', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")))
  )

# Tests

foreach(j = seq_along(TESTS) ) %do% {
  
  TESTS[[j]] <- setNames(TESTS[[j]], c("format", "value", "result"))
  
  test_that(str_interp('format "${TESTS[[j]]$format}" should check "${TESTS[[j]]$value}" as "${TESTS[[j]]$result}"'), {
    
    expect_equal(types.castGeopoint(TESTS[[j]]$format, TESTS[[j]]$value), TESTS[[j]]$result)
  })
}
