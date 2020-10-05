## Protein coverage visualization script ----
# Miguel Cosenza 07.05.2020 ----

## WHICH PROTEIN DO YOU WANT TO PLOT? ----
# please type the UNIPROT ID for the desired protein

proteinid <- "A0A024QZX5"
# Q5JWB9

## EXECUTE CODE ----

# Load required data ----
if(!exists("pepts")){
pepts <- read.delim(file = "Data/peptides.txt",
                       sep = "\t",
                       stringsAsFactors = FALSE)} 

if(!exists("proteins")){
proteins <- read.delim(file = "Data/proteinGroups.txt",
                       sep = "\t",
                       stringsAsFactors = FALSE)}

# Generate data frame for plotting ----

source(here::here("R/getcovaragedata.R"))

covdata <- getcoveragedata(proteinGroups = proteins,
                           peptides = pepts,
                           id = proteinid)

# Generate peptide-to-protein coverage plot ----

source(here::here("R/plot_coverage.R"))

plot_coverage(covdata,
              id = proteinid)


covplot <- plot_coverage(covdata,id = proteinid)

print(covplot)

# Generate image file ----

if(!dir.exists("Plot_outputs"))dir.create("Plot_outputs")

ggsave(filename = paste0("Plot_outputs/coverage_plot_",proteinid,".tiff"),plot = covplot,
       device = 'tiff')

sum

