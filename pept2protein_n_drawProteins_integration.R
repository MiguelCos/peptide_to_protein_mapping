### Script for integrating peptide to protein mapping with drawProteins package ----
# for visualization of structural information
# Miguel Cosenza 21.05.2020 ----

# Load packages ----

library(tidyverse)
library(drawProteins)
library(plotly)
library(htmlwidgets)
            
## WHICH PROTEIN DO YOU WANT TO PLOT? ----
# please type the UNIPROT ID for the desired protein

proteinid <- "P37802"
# Q5JWB9

## EXECUTE CODE ----

# Load required data ----

# set the working directory dynamically just to be sure ----

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

if(!exists("pepts")){
            pepts <- read.delim(file = "Data/peptides.txt",
                                sep = "\t",
                                stringsAsFactors = FALSE)} 

if(!exists("proteins")){
            proteins <- read.delim(file = "Data/proteinGroups.txt",
                                   sep = "\t",
                                   stringsAsFactors = FALSE)}

coverageinfo <- dplyr::select(proteins,
                              Protein.IDs, matches("Sequence.coverage....")) %>%
            mutate(protein = stringr::word(Protein.IDs, sep = ";")) %>% 
            dplyr::select(-Protein.IDs, protein,matches("Sequence.coverage....")) %>%
            dplyr::select(protein,Sequence.coverage....)

# Generate data frame for plotting ----

source(here::here("R/getcovaragedata.R"))

covdata <- getcoveragedata(proteinGroups = proteins,
                           peptides = pepts,
                           id = proteinid)


## Extract protein features from Uniprot with drawProteins package ----

features <- drawProteins::get_features(proteinid)

featuresdf <- drawProteins::feature_to_dataframe(features)


## Integrate peptide features and uniprot features ----

source(here::here("R/add_peptides.R"))


wpept_features <- add_peptides(featuresdf,
                               peptide_coverage_data = covdata)


# drawCanvas
canvas <- draw_canvas(wpept_features)

# draw the protein chain
wchain <- draw_chains(canvas, wpept_features)

# draw domains 
wdomains <- draw_domains(wchain, wpept_features, label_domains = FALSE)


# draw folding (structural info) ----

hel <- draw_folding(wdomains, wpept_features)


# draw peptides ----

source(here::here("R/draw_peptides.R"))

w_pepts <- draw_peptides(hel, wpept_features)

# interactive output:

interactive_w_pepts <- ggplotly(w_pepts)

if(!exists("Plots/")){
            dir.create("Plots/")
            } 

withr::with_dir('Plots', saveWidget(interactive_w_pepts, file="Interacive_peptides.html"))
