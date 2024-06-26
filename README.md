
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidycms

<!-- badges: start -->
<!-- badges: end -->

The goal of `tidycms` is to provide a set of functions to easily access
public datasets from Centers for Medicare & Medicaid Services (CMS). The
package is built on top of `httr2`. With user-friendly syntax, one can
get a tidy tibble in a few lines of code.

## Installation

You can install the development version of tidycms from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("JiaZhang42/tidycms")
```

## Example

This is a basic example which shows you how to glimpse all available
datasets from CMS:

``` r
library(tidycms)
cms_datasets <- show_datasets()
cms_datasets
#> # A tibble: 135 × 7
#>    title         identifier temporal modified description reference landing_page
#>    <chr>         <chr>      <chr>    <chr>    <chr>       <chr>     <chr>       
#>  1 Accountable … 9767cb68-… 2014-01… 2024-01… "The Accou… https://… https://dat…
#>  2 Accountable … 5b227bd9-… 2017-01… 2024-04… "The Accou… https://… https://dat…
#>  3 ACO Realizin… 1cd9eded-… 2021-01… 2024-01… "The Accou… https://… https://dat…
#>  4 ACO Realizin… 54551982-… 2021-01… 2024-01… "Accountab… https://… https://dat…
#>  5 ACO Realizin… 6c3532b3-… 2021-01… 2024-01… "The Accou… https://… https://dat…
#>  6 ACO Realizin… e0eba16f-… 2021-01… 2024-01… "The Accou… https://… https://dat…
#>  7 Advance Inve… a3d35ba1-… 2024-01… 2024-01… "The Advan… https://… https://dat…
#>  8 Agency for H… 7cf9662e-… 2015-01… 2020-12… "The Agenc… https://… https://dat…
#>  9 CMS Program … bbcffb70-… 2016-01… 2024-05… "The CMS P… https://… https://dat…
#> 10 CMS Program … 900059a0-… 2016-01… 2024-05… "The CMS P… https://… https://dat…
#> # ℹ 125 more rows
```
