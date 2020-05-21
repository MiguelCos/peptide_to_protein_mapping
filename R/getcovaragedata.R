## Extract peptide - to - protein information of 1 protein ----

getcoveragedata <- function(proteinGroups,
                            peptides,
                            id) {

library(dplyr)
pepts <- dplyr::select(peptides, Sequence, peptide_length = Length, start = Start.position, 
                       end = End.position,
                       protein = Leading.razor.protein)

prots <- dplyr::select(proteinGroups, Protein.IDs, protein_length = Sequence.length,
                       Sequence.coverage....) %>% 
                        mutate(protein = stringr::word(Protein.IDs, sep = ";")) %>%
                        dplyr::select(-Protein.IDs) %>%
            dplyr::mutate(type = "PEPTIDE")

mapped <- left_join(pepts, prots, by = "protein")

mappedid <- dplyr::filter(mapped,
                          protein == id) %>% 
            dplyr::rename(description = Sequence,
                          begin = start,
                          length = peptide_length,
                          accession = protein) %>% 
            dplyr::select(type, description, begin, end, length, accession) %>%
            dplyr::arrange(end) %>%
            dplyr::mutate(order = c(2:dim(.)[1],dim(.)[1]+1))

return(mappedid)

}


