#' Slice the first n rows from a CMS dataset
#'
#' @param data_id dataset identifier, could be "Dataset Type Identifier" or "Dataset Version Identifier"
#' @param n number of rows to slice, default is 100
#'
#' @return A tibble for the first n rows of the dataset
#' @export
#'
#' @examples
#' data_id <- '9767cb68-8ea9-4f0b-8179-9431abc89f11'
#' aco_participants <- slice_head_data(data_id)
#' aco_participants_10 <- slice_head_data(data_id, 10)
slice_head_data <- function(data_id, n = 100){
  response <- httr2::request(glue::glue('https://data.cms.gov/data-api/v1/dataset/{data_id}/data?size={n}')) %>%
    httr2::req_perform()
  response %>%
    httr2::resp_body_json() %>%
    dplyr::bind_rows()
}
