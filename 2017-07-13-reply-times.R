library(tidyverse)
library(gmailr)
library(purrrlyr)
library(pbapply)
library(parallel)
gmail_auth()
mymails <- messages("from:ross@ecohealthalliance.org", num_results=10000)

mythreads <- threads("from:ross@ecohealthalliance.org", num_results=10000)


thread_ids <- mythreads %>%  
  map("threads") %>% 
  { invoke("c", .) } %>% 
  transpose %>% 
  as_tibble() %>% 
  mutate_all(flatten_chr)

thread_bodies <- 
  pblapply(thread_ids$id, thread)
