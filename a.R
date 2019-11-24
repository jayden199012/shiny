
library("readxl")
library("ggplot2")
library("shiny")
library("dplyr")
library("usmap")
library(stringr)
setwd('E:/MGS_ML/annalect/first_assignment')
getwd()
df_name <- "us_news_data_annalect.xlsx"
df <-read_excel(sprintf('./%s', df_name),
                sheet='data')


names(df)[-1:-2] <- names(df)[-1:-2] %>% str_replace_all(
  c(
    "\\([^\\)]+\\)" = "",
    " " = "_",
    ".-" = "",
    ":" ="",
    "=" = "_is_"))
names(df)
min_yr <- min(df$year)
max_yr <- max(df$year)
names = names(df)[-1:-2]

ui <- fluidPage(titlePanel("Geographical Dsitribution"),
               
               sidebarPanel(
                 selectInput(
                   inputId = 'col_x',
                   label = 'Please Select a Variable',
                   choices = names
                 ),
                 selectInput(
                   inputId = 'col_y',
                   label = 'Please Select a Variable',
                   choices = names
                 )
                 ,
                 sliderInput(
                   inputId = 'Year',
                   label = "Year to Display",
                   min = min_yr,
                   max = max_yr,
                   value = 2005
                   
                 ),
                 
                 mainPanel(plotOutput(outputId = 'scatter_plot'))
               ))


server <- function(input, output){
  
  output$scatter_plot <-renderPlot({
    # df_ <- df %>% filter(year==input$year)
    df_ = df
    x <- input$col_x
    y <- input$col_y
    ggplot(data=df_, aes_string(x=`x`, y=`y`)) + geom_point()
  })
}

shinyApp(ui = ui, server = server)

names(df)
ggplot(data=df, aes(x=`R-Acceptance rate ('00)`, y="plo")) + geom_point()
