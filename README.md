
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
#> ⠙ 0 extracted | 349 MB ( 86 MB/s) | 4.1s
#> ⠹ 0 extracted | 749 MB (106 MB/s) | 7.1s
#> ⠸ 0 extracted | 1.2 GB (117 MB/s) | 10.1s
#> ⠼ 0 extracted | 1.5 GB (113 MB/s) | 13.1s
#> ⠴ 0 extracted | 1.7 GB (107 MB/s) | 16.1s
#> ⠦ 0 extracted | 2.0 GB (104 MB/s) | 19.1s
#> ⠧ 0 extracted | 2.3 GB (105 MB/s) | 22.2s
#> ⠇ 0 extracted | 2.4 GB ( 97 MB/s) | 25.2s
#> ⠏ 0 extracted | 2.6 GB ( 91 MB/s) | 28.1s
#> ⠋ 0 extracted | 2.7 GB ( 86 MB/s) | 31.1s
#> ⠙ 0 extracted | 2.8 GB ( 83 MB/s) | 34.1s
#> ⠹ 0 extracted | 3.0 GB ( 80 MB/s) | 37.1s
#> ⠸ 0 extracted | 3.3 GB ( 81 MB/s) | 40.1s
#> ⠼ 0 extracted | 3.5 GB ( 80 MB/s) | 43.2s
#> ⠴ 0 extracted | 3.6 GB ( 77 MB/s) | 46.1s
#> ⠦ 0 extracted | 3.7 GB ( 75 MB/s) | 49.1s
#> ⠧ 0 extracted | 3.8 GB ( 73 MB/s) | 52.1s
#> ⠇ 0 extracted | 4.1 GB ( 75 MB/s) | 55.1s
#> ⠏ 0 extracted | 4.4 GB ( 76 MB/s) | 58.1s
#> ⠋ 0 extracted | 4.6 GB ( 75 MB/s) | 1m 1.1s
#> ⠙ 0 extracted | 4.7 GB ( 74 MB/s) | 1m 4.1s
#> ⠹ 0 extracted | 4.8 GB ( 72 MB/s) | 1m 7.1s
#> ⠸ 0 extracted | 5.0 GB ( 71 MB/s) | 1m 10.1s
#> ⠼ 0 extracted | 5.4 GB ( 74 MB/s) | 1m 13.1s
#> ⠴ 0 extracted | 5.5 GB ( 73 MB/s) | 1m 16.1s
#> ⠦ 0 extracted | 5.7 GB ( 72 MB/s) | 1m 19.1s
#> ⠧ 0 extracted | 5.8 GB ( 71 MB/s) | 1m 22.1s
#> ⠇ 0 extracted | 6.1 GB ( 72 MB/s) | 1m 25.1s
```
