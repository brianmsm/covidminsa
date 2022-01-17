#' Download vaccination data of Minsa Peru
#'
#' @description The download source is MINSA's open data platform,
#'   which updates covid data on an almost daily basis.
#'
#' @param path (Optional) You can specify where you want the data
#'   to be downloaded.
#'
#' @param archive (Optional) You can specify the location of the .7z
#'   file you have previously downloaded so that the function can determine
#'   if you have an outdated version and need to re-download a new version.
#'
#' @return An archive .7z and .csv file about vaccination data
#'
#' @importFrom httr GET headers HEAD
#' @importFrom jsonlite fromJSON
#' @importFrom fs file_temp path_dir path_temp
#' @importFrom utils download.file
#' @importFrom archive archive_extract
#'
#' @export
#'
#' @examples

get_vaccination <- function(path = NULL,
                            archive = NULL) {

  # Información sobre los datos
  res <- GET("https://www.datosabiertos.gob.pe/api/3/action/package_show?id=24af4ff4-226d-4e3d-90cb-d26a1849796e")
  res_json <- fromJSON(rawToChar(res$content))
  link_data_today <- res_json$result$resources[[1]][1, ]$url
  size_data <- as.numeric(headers(HEAD(link_data_today))[["Content-Length"]])

  if (!is.null(archive)) {
    size_archive <- file.size(archive)
    if (size_archive < size_data) {
      size_archive <- structure(size_archive,
                                class="object_size")
      size_data <- structure(size_data,
                             class="object_size")

      if (is.null(path)) path <- path_dir(archive)

      message_size_7z <- paste0("The current compressed .7z file weighs ",
                                format(size_archive, units = "Mb"),
                                ", and the version available on the MINSA server is",
                                format(size_data, units = "Mb"), ". Do you want to",
                                " download the new version? [Yes/no] ")
      message_size_7z <- writeLines(strwrap(message_size_7z,
                                            width = getOption("width")))
      check_message_size_7z <- tolower(readline(message_size_7z))

      if (substr(check_message_size_7z, 1, 1) == "y") {
        message_overwrite_7z <- paste0("Do you want to overwrite the file",
                                       " 'vacunas_covid.7z'? [Yes/no] ")
        message_overwrite_7z <- writeLines(strwrap(message_overwrite_7z,
                                                   width = getOption("width")))
        check_message_overwrite_7z <- tolower(readline(message_overwrite_7z))

        if (substr(check_message_overwrite_7z, 1, 1) == "y") {
          # Overwrite 7z
          options(timeout = max(1000, getOption("timeout")))
          download.file(link_data_today, archive)

        } else {
          message_rename_7z <- paste0("What is the new name of your .7z file? ")
          check_message_rename_7z <- readline(message_rename_7z)
          check_ext_rename_7z <- substr(check_message_rename_7z,
                                        nchar(check_message_rename_7z) - 2,
                                        nchar(check_message_rename_7z))

          # Fix extension archive
          if (tolower(check_ext_rename_7z) == ".7z") {
            # Fix extension that was in capital letters
            check_message_rename_7z <- paste0(substr(check_message_rename_7z, 1,
                                                     nchar(check_message_rename_7z) - 3),
                                              ".7z")
          } else if (check_ext_rename_7z != ".7z") {
            # Fix extension name in new file and then download it
            check_message_rename_7z <- paste0(check_message_rename_7z,
                                              ".7z")
          }

          # Download 7z archive
          options(timeout = max(1000, getOption("timeout")))
          download.file(link_data_today, paste0(path, "/", check_message_rename_7z))
        }

        # Unzip file downloaded

        if (file_exists(paste0(path, "/vacunas_covid.csv"))) {
          message_overwrite_csv <- paste0("There is already a file named 'vacunas_covid.csv',",
                                          " do you want to overwrite it? [Yes/no] ")
          message_overwrite_csv <- writeLines(strwrap(message_overwrite_csv,
                                                      width = getOption("width")))
          check_message_overwrite_csv <- tolower(readline(message_overwrite_csv))

          if (substr(check_message_overwrite_csv, 1, 1) == "y") {
            if (!exists("check_message_rename_7z")) {
              suppressWarnings(archive_extract(archive = archive,
                                               dir = path))
            } else {
              suppressWarnings(archive_extract(archive = paste0(path, "/", check_message_rename_7z),
                                               dir = path))
            }
          } else {
            message_rename_csv <- paste0("What is the new name of your .csv file? ")
            check_message_rename_csv <- readline(message_rename_csv)
            check_ext_rename_csv <- substr(check_message_rename_csv,
                                           nchar(check_message_rename_csv) - 3,
                                           nchar(check_message_rename_csv))

            # Fix extension csv
            if (tolower(check_ext_rename_csv) == ".csv") {
              # Fix extension that was in capital letters
              check_message_rename_csv <- paste0(substr(check_message_rename_csv, 1,
                                                        nchar(check_message_rename_csv) - 4),
                                                 ".csv")
            } else if (check_ext_rename_csv != ".csv") {
              # Fix extension name in new file and then download it
              check_message_rename_csv <- paste0(check_message_rename_csv,
                                                 ".csv")
            }

            dir_tmp <- fs::path_temp()

            if (!exists("check_message_rename_7z")) {
              suppressWarnings(archive_extract(archive = archive,
                                               dir = dir_tmp))
            } else {
              suppressWarnings(archive_extract(archive = paste0(path, "/", check_message_rename_7z),
                                               dir = dir_tmp))
            }

            # Move csv to path location with new name requested
            file_move(path = paste0(dir_tmp, "/vacunas_covid.csv"),
                      new_path = paste0(path, "/", check_message_rename_csv))
          }

        } else { # If there isn't exist a previous csv file
          if (!exists("check_message_rename_7z")) {
            suppressWarnings(archive_extract(archive = archive,
                                             dir = path))
          } else {
            suppressWarnings(archive_extract(archive = paste0(path, "/", check_message_rename_7z),
                                             dir = path))
          }
        }
      } else {
        # Nothing to do here?
        cat("It's okay. Nothing to do here. \n")
      }
    } else if (size_archive == size_data) {
      # Same size for archives. Say that archive is update.
      cat("You already have the most updated file available. \n")
    } else {
      # Message about something strange it's happening... How could the current file
      # size more than server version?
      cat(writeLines(strwrap(paste0("This is strange... the file you have is heavier than what",
                                    "is available on the system. I'm not sure what to do here. \n"),
                             width = getOption("width"))))
    }
  }

  # if (!is.null(csv)) {
  #   # Workflow about this.
  # }

  if (is.null(archive)) {
    # Just download the archive requested
    if (is.null(path)) path <- fs::path_wd()

    message_overwrite_7z_2 <- paste0("It looks like there is already a file named ",
                                     "'vacunas_covid.7z' in your working directory,",
                                     " do you want to overwrite it? [Yes/no] ")
    message_overwrite_7z_2 <- writeLines(strwrap(message_overwrite_7z_2,
                                                 width = getOption("width")))

    check_message_overwrite_7z_2 <- tolower(readline(message_overwrite_7z_2))

    if (substr(check_message_overwrite_7z_2, 1, 1) == "y") {
      # Overwrite 7z
      options(timeout = max(1000, getOption("timeout")))
      download.file(link_data_today, paste0(path, "/vacunas_covid.7z"))
    } else {
      message_rename_7z_2 <- paste0("What is the new name of your .7z file? ")
      check_message_rename_7z_2 <- readline(message_rename_7z_2)
      check_ext_rename_7z_2 <- substr(check_message_rename_7z_2,
                                      nchar(check_message_rename_7z_2) - 2,
                                      nchar(check_message_rename_7z_2))

      # Fix extension archive
      if (tolower(check_ext_rename_7z_2) == ".7z") {
        # Fix extension that was in capital letters
        check_message_rename_7z_2 <- paste0(substr(check_message_rename_7z_2, 1,
                                                   nchar(check_message_rename_7z_2) - 3),
                                            ".7z")
      } else if (check_ext_rename_7z_2 != ".7z") {
        # Fix extension name in new file and then download it
        check_message_rename_7z_2 <- paste0(check_message_rename_7z_2,
                                            ".7z")
      }

      # Download 7z archive
      options(timeout = max(1000, getOption("timeout")))
      download.file(link_data_today, paste0(path, "/", check_message_rename_7z_2))
    }


    if (file_exists(paste0(path, "/vacunas_covid.csv"))) {
      message_overwrite_csv_2 <- paste0("There is already a file named 'vacunas_covid.csv',",
                                        " do you want to overwrite it? [Yes/no] ")
      message_overwrite_csv_2 <- writeLines(strwrap(message_overwrite_csv_2,
                                                    width = getOption("width")))
      check_message_overwrite_csv_2 <- tolower(readline(message_overwrite_csv_2))

      if (substr(check_message_overwrite_csv_2, 1, 1) == "y") {
        if (!exists("check_message_rename_7z_2")) {
          suppressWarnings(archive_extract(archive = paste0(path, "/vacunas_covid.7z"),
                                           dir = path))
        } else {
          suppressWarnings(archive_extract(archive = paste0(path, "/", check_message_rename_7z_2),
                                           dir = path))
        }
      } else {
        message_rename_csv_2 <- paste0("What is the new name of your .csv file? ")
        check_message_rename_csv_2 <- readline(message_rename_csv_2)
        check_ext_rename_csv_2 <- substr(check_message_rename_csv_2,
                                         nchar(check_message_rename_csv_2) - 3,
                                         nchar(check_message_rename_csv_2))

        # Fix extension csv
        if (tolower(check_ext_rename_csv_2) == ".csv") {
          # Fix extension that was in capital letters
          check_message_rename_csv_2 <- paste0(substr(check_message_rename_csv_2, 1,
                                                      nchar(check_message_rename_csv_2) - 4),
                                               ".csv")
        } else if (check_ext_rename_csv_2 != ".csv") {
          # Fix extension name in new file and then download it
          check_message_rename_csv_2 <- paste0(check_message_rename_csv_2,
                                               ".csv")
        }

        dir_tmp_2 <- fs::path_temp()

        if (!exists("check_message_rename_7z_2")) {
          suppressWarnings(archive_extract(archive = paste0(path, "/vacunas_covid.7z"),
                                           dir = dir_tmp_2))
        } else {
          suppressWarnings(archive_extract(archive = paste0(path, "/", check_message_rename_7z_2),
                                           dir = dir_tmp_2))
        }

        # Move csv to path location with new name requested
        file_move(path = paste0(dir_tmp_2, "/vacunas_covid.csv"),
                  new_path = paste0(path, "/", check_message_rename_csv_2))
      }

    } else { # If there isn't exist a previous csv file
      if (!exists("check_message_rename_7z")) {
        suppressWarnings(archive_extract(archive = paste0(path, "/vacunas_covid.7z"),
                                         dir = path))
      } else {
        suppressWarnings(archive_extract(archive = paste0(path, "/", check_message_rename_7z_2),
                                         dir = path))
      }
    }
  }
}
