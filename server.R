# server.R
# load needed library
library(shiny)
library(shinydashboard)
library(plotly)

# read in functions and data
source("./scripts/map.R")
source("./scripts/pie.R")
source("./scripts/plot.R")
source("./scripts/sorted_data.R")
source("./scripts/sankey.R")

# start shiny server
shinyServer(function(input, output, session){
  # select all
  observe({
    # select all event for states
    if (input$selectall_state == 0) {
      return(NULL) 
    } else if (input$selectall_state%%2 == 0) {
      updateCheckboxGroupInput(session,
                               "sankey_state",
                               label = "State of Your Choice",
                               choices = unique(modified_data$area),
                               selected = "Alabama",
                               inline = TRUE)
    } else {
      updateCheckboxGroupInput(session,
                               "sankey_state",
                               label = "State of Your Choice",
                               choices = unique(modified_data$area),
                               selected = unique(modified_data$area),
                               inline = TRUE)
    }
    
    # select all event for races
    if (input$selectall_race == 0) {
      return(NULL) 
    } else if (input$selectall_race%%2 == 0) {
      updateCheckboxGroupInput(session,
                               "sankey_race",
                               label = "Race of Your Choice",
                               choices = unique(modified_data$race),
                               selected = "All Races")
    } else {
      updateCheckboxGroupInput(session,
                               "sankey_race",
                               label = "Race of Your Choice",
                               choices = unique(modified_data$race),
                               selected = unique(modified_data$race))
    }
    
    # select all event for gender
    if (input$selectall_sex == 0) {
      return(NULL) 
    } else if (input$selectall_sex%%2 == 0) {
      updateCheckboxGroupInput(session,
                               "sankey_sex",
                               label = "Gender of Your Choice",
                               choices = unique(modified_data$sex),
                               selected = "Male and Female")
    } else {
      updateCheckboxGroupInput(session,
                               "sankey_sex",
                               label = "Gender of Your Choice",
                               choices = unique(modified_data$sex),
                               selected = unique(modified_data$sex))
    }
    
    # select all event for site
    if (input$selectall_site == 0) {
      return(NULL) 
    } else if (input$selectall_site%%2 == 0) {
      updateCheckboxGroupInput(session,
                               "sankey_site",
                               label = "Site of Your Choice",
                               choices = unique(modified_data$site),
                               selected = "All Cancer Sites Combined",
                               inline = TRUE)
    } else {
      updateCheckboxGroupInput(session,
                               "sankey_site",
                               label = "Site of Your Choice",
                               choices = unique(modified_data$site),
                               selected = unique(modified_data$site),
                               inline = TRUE)
    }
  })
  
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

