# server.R
# load needed library
library(shiny)
library(shinydashboard)
library(shinyalert)
library(shinyjs)
library(markdown)
library(plotly)

# read in functions and data
source("./scripts/map.R")
source("./scripts/pie.R")
source("./scripts/plot.R")
source("./scripts/sorted_data.R")
source("./scripts/sankey.R")
source("./scripts/bar.R")

# start shiny server
shinyServer(function(input, output, session){
  # when Asian/Pacific Islander and American Indian/Alaska Native clicked
  # with All Cancer Sites Combined selected
  observeEvent(input$bar_race, {
    if (("Asian/Pacific Islander" %in% input$bar_race |
        "American Indian/Alaska Native" %in% input$bar_race) &
        input$bar_site == "All Cancer Sites Combined") {
      shinyalert("Oops!",
          "The race you selected don't have All Cancer Sites Combined Value",
          type = "error")
    }
  })
  
  # restrict checkbox
  observe({
    # setup selected
    if (("Asian/Pacific Islander" %in% input$bar_race |
        "American Indian/Alaska Native" %in% input$bar_race) &
        input$bar_site == "All Cancer Sites Combined")  {
      updateCheckboxGroupInput(session,
                               "bar_race",
                               label = "Race of Your Choice",
                               choices = unique(modified_data$race),
                               selected = input$bar_race[input$bar_race !=
                                          "Asian/Pacific Islander" &
                                            input$bar_race !=
                                            "American Indian/Alaska Native"])
    }
    
    # restrict checkbox for line graph
    if (length(input$plot_gender) < 1) {
      updateCheckboxGroupInput(session,
                               "plot_gender",
                               label = "Gender of Your Choice",
                               choices = list(
                                 "Female" = "Female",
                                 "Male"   = "Male",
                                 "Male and Female" = "Male and Female"
                               ),
                               selected = "Male and Female")
    }
    
    # restrict checkbox for bar graph
    if (length(input$bar_race) < 1) {
      updateCheckboxGroupInput(session,
                               "bar_race",
                               label = "Race of Your Choice",
                               choices = unique(modified_data$race),
                               selected = "All Races")
    }
    
    # restrict checkbox for sankey diagram state
    if (length(input$sankey_state) < 1) {
      updateCheckboxGroupInput(session,
                               "sankey_state",
                               label = "State of Your Choice",
                               choices = unique(modified_data$area),
                               selected = "Alabama",
                               inline = TRUE)
    }
    
    # restrict checkbox for sankey diagram site
    if (length(input$sankey_site) < 1) {
      updateCheckboxGroupInput(session,
                               "sankey_site",
                               label = "Site of Your Choice",
                               choices = unique(modified_data$site),
                               selected = "All Cancer Sites Combined",
                               inline = TRUE)
    }
    
    # restrict checkbox for sankey diagram gender
    if (length(input$sankey_sex) < 1) {
      updateCheckboxGroupInput(session,
                               "sankey_sex",
                               label = "Gender of Your Choice",
                               choices = unique(modified_data$sex),
                               selected = "Male and Female")
    }
    
    # restrict checkbox for sankey diagram race
    if (length(input$sankey_race) < 1) {
      updateCheckboxGroupInput(session,
                               "sankey_race",
                               label = "Race of Your Choice",
                               choices = unique(modified_data$race),
                               selected = "All Races")
    }
  })
  
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
  })
  
  observe({
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
  
  observe({
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
  })
  
  observe({
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
  })
  
  # map graph
  output$map_output <- renderPlotly({
    build_map(modified_data, input$map_options, input$map_year[1],
              input$map_year[2])
  })
  
  # pie graph
  output$pie_output <- renderPlot({
    build_pie(modified_data, input$pie_state, input$pie_site,
              input$pie_year[1], input$pie_year[2])
  })
  
  # plot graph
  output$plot_output <- renderPlotly({
    build_line(modified_data, input$plot_gender, input$plot_site,
               input$plot_year[1], input$plot_year[2], input$plot_option)
  })
  
  # bar graph
  output$bar_output <- renderPlotly({
    build_bar(modified_data, input$bar_race, input$bar_site,
              input$bar_year[1], input$bar_year[2], input$bar_option)
  })
  
  # Sankey Diagram
  output$sankey_output <- renderPlotly({
    build_sankey(modified_data, input$sankey_state, input$sankey_race,
                 input$sankey_sex, input$sankey_year[1], input$sankey_year[2],
                 input$sankey_site)
  })
})

