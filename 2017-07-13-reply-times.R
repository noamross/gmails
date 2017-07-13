library(tidyverse)
library(gmailr)
library(pblapply)
gmail_auth() # This has to have been run previously so that the token is available

mythreads <- threads("from:ross@ecohealthalliance.org", num_results=10000)


thread_ids <- mythreads %>%  
  map("threads") %>% 
  { invoke("c", .) } %>% 
  transpose %>% 
  as_tibble() %>% 
  mutate_all(flatten_chr)

# This takes a few minutes, so pblapply prints a nice progress par in
# interactive mode.  `cl` parallelizes on a multicore machine.
thread_bodies <- pblapply(thread_ids$id, thread, cl=2)


thread_data <- thread_bodies %>% 
  discard(~length(.$messages) == 1) %>% 
  map_df(~tibble(thread_id=.$id, message_id= map_chr(.$messages, "id"), message = .$messages))

thread_data2 <- thread_data %>% 
  mutate(msg_data = map(message, ~tibble(from = from(.), to = to(.) %||% NA_character_, subject = subject(.) %||% NA_character_, date=date(.) %||% NA_character_))) %>% 
  unnest(msg_data) %>% 
  select(-message) %>% 
  mutate(date = as.POSIXct(
    stri_replace(date, "^(\\w{3}\\,)?([^\\+\\-]+((\\+|\\-)\\d{4}))", "$2"),
    format = "%d %b %Y %T %z"))

thread_data3 <- thread_data2 %>% 
  mutate(my_reply = stri_detect_fixed(from, "ross@ecohealthalliance.org") & (message_seq != 1) & stri_detect_regex(subject, "^Re\\:")) %>% 
  group_by(thread_id) %>% 
  arrange(date, .by_group = TRUE) %>% 
  mutate(message_seq = seq_len(n()),
         reply_time = as.numeric(if_else(my_reply, date - lag(date), NA_real_), "days"),
         reply_time_na = my_reply & is.na(reply_time)) %>% 
  group_by()

thread_data3 %>% 
  arrange(-reply_time) %>% 
  head

ggplot(thread_data3, aes(x=floor(reply_time))) + geom_histogram() + scale_x_log10(breaks=c(0.1, 0.2, 0.5, 1,2,5,10,20,50,100,150,200))



thread_data3 <- thread_data2 %>% 
  mutate(headers = map(message, function(x) {
    x = transpose(x$payload$headers)
    structure(x$value, .Names = x$name)
  })) %>% 
  mutate(in_reply_to = map_chr(headers, "In-Reply-To", .null=NA),
         msg_header_id = map_chr(headers, function(x) {
           x$`Message-ID` %||% x$`Message-Id` %||% NA
         }))

sum(na.omit(thread_data3$in_reply_to) %in% na.omit(thread_data3$msg_header_id))
nrow(thread_data3)
