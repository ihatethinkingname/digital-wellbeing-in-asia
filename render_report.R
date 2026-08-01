if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  install.packages("rmarkdown", repos = "https://cloud.r-project.org")
}

rmarkdown::render(
  input = "final.rmd",
  output_dir = ".",
  clean = TRUE
)
