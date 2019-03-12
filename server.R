# server.R
# load needed library
library(shiny)
library(shinythemes)
library(plotly)

# read in functions and data
source("./scripts/map.R")
source("./scripts/pie.R")
source("./scripts/plot.R")
source("./scripts/sorted_data.R")

# start shiny server
shinyServer(function(input, output){
  # map graph
  output$map_output <- renderPlotly({
    build_map(modified_data, input$map_options, input$map_year[1],
              input$map_year[2])
  })
  
  # plot graph
  output$plot_output <- renderPlotly({
    build_line(modified_data, input$plot_gender, input$plot_site,
               input$plot_year[1], input$plot_year[2], input$plot_option)
  })
  
  # pie graph
  output$pie_output <- renderPlot({
    build_pie(modified_data, input$pie_state, input$pie_site,
              input$pie_year[1], input$pie_year[2])
  })
  
  # Sankey Diagram
  output$sankey_output <- renderPlotly({
    build_sankey(modified_data, input$sankey_state, input$sankey_race,
                 input$sankey_sex, input$sankey_year[1], input$sankey_year[2],
                 input$sankey_site)
  })
})

