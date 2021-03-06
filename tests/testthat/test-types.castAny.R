library(stringr)
library(tableschema.r)
library(testthat)
library(foreach)

context("types.castAny")

# Constants

TESTS <- list(
  
  list("default", 1, 1),
  
  list("default", "1", "1"),
  
  list("default", "3.14", "3.14"),
  
  list("default", TRUE, TRUE),
  
  list("default", "", "")
  
)

# Tests

foreach(j = seq_along(TESTS) ) %do% {
  
  TESTS[[j]] <- setNames(TESTS[[j]], c("format", "value", "result"))
  
  test_that(str_interp('format "${TESTS[[j]]$format}" should check "${TESTS[[j]]$value}" as "${TESTS[[j]]$result}"'), {
    
    expect_equal(types.castAny(TESTS[[j]]$format, TESTS[[j]]$value), TESTS[[j]]$result)
  })
}
