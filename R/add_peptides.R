## function add_peptides ----

add_peptides <- function(feature_df,
                         peptide_coverage_data){
            
            library(dplyr)
            
            taxid <- feature_df$taxid[1]
            entryName <- feature_df$entryName[1]
            
            pept_feat <- dplyr::mutate(peptide_coverage_data,
                                       taxid = taxid,
                                       entryName = entryName) %>%
                        dplyr::select(names(feature_df))
            
            wpept_features <- bind_rows(feature_df, pept_feat)
            
            return(wpept_features)
            
}
