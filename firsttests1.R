## First exploration of n-terminomics data ----

# Load packages ----

library(tidyverse)

BiocManager::install("Biostrings")

library(Biostrings)
library(seqinr)

# Load data ----

pept_acet <- read.delim(file = here::here("Data/peptides_acetylated.txt"),sep = '\t',
                        stringsAsFactors = FALSE)

pept_freentmt <- read_delim(file = here::here("Data/peptides_free-now-TMT.txt"), delim = '\t')

# 

proteins_acet <- dplyr::select(pept_acet, Leading.razor.protein)

write_tsv(proteins_acet,
          path = "acet_proteins.tsv")


x <- c(a = "apple", b = "banana", c = "pear")
str_view(x, "an")


seq1 <- "MAAAAAAAAAAGAAGGRGSGPGRRRHLVPGAGGEAGEGAPGGAGDYGNGLESEELEPEEL
LLEPEPEPEPEEEPPRPRAPPGAPGPGPGSGAPGSQEEEEEPGLVEGDPGDGAIEDPELE
AIKARVREMEEEAEKLKELQNEVEKQMNMSPPPGNAGPVIMSIEEKMEADARSIYVGNVD
YGATAEELEAHFHGCGSVNRVTILCDKFSGHPKGFAYIEFSDKESVRTSLALDESLFRGR
QIKVIPKRTNRPGISTTDRGFPRARYRARTTNYNSSRSRFYSGFNSRPRGRVYRGRARAT
SWYSPY"

seq1

str_view(seq1, "AAAAAAAAAAGAAGGR")

## read fasta file ----

fasta_acet_prots <- read.fasta(file = "acet_proteins_fasta.fasta",seqtype = "AA",as.string = TRUE,
                               whole.header = TRUE)

str_split("sp|Q86U42|PABP2_HUMAN",pattern = "\\|", simplify = TRUE)[2]

".*[|]([^.]+)[|].*"


getprot <- function(x){
            
}

names(fasta_acet_prots) <- 
            str_split(names(fasta_acet_prots),
                                     pattern = "\\|", simplify = TRUE)[2]

head(fasta_acet_prots, 1)

class(fasta_acet_prots)

length(fasta_acet_prots)



