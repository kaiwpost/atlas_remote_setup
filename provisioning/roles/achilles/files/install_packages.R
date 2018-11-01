#!/usr/bin/env Rscript

argv = commandArgs(trailingOnly = TRUE);
if (is.null(argv) | length(argv) < 1) {
  cat("Usage: R-install-package package [type] \n");
  q(status = 1);
}

type = ifelse(is.na(argv[2]), 'package', argv[2]);
if (type == 'github') {
  repo = argv[1];
  package = unlist(strsplit(repo, "/"))[2];
} else {
  package = argv[1];
}

if (! (package %in% installed.packages()[,'Package'])) {
  if (type == 'github') {
    devtools::install_github(repo)
  } else {
    install.packages(pkgs=package, repos=c('http://ftp.heanet.ie/mirrors/cran.r-project.org/'))
  }
  print('Added')
} else {
  print('Already installed')
}

