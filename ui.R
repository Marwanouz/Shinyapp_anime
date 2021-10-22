library("readr")
# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}



ui <- fluidPage(
      titlePanel("Anime Exploreur"),
      fluidRow(
        column(3,
               wellPanel(
                 h4("Quels genres sont les plus représentés au sein de chaque type ?"),
                 sliderInput("Rating", "Sélection des films ayant eu une note entre :",
                             0, 10, c(0, 10), step = 1),
                 selectInput("Genre", "Sélection du Genre d'anime : ",
                             c("All",  "Drama", "Romance","School", "Supernatural", "Action",
                               "Comedy", "Historical", "Parody", "Samurai", "Sci-Fi", 
                               "Shounen", "Adventure", "Fantasy", "Slice of Life",
                               "Mystery",	"Seinen", "Vampire", "Thriller", "Mecha",
                               "Space", "Super Power", "Shoujo", "Military",
                               "Shounen Ai", "Magic", "Psychological", "Dementia",
                               "Police", "Sports", "Music", "Demons", "Horror", "Cars",
                               "Kids", "Game", "Martial Arts", "Josei", "Shoujo Ai", "Ecchi",
                               "Harem", "Hentai", "Yaoi", "Yuri")),
                 selectInput("Type", "Sélection du type d'anime",
                                         c("Non spécifié","Movie", "Special","OVA", "Music", "ONA",
                                           "TV") 
                             )
                                           
        )
        ),
        mainPanel(plotOutput("graph_1")),
        
        column(3,
               wellPanel(
                 h4("Quels genres sont les mieux notés ?"),
                 sliderInput("Rating_2", "Sélection des films ayant eu une note entre :",
                             0, 10, c(0, 10), step = 1),
                 sliderInput("Top", "Explorer les n meilleurs animes par genre :",
                             value = 100, min = 0, max = 100)
               )
          
        ),
        mainPanel(tabsetPanel(type = "tabs",
                              tabPanel("Plot", plotOutput("graph_2")),
                              tabPanel("Table", DT::dataTableOutput("table_1")))
                  
                  
        ),
      
      column(3,
             wellPanel(
               h4("Trouve des animes de ton genre préféré :"),
               selectInput("Genre_3", "Sélection du Genre d'anime : ",
                           c("All",  "Drama", "Romance","School", "Supernatural", "Action",
                             "Comedy", "Historical", "Parody", "Samurai", "Sci-Fi", 
                             "Shounen", "Adventure", "Fantasy", "Slice of Life",
                             "Mystery",	"Seinen", "Vampire", "Thriller", "Mecha",
                             "Space", "Super Power", "Shoujo", "Military",
                             "Shounen Ai", "Magic", "Psychological", "Dementia",
                             "Police", "Sports", "Music", "Demons", "Horror", "Cars",
                             "Kids", "Game", "Martial Arts", "Josei", "Shoujo Ai", "Ecchi",
                             "Harem", "Hentai", "Yaoi", "Yuri")),
               sliderInput("Rating_3", "Sélection des films ayant eu une note entre :",
                           0, 10, c(0, 10), step = 1),
               selectInput("Type", "Sélection du type d'anime",
                           c("Non spécifié","Movie", "Special","OVA", "Music", "ONA",
                             "TV") 
               )
               
               
             )),
      
      mainPanel(DT::dataTableOutput("table_2"))
          
          
    )
    )

ui