#' Collect all data from a CMS dataset
#'
#' @param data_id dataset identifier, could be "Dataset Type Identifier" or "Dataset Version Identifier"
#' @param select a vector of column names to select, default is `NULL`
#' @param ask_for_confirmation whether to ask for confirmation before downloading, default is `TRUE`
#'
#' @return a tibble that contains all data from the dataset
#' @export
#'
#' @examples
#' data_id <- '9767cb68-8ea9-4f0b-8179-9431abc89f11'
#' collect_data(data_id, ask_for_confirmation = FALSE)
#' aco_participants_all <- collect_data(data_id, ask_for_confirmation = FALSE)
#' aco_participants_id <- collect_data(data_id, select = c('aco_id'), ask_for_confirmation = FALSE)
collect_data <- function(data_id, select = NULL, ask_for_confirmation = TRUE){
  n_row <- httr2::request(glue::glue('https://data.cms.gov/data-api/v1/dataset/{data_id}/data/stats')) %>%
    httr2::req_perform() %>%
    httr2::resp_body_json() %>%
    purrr::pluck('total_rows')
  cli::col_blue(glue::glue('{n_row} rows to be collected')) %>%
    cli::cli_alert_info()

  if (ask_for_confirmation) {
    # Prompt user for input
    user_input <- utils::menu(c("No", "Definitely", "Absolutely no"), title = "Do you want to proceed with the download?")
    if (user_input != 2) {
      cli::col_magenta("Download cancelled.") %>%
        cli::cli_alert_warning()
      return(cat())
    }
  }
  column <- select %>% paste0(collapse = ',')
  offsets <- 0:floor(n_row/5000)*5000
  urls <- glue::glue('https://data.cms.gov/data-api/v1/dataset/{data_id}/data?size=5000&offset={offsets}&column={column}')
  requests <- purrr::map(urls, httr2::request)
  tables <- httr2::req_perform_parallel(requests, on_error = "continue")
  tables %>%
    httr2::resps_successes() %>%
    httr2::resps_data(httr2::resp_body_json) %>%
    dplyr::bind_rows() %>%
    readr::type_convert() %>%
    suppressMessages()
}




