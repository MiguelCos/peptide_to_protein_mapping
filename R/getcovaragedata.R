## Extract peptide - to - protein information of 1 protein ----

getcoveragedata <- function(proteinGroups,
                            peptides) {

library(dplyr)
pepts <- dplyr::select(peptides, Sequence, peptide_length = Length, start = Start.position, 
                       end = End.position,
                       protein = Leading.razor.protein)

prots <- dplyr::select(proteinGroups, Protein.IDs, protein_length = Sequence.length,
                       Sequence.coverage....) %>% 
                        mutate(protein = stringr::word(Protein.IDs, sep = ";")) %>%
                        dplyr::select(-Protein.IDs)

mapped <- left_join(pepts, prots, by = "protein")

return(mapped)

}


