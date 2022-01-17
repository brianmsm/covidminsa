
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
#> ⠙ 0 extracted | 465 MB (146 MB/s) | 3.2s
#> ⠹ 0 extracted | 839 MB (136 MB/s) | 6.2s
#> ⠸ 0 extracted | 1.1 GB (117 MB/s) | 9.2s
#> ⠼ 0 extracted | 1.3 GB (107 MB/s) | 12.2s
#> ⠴ 0 extracted | 1.5 GB (101 MB/s) | 15.2s
#> ⠦ 0 extracted | 1.8 GB ( 98 MB/s) | 18.2s
#> ⠧ 0 extracted | 2.1 GB ( 99 MB/s) | 21.2s
#> ⠇ 0 extracted | 2.3 GB ( 97 MB/s) | 24.2s
#> ⠏ 0 extracted | 2.5 GB ( 91 MB/s) | 27.3s
#> ⠋ 0 extracted | 2.6 GB ( 87 MB/s) | 30.3s
#> ⠙ 0 extracted | 2.8 GB ( 83 MB/s) | 33.2s
#> ⠹ 0 extracted | 3.1 GB ( 87 MB/s) | 36.2s
#> ⠸ 0 extracted | 3.3 GB ( 83 MB/s) | 39.3s
#> ⠼ 0 extracted | 3.4 GB ( 80 MB/s) | 42.2s
#> ⠴ 0 extracted | 3.5 GB ( 77 MB/s) | 45.2s
#> ⠦ 0 extracted | 3.7 GB ( 76 MB/s) | 48.2s
#> ⠧ 0 extracted | 4.0 GB ( 78 MB/s) | 51.2s
#> ⠇ 0 extracted | 4.2 GB ( 77 MB/s) | 54.2s
#> ⠏ 0 extracted | 4.3 GB ( 75 MB/s) | 57.3s
#> ⠋ 0 extracted | 4.4 GB ( 73 MB/s) | 1m 0.3s
#> ⠙ 0 extracted | 4.6 GB ( 73 MB/s) | 1m 3.2s
#> ⠹ 0 extracted | 4.9 GB ( 74 MB/s) | 1m 6.2s
#> ⠸ 0 extracted | 5.1 GB ( 73 MB/s) | 1m 9.3s
#> ⠼ 0 extracted | 5.2 GB ( 72 MB/s) | 1m 12.2s
#> ⠴ 0 extracted | 5.3 GB ( 71 MB/s) | 1m 15.2s
#> ⠦ 0 extracted | 5.7 GB ( 72 MB/s) | 1m 18.2s
#> ⠧ 0 extracted | 5.8 GB ( 72 MB/s) | 1m 21.2s
#> ⠇ 0 extracted | 6.0 GB ( 71 MB/s) | 1m 24.2s
```

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

``` r
fs::dir_info() %>% 
  select(path, type, size, modification_time) %>% 
  filter(stringr::str_detect(path, "vacunas_covid"))
#> # A tibble: 2 × 4
#>   path              type         size modification_time  
#>   <fs::path>        <fct> <fs::bytes> <dttm>             
#> 1 vacunas_covid.7z  file      540.58M 2022-01-17 14:21:32
#> 2 vacunas_covid.csv file        5.69G 2022-01-17 07:14:53
```
