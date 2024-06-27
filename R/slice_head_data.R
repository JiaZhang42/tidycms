#' Slice the first n rows from a CMS dataset
#'
#' @param data_id dataset identifier, could be "Dataset Type Identifier" or "Dataset Version Identifier"
#' @param n number of rows to slice, default is 100
#' @param select a vector of column names to select, default is `NULL`
#'
#' @return A tibble for the first n rows of the dataset
#' @export
#'
#' @examples
#' data_id <- '9767cb68-8ea9-4f0b-8179-9431abc89f11'
#' aco_participants <- slice_head_data(data_id)
#' aco_participants_100 <- slice_head_data(data_id, 100)
#' aco_participants_id <- slice_head_data(data_id, select = c('aco_id'))
slice_head_data <- function(data_id, n = 10, select = NULL){
  if (n > 5000) {
    stop('The maximum number of rows to slice is 5000. Use `collect_data()` instead to get more than 5000 rows.')
  }
  column <- select %>% paste0(collapse = ',')
  response <- httr2::request(glue::glue('https://data.cms.gov/data-api/v1/dataset/{data_id}/data?size={n}&column={column}')) %>%
    httr2::req_perform()
  response %>%
    httr2::resp_body_json() %>%
    dplyr::bind_rows()
}
