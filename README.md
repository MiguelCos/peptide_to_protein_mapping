# Peptide to protein mapping

Script for the visualization of the peptide coverage (peptide-to-protein mapping) of a particular protein of interest from a MaxQuant output.  

## How to use?

1. Download this repo to your local PC.
2. Unzip the files and initialize the downloaded folder as an R Studio Project.
3. Add both the `peptides.txt` and the `proteinGroups.txt` files from your MaxQuant output to the `Data` folder.
4. Open the project in R Studio.
5. Open the script `protein_coverage_visualization.R`
6. In the script (line 7), set `proteinid` to the Uniprot protein you want to visualize (as in the column `Leading.razor.protein` of your MaxQuant output). 
  - Example: `proteinid <- "A0A024QZX5"`
7. Run `Source` at the upper right corner of your script.
8. A new folder with a TIFF file should have been generated with your visualization. The plot should also be shown in the R Studio session.

