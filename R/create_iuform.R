#' Starting a new IUform Shiny aplication
#'
#' @param path this is the IUform name and the folder it would live in
#' @param open Boolean open the created project
#' @param author gives author name
#' @param package_name Default is `basename(path)` or this otherwise it will be `basename(getwd())`
#' @param ... Arguments passed from the template.
#'
#' @export
create_IUform <- function(
  path,
  open = TRUE,
  package_name = basename(path),
  author,
  ...
) {

  path <- fs::path_expand(path)

  if (path == '.' & package_name == fs::path_file(path)){
    package_name <- fs::path_file(getwd())
  }



  if (fs::dir_exists(path)){
    res <- yesno(
      paste("The path", path, "already exists, override?")
    )
    if (!res){
      return(invisible(NULL))
    }
  }

  cli::cat_rule("Creating dir")
  fs::dir_create(
    path,
    recurse = TRUE
  )
  cli::cat_bullet(
    "Created IUform directory",
    bullet = "tick",
    bullet_col = "green"
  )


  cli::cat_rule("Copying IUform skeleton")
  from <- system.file(
    "IUformshiny",
    package = "iuform",
    lib.loc = NULL,
    mustWork = F
  )

  # Copy the predefined ui.R and server.R
  fs::dir_copy(path = from, new_path = path, overwrite = TRUE)

  # Listing copied files ***from source directory***
  copied_files <- list.files(path = from,
                             full.names = FALSE,
                             all.files = TRUE,
                             recursive = TRUE)

  # for loop to replace package name
  for (f in copied_files) {
    copied_file <- file.path(path, f)

    if (grepl("^REMOVEME", f)) {
      fs::file.rename(from = copied_file,
                  to =  fs::file.path(path, gsub("REMOVEME", "", f)))
      copied_file <- fs::file.path(path, gsub("REMOVEME", "", f))
    }

    if (!grepl("ico$", copied_file)) {
      try({
        iuform::replace_word(
          file = copied_file,
          pattern = "IUformshiny",
          replace = package_name)
      }, silent = T)
    }
  }
  cli::cat_bullet(
    "Copied app skeleton",
    bullet = "tick",
    bullet_col = "green"
  )




  # old <- setwd(path)
  # usethis::use_latest_dependencies()
  # setwd(old)

  cli::cat_rule("Done")

  cli::cat_line(
    paste0("Congrats ", author, ": ",
           "A new IUform named ",
           package_name,
           " was created at ",
           fs::path_abs(path),
           " .\n",
           "To continue working on your form, follow the steps below!"
    )
  )
  contents <-   cli::cat_line(
    paste0("Congrats ", author, ": ",
           "A new IUform named ",
           package_name,
           " was created at ",
           fs::path_abs(path),
           " .\n",
           "To continue working on your form, follow the steps below!"
    )
  )


  if ( open & rstudioapi::isAvailable() ) {
    rstudioapi::openProject(path = path)
  }

  return(
    invisible(
     fs::path_abs(path)
    )
  )
}

# to be used in RStudio IDE
create_IUform_gui <- function(path,...){
  dots <- list(...)

  create_IUform(
    path = path,
    open = T,
    author = dots$author
  )
  contents <- glue::glue(
    paste0("Congrats ", dots$author, ": ",
           "your IUform was created",
           " .\n",
           "To continue working on your form, follow the steps below!"
    )
  )

  # write to index file
  writeLines(contents, con = file.path(path, "INDEX"))
}
