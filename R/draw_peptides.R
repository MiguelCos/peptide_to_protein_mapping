## draw_peptides function ----

draw_peptides <- function(p,
                          data){
            
            library(ggplot2)
            
            data2 <- dplyr::filter(data, grepl('PEPTIDE', type))
            
            p <- p + ggplot2::geom_rect(
                        data = data2,
                        mapping=ggplot2::aes(xmin=begin,
                                             xmax=end,
                                             ymin=order-0.2,
                                             ymax=order+0.2)) +
                        annotate("text",
                                 x = -7,
                                 y = data2$order + 0.01,
                                 label = data2$description,
                                 hjust = 1,
                                 size = 3)
            
}





