
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidycms

<!-- badges: start -->
<!-- badges: end -->

The goal of `tidycms` is to easily access public datasets from Centers
for Medicare & Medicaid Services (CMS). The package is built on top of
`httr2`. With user-friendly syntax, one can get a tidy tibble in a few
lines of code.

Check the [CMS API documentation](https://data.cms.gov/api-docs/) and
[FAQs](https://data.cms.gov/sites/default/files/2024-05/39b98adf-b5e0-4487-a19e-4dc5c1503d41/API%20Guide%20Formatted%201_5.pdf).

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

This table contains the basic information of all **latest** public
datasets from CMS. Columns include

- `title`

- `identifier`: the “Dataset Type Identifier”, which doesn’t change and
  always points to the latest version of the dataset. For “Dataset
  Version Identifier”, visit its `landing_page`.

- `temporal`: time period

- `modified`: last modified date

- `description`

- `reference`: documentation link, named “describedBy” by CMS

- `landing_page`: webpage for the dataset

Alternatively, you can search for a specific dataset by keywords at [CMS
website search](https://data.cms.gov/search).

Either way, you could get the identifier of the dataset you are
interested in. For example, the identifier for the dataset “Accountable
Care Organization Participants” is
`9767cb68-8ea9-4f0b-8179-9431abc89f11`.

Then you can preview the first 10 rows of the dataset:

``` r
data_id <- '9767cb68-8ea9-4f0b-8179-9431abc89f11'
aco_participants <- slice_head_data(data_id, 10)
aco_participants
#> # A tibble: 10 × 29
#>    aco_id par_lbn                 aco_name aco_service_area agreement_period_num
#>    <chr>  <chr>                   <chr>    <chr>            <chr>               
#>  1 A2811  ARIZONA COMMUNITY PHYS… Abacus … AZ               3                   
#>  2 A2811  TMC MEDICAL NETWORK     Abacus … AZ               3                   
#>  3 A1596  CARECONNECT HEALTH INC  Account… GA               4                   
#>  4 A1596  Center for Pan Asian C… Account… GA               4                   
#>  5 A1596  Coastal Community Heal… Account… GA               4                   
#>  6 A1596  Curtis V. Cooper Prima… Account… GA               4                   
#>  7 A1596  Diversity Health Cente… Account… GA               4                   
#>  8 A1596  GEORGIA MOUNTAINS HEAL… Account… GA               4                   
#>  9 A1596  Health Education Asses… Account… GA               4                   
#> 10 A1596  J.C. Lewis Primary Hea… Account… GA               4                   
#> # ℹ 24 more variables: initial_start_date <chr>, current_start_date <chr>,
#> #   `re-entering_aco` <chr>, basic_track <chr>, basic_track_level <chr>,
#> #   enhanced_track <chr>, high_revenue_aco <chr>, low_revenue_aco <chr>,
#> #   adv_pay <chr>, aim <chr>, aip <chr>, `snf_3-day_rule_waiver` <chr>,
#> #   prospective_assignment <chr>, retrospective_assignment <chr>,
#> #   aco_address <chr>, aco_public_reporting_website <chr>, aco_exec_name <chr>,
#> #   aco_exec_email <chr>, aco_exec_phone <chr>, aco_public_name <chr>, …
```

If you want to collect all data from a dataset, you can use the
`collect_data()` function:

``` r
data_id <- 'f1a8c197-b53d-4c24-9770-aea5d5a97dfb'
aco_participants_all <- collect_data(data_id, ask_for_confirmation = FALSE)
#> ℹ 1485 rows to be collected
```

``` r
aco_participants_all
#> # A tibble: 1,485 × 9
#>    NPI       `PROVIDER NAME` `ADDRESS LINE 1` `ADDRESS LINE 2` CITY  STATE ZIP  
#>    <chr>     <chr>           <chr>            <chr>            <chr> <chr> <chr>
#>  1 10030813… BAART BEHAVIOR… 617 COMSTOCK RD  STE 5            BERL… VT    0560…
#>  2 10031500… AMS OF WISCONS… 9532 E 16 FRONT… STE 100          ONAL… WI    5465…
#>  3 10033624… BHG XLII LLC    5715 PRINCESS A… <NA>             VIRG… VA    2346…
#>  4 10033689… RTS EDGEWOOD    2205 PULASKI HI… <NA>             EDGE… MD    21040
#>  5 10035716… METRO TREATMEN… 1241 BLANDING B… NEW SEASON TREA… ORAN… FL    3206…
#>  6 10035811… PREMIER CARE O… 2632 WOODMAN CE… <NA>             KETT… OH    4542…
#>  7 10035837… AFFINITY HEALT… 1305 KINGS HWY N <NA>             CHER… NJ    0803…
#>  8 10039416… TARZANA TREATM… 5190 ATLANTIC A… <NA>             LONG… CA    9080…
#>  9 10039471… WEST TEXAS COU… 1108 DOBIE DR S… WTCR PLANO, INC. PLANO TX    7507…
#> 10 10039535… ALLIANCE RECOV… 1116 E PONCE DE… <NA>             DECA… GA    3003…
#> # ℹ 1,475 more rows
#> # ℹ 2 more variables: `MEDICARE ID EFFECTIVE DATE` <chr>, PHONE <chr>
```
