library("dplyr")                                                  
library("tidyverse")
library("ggplot2")
library("rlang")
library("ggforce")
library("shinydashboard")
library("plyr")
library("DT")

server <-   function(input, output, session) {
            
            
    
  dat <- list.files(path = "temp",     
                    pattern = "*.csv", full.names = TRUE) %>% 
    ldply(read_csv)
  
  
  
              output$graph_1 <- renderPlot({
                # Filter the movies, returning a data frame
                # Due to dplyr issue #318, we need temp variables for input values
                Type <- input$Type
                minrating <- input$Rating[1]
                maxrating <- input$Rating[2]
                
                dat <- dat %>% 
                  drop_na()
                
                dat %>% 
                  select(episodes) %>%  
                  distinct() 
                
                dat <- dat %>% 
                  filter(!(episodes == "Unknown"))
                
                # Apply filters
                m <- dat %>%
                  filter(
                    rating >= minrating,
                    rating <= maxrating
                  )
                
              
                
                anime <- m %>%
                                  separate_rows(genre, sep = ",") %>% 
                                  mutate(genre = str_trim(genre, side = "both")) %>%  
                                  select(genre,type) %>% 
                                  group_by(genre) %>% 
                                  mutate(., value = 1) %>% 
                                  pivot_wider(names_from = genre, values_from = value, values_fill = 0, values_fn = length) %>% 
                                  gather(key = genre, value = Value, Drama:Yuri) %>% 
                                  group_by(type)
             
                # Optional: filter by genre
                if (input$Genre != "All") {
                  anime <- anime %>% filter(genre == input$Genre)
                }
                
                # Optional: filter by type
                if (input$Type != "Non spécifié") {
                  anime <- anime %>% filter(type == input$Type)
                }
              
                                          anime %>% 
                                                    ggplot(., aes(genre, Value, fill = type)) + geom_col(position = "dodge") + 
                                                    theme(axis.text.x = element_text(angle = 90))
                              })
              
              
              output$graph_2 <- renderPlot({
                
                minrating <- input$Rating_2[1]
                maxrating <- input$Rating_2[2]
                nb <- input$Top
                
                
                dat <- dat %>% 
                  drop_na()
                
                dat %>% 
                  select(episodes) %>%  
                  distinct() 
                
                dat <- dat %>% 
                  filter(!(episodes == "Unknown"))
                
                # Apply filters
                m <- dat %>%
                  filter(
                    rating >= minrating,
                    rating <= maxrating
                  )
                
                
                anime <- m %>%
                          separate_rows(genre, sep = ",") %>% 
                          mutate(genre = str_trim(genre, side = "both")) %>% 
                          group_by(genre)
                
               
                
                if (input$Top != "100") {
                  anime <- anime %>% slice_max(rating, n = input$Top)
                } 
                
                anime %>%
                  ggplot(., mapping = aes(x = genre, y = rating, fill = genre)) +
                  geom_boxplot(alpha=25) + 
                  coord_flip() +
                  theme(legend.position = "none")
                 
              })
                             
              
            output$table_1 <- DT:: renderDataTable({
              
              minrating <- input$Rating_2[1]
              maxrating <- input$Rating_2[2]
              nb <- input$Top
              
              
              dat <- dat %>% 
                drop_na()
              
              dat %>% 
                select(episodes) %>%  
                distinct() 
              
              dat <- dat %>% 
                filter(!(episodes == "Unknown"))
              
              # Apply filters
              m <- dat %>%
                filter(
                  rating >= minrating,
                  rating <= maxrating
                )
              
              
              anime <- m %>%
                separate_rows(genre, sep = ",") %>% 
                mutate(genre = str_trim(genre, side = "both")) %>% 
                group_by(genre)
              
              
              
              if (input$Top != "100") {
                anime <- anime %>% slice_max(rating, n = input$Top)
              } 
              
              anime
              
              
              
            })
            
            output$table_2 <- DT:: renderDataTable({
              
              minrating <- input$Rating_3[1]
              maxrating <- input$Rating_3[2]
              Genre <- input$Genre_3
              
              
              dat <- dat %>% 
                drop_na()
              
              dat %>% 
                select(episodes) %>%  
                distinct() 
              
              dat <- dat %>% 
                filter(!(episodes == "Unknown"))
              
              # Apply filters
              m <- dat %>%
                filter(
                  rating >= minrating,
                  rating <= maxrating
                )
              
              if (input$Genre != "All") {
                anime <- m %>% filter(grepl(Genre,genre))
              }
              
              if (input$Type != "Non spécifié") {
                anime <- m %>% filter(type == input$Type)
              }
              
              
              
              anime <- m %>%  select(name, type, rating, genre, episodes)
              anime
              
              
              
            })
            }