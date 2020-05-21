# Draw coverage function ----
data <- covdata
id <- "A0A024QZX5"

plot_coverage <- function(data,
                          id){
            
            library(dplyr)
            library(ggplot2)
            
            tocov <- dplyr::filter(data,
                                  protein == id) %>% 
                        arrange(start) 
            
            indexed <- mutate(tocov, index = seq(from = 0.64,
                                           to = 0.64 + (0.05*dim(tocov)[1]) - 0.05, by = 0.05))
            
            proterow <- c(id, indexed$protein_length[1], 1, indexed$protein_length[1], id, 
                          indexed$protein_length[1], indexed$Sequence.coverage....[1], 
                          indexed$index[1] - 0.05)
            
            indexed <- rbind(proterow, indexed) %>% 
                        mutate(type = ifelse(Sequence == id, "Protein", "Peptide"))
            
            indexed2 <- pivot_longer(indexed,
                                     cols = c(start, end),
                                     values_to = "aa_location",
                                     names_to = "position")
            
            coverage <- ggplot(indexed2, aes(aa_location, Sequence, Color = type, group = index)) +
                        geom_line(size = 10)

            coverage <- ggplot(data = indexed,
                               x = ) +
                        # draw canvas
                        ylim(0.5, 
                             max(indexed$index)+0.07)+
                        xlim(-max(indexed$protein_length)*0.6,
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



                   
                   