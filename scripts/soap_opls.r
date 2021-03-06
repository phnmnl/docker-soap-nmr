#!/usr/bin/env Rscript

# Setup R error handling to go to stderr
options(show.error.messages=F, error=function(){cat(geterrmessage(),file=stderr());q("no",1,F)})

# Set proper locale
loc <- Sys.setlocale("LC_MESSAGES", "en_US.UTF-8")

# Import library
#library(getopt)
options(stringAsfactors = FALSE, useFancyQuotes = FALSE)

# Take in trailing command line arguments
args <- commandArgs(trailingOnly = TRUE)

# Library ropls
library(ropls)

# Read data set
aligned_dataset <- read.csv(args[[1]], stringsAsFactors=FALSE)

# Prepare data set for OPLS
grouping <- aligned_dataset[,ncol(aligned_dataset)]
aligned_dataset <- aligned_dataset[,-ncol(aligned_dataset)]

# OPLS with pareto scaling
model_opls <- opls(x=aligned_dataset, y=grouping, scaleC='pareto', printL=FALSE, plotL=FALSE)

# Plot OPLS
plot(x=model_opls, y=grouping, typeVc="summary", parCexN=0.8, file.pdfC = args[[2]])

