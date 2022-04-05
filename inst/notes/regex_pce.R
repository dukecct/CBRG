
# MORE INFO:
# https://stringr.tidyverse.org/articles/regular-expressions.html

library(tidyverse)
library(stringr)

# REMOVE EXTRA INFO FROM GENES
gene_names <- c("A1BG (1)", "A1CF (29974)", "A2M (2)", "A2ML1 (144568)", "A3GALT2 (127550)",
                "A4GALT (53947)", "A4GNT (51146)", "AAAS (8086)", "AACS (65985)")

gene_names %>%
  stringr::str_replace("\\s*\\([^\\)]+\\)", "") # remove everything inside parenthesis, including them

gene_names <- c("A1BG [Bareja et al. 2022]", "A1CF [Castellano et al. 2022]", "A2M [Hirschey et al. 2022]")

gene_names %>%
  stringr::str_replace_all("\\[.*]", "") # remove text within square brackets (for example, references)

## Woop! Seems that we have some whitespaces...

# CLEANING WHITESPACES
gene_names %>%
  stringr::str_replace_all("\\[.*]", "") %>% # repeat step above
  stringr::str_squish() # str_trim() removes whitespace from start and end of string. str_squish() also reduces repeated whitespace inside a string

# PUNCTUATION MARKS
gene_names <- c("A1BG!_*-01", "A1CF?__*-02")

gene_names %>%
  stringr::str_replace_all("[[:punct:]]", "") # remove ALL punctuation marks

gene_names %>%
  stringr::str_replace_all("[^-[:^punct:]]", "") # remove punctuation marks except -

gene_names %>%
  stringr::str_replace_all("[[:^punct:]]", "") # keep only punctuation marks

# DIGITS
gene_names %>%
  stringr::str_replace_all("[[:digit:]]", "") # remove ALL digits

gene_names %>%
  stringr::str_replace_all("[[:^digit:]]", "") # keep only digits

## Complex case
gene_names %>%
  stringr::str_replace_all("[[:punct:]]", " ") %>% # remove ALL punctuation marks
  stringr::str_squish() %>% # remove extra whitespaces
  stringr::str_replace_all(" ", "_") # replace whitespaces for a lower bar

# CLEAN PROTEIN NAMES
protein_names <- c("A1BG_HUMAN", "A1CF_HUMAN")

protein_names %>%
  stringr::str_replace_all("_HUMAN", "") # remove "_HUMAN" pattern

# or

protein_names %>%
  stringr::str_replace_all("_.*", "") # remove everything after _

# SPLIT AMINO ACID SEQUENCE
## (by inserting a whitespace each X)
sequence <- "MSTGDSFETRFEKMDNLLRDPKSEVNSDCLLDGLDALVYDLDFPALRKNKN"

sequence %>%
  str_replace_all("(.{1})", "\\1 ") # each 1 AA

sequence %>%
  str_replace_all("(.{2})", "\\1 ") # each 2 AAs

sequence %>%
  str_replace_all("(.{3})", "\\1 ") # each 3 AAs

# COMPLEX CASE: CLEANING FOOD DIETARY RECORDS WITH stringr AND dplyr

# Vignette: https://pcastellanoescuder.github.io/fobitools/articles/dietary_data_annotation.html
# Code: https://github.com/pcastellanoescuder/fobitools/blob/master/R/annotate_foods.R
