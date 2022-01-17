
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covidminsa: A package for download COVID data from MINSA Peru

<!-- badges: start -->
<!-- badges: end -->

The goal of covidminsa is to be an easy way to obtain data from Minsa
Peru about COVID-19.

## Installation

You can install the development version of covidminsa from
[GitHub](https://github.com/brianmsm/covidminsa) with:

``` r
# install.packages("devtools")
devtools::install_github("brianmsm/covidminsa")
```

## Example

This is a basic example which shows you how to download the vaccination
data:

``` r
library(covidminsa)
```

``` r
get_vaccination()
#> ⠙ 0 extracted | 529 MB (109 MB/s) | 4.9s
#> ⠹ 0 extracted | 909 MB (116 MB/s) | 7.9s
#> ⠸ 0 extracted | 1.3 GB (118 MB/s) | 10.9s
#> ⠼ 0 extracted | 1.5 GB (110 MB/s) | 13.9s
#> ⠴ 0 extracted | 1.7 GB (104 MB/s) | 16.9s
#> ⠦ 0 extracted | 2.1 GB (107 MB/s) | 19.9s
#> ⠧ 0 extracted | 2.4 GB (106 MB/s) | 22.9s
#> ⠇ 0 extracted | 2.5 GB ( 98 MB/s) | 25.9s
#> ⠏ 0 extracted | 2.7 GB ( 93 MB/s) | 28.9s
#> ⠋ 0 extracted | 2.8 GB ( 88 MB/s) | 31.9s
#> ⠙ 0 extracted | 3.0 GB ( 85 MB/s) | 34.9s
#> ⠹ 0 extracted | 3.3 GB ( 86 MB/s) | 37.9s
#> ⠸ 0 extracted | 3.5 GB ( 86 MB/s) | 40.9s
#> ⠼ 0 extracted | 3.6 GB ( 82 MB/s) | 43.9s
#> ⠴ 0 extracted | 3.7 GB ( 79 MB/s) | 47s
#> ⠦ 0 extracted | 3.8 GB ( 77 MB/s) | 49.9s
#> ⠧ 0 extracted | 4.2 GB ( 79 MB/s) | 52.9s
#> ⠇ 0 extracted | 4.4 GB ( 79 MB/s) | 55.9s
#> ⠏ 0 extracted | 4.5 GB ( 77 MB/s) | 58.9s
#> ⠋ 0 extracted | 4.7 GB ( 75 MB/s) | 1m 1.9s
#> ⠙ 0 extracted | 4.8 GB ( 74 MB/s) | 1m 4.9s
#> ⠹ 0 extracted | 5.0 GB ( 74 MB/s) | 1m 7.9s
#> ⠸ 0 extracted | 5.3 GB ( 74 MB/s) | 1m 11s
#> ⠼ 0 extracted | 5.4 GB ( 73 MB/s) | 1m 13.9s
#> ⠴ 0 extracted | 5.6 GB ( 72 MB/s) | 1m 17s
#> ⠦ 0 extracted | 5.7 GB ( 72 MB/s) | 1m 19.9s
#> ⠧ 0 extracted | 6.0 GB ( 72 MB/s) | 1m 23.2s
```

    #> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
    #> ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    #> ✓ tibble  3.1.6     ✓ dplyr   1.0.7
    #> ✓ tidyr   1.1.4     ✓ stringr 1.4.0
    #> ✓ readr   2.1.1     ✓ forcats 0.5.1
    #> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    #> x dplyr::filter() masks stats::filter()
    #> x dplyr::lag()    masks stats::lag()

``` r
fs::dir_info() %>% 
  select(path, type, size, modification_time) %>% 
  filter(str_detect(path, "vacunas_covid"))
#> # A tibble: 2 × 4
#>   path              type         size modification_time  
#>   <fs::path>        <fct> <fs::bytes> <dttm>             
#> 1 vacunas_covid.7z  file      540.58M 2022-01-17 14:14:55
#> 2 vacunas_covid.csv file        5.69G 2022-01-17 07:14:53
```
