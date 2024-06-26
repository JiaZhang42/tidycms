#' Show all datasets from CMS
#' @description
#' Show the basic information of all **latest** public datasets from Centers for Medicare & Medicaid Services (CMS) in the tibble format.
#'
#' @return A tibble for all latest public datasets from CMS. Columns include
#' - `title`
#' - `identifier`: the "Dataset Type Identifier", which doesn't change and always points to the latest version of the dataset. For "Dataset Version Identifier", visit its `landing_page`.
#' - `temporal`: time period
#' - `modified`: last modified date
#' - `description`
#' - `reference`: documentation link, named "describedBy" by CMS
#' - `landing_page`: webpage for the dataset
#' @export
#'
#' @examples
#' cms_datasets <- show_datasets()
#' @importFrom rlang .data
show_datasets <- function(){
  response <- httr2::request('https://data.cms.gov/data.json') %>%
    httr2::req_perform()
  tibble::tibble(
    dataset = response %>%
      httr2::resp_body_json() %>%
      purrr::pluck('dataset')
  ) %>%
    tidyr::unnest_wider('dataset') %>%
    dplyr::mutate(
      title = .data$title,
      identifier = stringr::str_extract(.data$identifier, "(?<=dataset/).*?(?=/data-viewer)"),
      temporal = .data$temporal,
      modified = .data$modified,
      description = .data$description,
      reference = .data$describedBy,
      landing_page = .data$landingPage,
      .keep = 'none'
    ) %>%
    dplyr::relocate('title', 'identifier', 'temporal', 'modified', 'description', 'reference', 'landing_page')
}
