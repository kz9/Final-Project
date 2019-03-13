# for shiny website structure
# load needed library
library(shiny)
library(shinydashboard)
library(plotly)

source("./scripts/sorted_data.R")

shinyUI(fluidPage(
  theme = "style.css",
  titlePanel("Cancer Information"),
  dashboardPage(
    skin = "purple",
    dashboardHeader(
      title = "Dashboard",
      titleWidth = 300
    ),
    dashboardSidebar(
      width = 300,
      
      # setup icon for each tab
      sidebarMenu(
        menuItem("HomePage", tabName = "home", icon = icon("dashboard")),
        menuItem("Cancer USA Distribution", tabName = "map",
                 icon = icon("globe")),
        menuItem("Gender VS Site", tabName = "line",
                 icon = icon("chart-line")),
        menuItem("State VS Site", tabName = "pie",
                 icon = icon("chart-pie")),
        menuItem("Information Flow", tabName = "sankey",
                 icon = icon("th"))
        
      )
  ),
  # position for different plots
  dashboardBody(
    tabItems(
      
      # Home Page
      tabItem(
        tabName = "home"
        
      ),
      
      # Map Graph
      tabItem(
        tabName = "map",
        h1("Cancer Map"),
        box(
          plotlyOutput("map_output")
        ),
        h2("Options"),
        box(
          color = "purple",
          selectInput(
            "map_options",
            label = "Data Show On Map",
            choices = list(
              "Age Adjusted Rate" = "age_adjusted_rate",
              "Cancer population" = "population",
              "Crude Rate"        = "crude_rate"
            ),
            selected = "Cancer population"
          ),
          sliderInput(
            "map_year",
            label = "Select your desired year range",
            min = min(modified_data$year),
            max = max(modified_data$year),
            value = c(min, max)
          )
        )
      ),
      
      # Line Graph
      tabItem(
        tabName = "line",
        h1("Gender VS Site Line Chart"),
        box(
          plotlyOutput("plot_output")
        ),
        h2("Options"),
        box(
          color = "purple",
          checkboxGroupInput(
            "plot_gender",
            label = "Gender of Your Choice",
            choices = list(
              "Female" = "Female",
              "Male"   = "Male",
              "Male and Female" = "Male and Female"
            ),
            selected = "Male and Female"
          ),
          selectInput(
            "plot_site",
            label = "Site of Your Choice",
            choices = unique(modified_data$site),
            selected = "All Cancer Sites Combined"
          ),
          selectInput(
            "plot_option",
            label = "Feature of Your Choice",
            choices = list(
            "Age Adjust Rage" = "age_adjusted_rate",
            "Cancer Population" = "population",
            "Crude Rate" = "crude_rate"
            ),
            selected = "Cancer Population"
          ),
          sliderInput(
            "plot_year",
            label = "Select your desired year range",
            min = min(modified_data$year),
            max = max(modified_data$year),
            value = c(min, max)
          )
        )
      ),
      
      # tab for pie chart
      tabItem(
        tabName = "pie",
        h1("State VS Site Pie Chart"),
        box(
          plotOutput("pie_output")
        ),
        box(
          color = "purple",
          selectInput(
            "pie_state",
            label = "State of Your Choice",
            choices = unique(modified_data$area),
            selected = "Alaska"
            ),
          selectInput(
            "pie_site",
            label = "Site of Your Choice",
            choices = unique(modified_data$site),
            selected = "All Cancer Sites Combined"
          ),
          sliderInput(
            "pie_year",
            label = "Select your desired year range",
            min = min(modified_data$year),
            max = max(modified_data$year),
            value = c(min, max)
          )
        )
      ),
      
      # tab for sankey diagram
      tabItem(
        tabName = "sankey",
        h1("Cancer Information Flow in Sankey Diagram"),
        box(
          plotlyOutput("sankey_output")
        ),
        h2("Options"),
        box(
          color = "purple",
          actionLink("selectall_state","Select All State"),
          checkboxGroupInput(
            "sankey_state",
            label = "State of Your Choice",
            choices = unique(modified_data$area),
            selected = "Alabama"
          ),
          actionLink("selectall_race","Select All Race"),
          checkboxGroupInput(
            "sankey_race",
            label = "Race of Your Choice",
            choices = unique(modified_data$race),
            selected = "All Races"
          ),
          actionLink("selectall_sex","Select All Genders"),
          checkboxGroupInput(
            "sankey_sex",
            label = "Gender of Your Choice",
            choices = unique(modified_data$sex),
            selected = "Male and Female"
          ),
          actionLink("selectall_site","Select All Sites"),
          checkboxGroupInput(
            "sankey_site",
            label = "Site of Your Choice",
            choices = unique(modified_data$site),
            selected = "All Cancer Sites Combined"
          ),
          sliderInput(
            "sankey_year",
            label = "Select your desired year range",
            min = min(modified_data$year),
            max = max(modified_data$year),
            value = c(min, max)
          )
        )
      )
    )
  )
  # navbarPage(
  # "Cancer",
  # 
  # # tab for map
  # tabPanel(
  #   "Cancer Map",
  #   titlePanel("Cancer Map Options"),
  #   sidebarLayout(
  #     sidebarPanel(
  #       selectInput(
  #         "map_options",
  #         label = "Data Show On Map",
  #         choices = list(
  #           "Age Adjusted Rate" = "age_adjusted_rate",
  #           "Cancer population" = "population",
  #           "Crude Rate"        = "crude_rate"
  #         ),
  #         selected = "Cancer population"
  #       ),
  #       sliderInput(
  #         "map_year",
  #         label = "Select your desired year range",
  #         min = min(modified_data$year),
  #         max = max(modified_data$year),
  #         value = c(min, max)
  #       )
  #     ),
  #     # map position
  #     mainPanel(
  #       plotlyOutput("map_output")
  #     )
  #   )
  # ),
  # 
  # # tab for line plot
  # tabPanel(
  #   "Gender VS Site",
  #   titlePanel("Gender Versus Site Options"),
  #   sidebarLayout(
  #     sidebarPanel(
  #       checkboxGroupInput(
  #         "plot_gender",
  #         label = "Gender of Your Choice",
  #         choices = list(
  #           "Female" = "Female",
  #           "Male"   = "Male",
  #           "Male and Female" = "Male and Female"
  #         ),
  #         selected = "Male and Female"
  #       ),
  #       selectInput(
  #         "plot_site",
  #         label = "Site of Your Choice",
  #         choices = unique(modified_data$site),
  #         selected = "All Cancer Sites Combined"
  #       ),
  #       selectInput(
  #         "plot_option",
  #         label = "Feature of Your Choice",
  #         choices = list(
  #           "Age Adjust Rage" = "age_adjusted_rate",
  #           "Cancer Population" = "population",
  #           "Crude Rate" = "crude_rate"
  #         ),
  #         selected = "Cancer Population"
  #       ),
  #       sliderInput(
  #         "plot_year",
  #         label = "Select your desired year range",
  #         min = min(modified_data$year),
  #         max = max(modified_data$year),
  #         value = c(min, max)
  #       )
  #     ),
  #     # plot position
  #     mainPanel(
  #       plotlyOutput("plot_output")
  #     )
  #   )
  # ),
  # 
  # # tab for 3D pie chart
  # tabPanel(
  #   "State VS Site",
  #   titlePanel("State Versus Site options"),
  #   sidebarLayout(
  #     sidebarPanel(
  #       selectInput(
  #         "pie_state",
  #         label = "State of Your Choice",
  #         choices = unique(modified_data$area),
  #         selected = "Alaska"
  #       ),
  #       selectInput(
  #         "pie_site",
  #         label = "Site of Your Choice",
  #         choices = unique(modified_data$site),
  #         selected = "All Cancer Sites Combined"
  #       ),
  #       sliderInput(
  #         "pie_year",
  #         label = "Select your desired year range",
  #         min = min(modified_data$year),
  #         max = max(modified_data$year),
  #         value = c(min, max)
  #       )
  #     ),
  #     
  #     # pie position
  #     mainPanel(
  #       plotOutput("pie_output")
  #     )
  #   )
  # ),
  # # tab for Sankey diagram
  # tabPanel(
  #   "Sankey Diagram",
  #   titlePanel("Sankey Diagram options"),
  #   sidebarLayout(
  #     sidebarPanel(
  #       checkboxGroupInput(
  #         "sankey_state",
  #         label = "State of Your Choice",
  #         choices = unique(modified_data$area),
  #         selected = "Alabama"
  #       ),
  #       checkboxGroupInput(
  #         "sankey_race",
  #         label = "Race of Your Choice",
  #         choices = unique(modified_data$race),
  #         selected = "All Races"
  #       ),
  #       checkboxGroupInput(
  #         "sankey_sex",
  #         label = "Gender of Your Choice",
  #         choices = unique(modified_data$sex),
  #         selected = "Male and Female"
  #       ),
  #       checkboxGroupInput(
  #         "sankey_site",
  #         label = "Site of Your Choice",
  #         choices = unique(modified_data$site),
  #         selected = "All Cancer Sites Combined"
  #       ),
  #       sliderInput(
  #         "sankey_year",
  #         label = "Select your desired year range",
  #         min = min(modified_data$year),
  #         max = max(modified_data$year),
  #         value = c(min, max)
  #       )
  #     ),
  #     
  #     # Sankey position
  #     mainPanel(
  #       plotlyOutput("sankey_output")
  #     )
  #   )
  # )
)))
