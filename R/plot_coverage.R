# Draw coverage function ----

plot_coverage <- function(data,
                          id){
            
            library(dplyr)
            library(ggplot2)
            
            tocov <- dplyr::filter(data,
                                  protein == id) %>% 
                        arrange(start) 
            
            indexed <- mutate(tocov, index = seq(from = 0.64,
                                           to = 0.64 + (0.05*dim(tocov)[1]) - 0.05, by = 0.05))
            

            coverage <- ggplot(data = indexed) +
                        # draw canvas
                        ylim(0.5, 
                             max(indexed$index)+0.07)+
                        xlim(-max(indexed$protein_length)*0.4,
                             max(indexed$protein_length) + max(indexed$protein_length*0.05))+
                        labs(x = "Amino acid number",
                             y = "") +
                        # draw protein 
                        geom_rect(aes(xmin = 1,
                                      xmax = protein_length,
                                      ymax = min(index)-0.02,
                                      ymin = 0.5),
                                  colour = "black",
                                  fill = "grey") +
                        annotate("text", 
                                 x = -7,
                                 y = 0.56,
                                 label = indexed$protein[1], hjust = 1, size = 4) +
                        # draw peptides
                        geom_rect(aes(xmin = start,
                                      xmax = end,
                                      ymax = index + 0.03,
                                      ymin = index),
                                  fill = "red")+
                        annotate("text",
                                 x = -7,
                                 y = indexed$index + 0.01,
                                 label = indexed$Sequence,
                                 hjust = 1,
                                 size = 3)
            
            return(coverage)
}



                   
                   