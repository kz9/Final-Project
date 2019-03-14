# for shiny website structure
# load needed library
library(shiny)
library(shinydashboard)
library(shinyalert)
library(markdown)
library(plotly)

source("./scripts/sorted_data.R")

shinyUI(fluidPage(
  dashboardPage(
    skin = "purple",
    dashboardHeader(
      title = "Cancer Information",
      titleWidth = 300
    ),
    dashboardSidebar(
      width = 300,

      # setup icon for each tab
      sidebarMenu(
        menuItem("HomePage", tabName = "home", icon = icon("home")),
        menuItem("Cancer USA Distribution",
          tabName = "map",
          icon = icon("globe")
        ),
        menuItem("State VS Site",
          tabName = "pie",
          icon = icon("chart-pie")
        ),
        menuItem("Gender VS Site",
          tabName = "line",
          icon = icon("chart-line")
        ),
        menuItem("Race VS Site",
          tabName = "bar",
          icon = icon("chart-bar")
        ),
        menuItem("Information Flow",
          tabName = "sankey",
          icon = icon("th")
        )
      )
    ),
    # position for different plots
    dashboardBody(
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
      ),
      tabItems(

        # Home Page
        tabItem(
          tabName = "home",
          includeMarkdown("./markdown/home.md")
        ),

        # Map Graph
        tabItem(
          tabName = "map",
          h1("Cancer Map"),
          includeMarkdown("./markdown/map.md"),
          fluidRow(
            box(
              width = 12,
              status = "success",
              plotlyOutput("map_output")
            )
          ),
          h2("Options"),
          fluidRow(
            box(
              width = 12,
              status = "info",
              selectInput(
                "map_options",
                label = "Data Show On Map",
                choices = list(
                  "Age Adjusted Rate" = "age_adjusted_rate",
                  "Cancer population" = "count",
                  "Total population" = "population",
                  "Crude Rate" = "crude_rate"
                ),
                selected = "Age Adjusted Rate"
              ),
              sliderInput(
                "map_year",
                label = "Select your desired year range",
                min = min(modified_data$year),
                max = max(modified_data$year),
                value = c(min, max)
              )
            )
          )
        ),

        # tab for pie chart
        tabItem(
          tabName = "pie",
          fluidRow(
            h1("State VS Site Pie Chart"),
            h2("Options"),
            hr()
          ),
          fluidRow(
            box(
              status = "success",
              plotOutput("pie_output")
            ),
            box(
              height = 423,
              status = "info",
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
          includeMarkdown("./markdown/pie.md")
        ),

        # Line Graph
        tabItem(
          tabName = "line",
          h1("Gender VS Site Line Chart"),
          includeMarkdown("./markdown/line.md"),
          fluidRow(
            box(
              width = 12,
              status = "success",
              plotlyOutput("plot_output")
            )
          ),
          h2("Options"),
          fluidRow(
            box(
              width = 12,
              status = "info",
              checkboxGroupInput(
                "plot_gender",
                label = "Gender of Your Choice",
                choices = list(
                  "Female" = "Female",
                  "Male" = "Male",
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
                  "Age Adjusted Rate" = "age_adjusted_rate",
                  "Cancer Population" = "count",
                  "Crude Rate" = "crude_rate"
                ),
                selected = "Age Adjusted Rate"
              ),
              sliderInput(
                "plot_year",
                label = "Select your desired year range",
                min = min(modified_data$year),
                max = max(modified_data$year),
                value = c(min, max)
              )
            )
          )
        ),

        # Bar Graph
        tabItem(
          tabName = "bar",
          h1("Race VS Site Bar Chart"),
          includeMarkdown("./markdown/bar.md"),
          fluidRow(
            box(
              width = 12,
              status = "success",
              plotlyOutput("bar_output")
            )
          ),
          h2("Options"),
          fluidRow(
            box(
              width = 12,
              status = "info",
              useShinyalert(),
              checkboxGroupInput(
                "bar_race",
                label = "Race of Your Choice",
                choices = list(
                  "All Races", "White",
                  "Black", "Hispanic",
                  "Asian/Pacific Islander",
                  "American Indian/Alaska Native"
                ),
                selected = "All Races"
              ),
              selectInput(
                "bar_site",
                label = "Site of Your Choice",
                choices = unique(modified_data$site),
                selected = "All Cancer Sites Combined"
              ),
              selectInput(
                "bar_option",
                label = "Feature of Your Choice",
                choices = list(
                  "Age Adjusted Rate" = "age_adjusted_rate",
                  "Cancer Population" = "count",
                  "Crude Rate" = "crude_rate"
                ),
                selected = "Age Adjusted Rate"
              ),
              sliderInput(
                "bar_year",
                label = "Select your desired year range",
                min = min(modified_data$year),
                max = max(modified_data$year),
                value = c(min, max)
              )
            )
          )
        ),

        # tab for sankey diagram
        tabItem(
          tabName = "sankey",
          h1("Cancer Information Flow in Sankey Diagram"),
          includeMarkdown("./markdown/sankey.md"),
          fluidRow(
            box(
              width = 12,
              status = "success",
              plotlyOutput("sankey_output")
            )
          ),
          h2("Options"),
          fluidRow(
            box(
              status = "info",
              actionButton("selectall_state", "Select All State/Unselect All"),
              checkboxGroupInput(
                "sankey_state",
                label = "State of Your Choice",
                choices = unique(modified_data$area),
                selected = "Alabama",
                inline = TRUE
              )
            ),
            box(
              status = "info",
              actionButton("selectall_site", "Select All Sites/Unselect All"),
              checkboxGroupInput(
                "sankey_site",
                label = "Site of Your Choice",
                choices = unique(modified_data$site),
                selected = "All Cancer Sites Combined",
                inline = TRUE
              )
            )
          ),
          fluidRow(
            box(
              status = "info",
              actionButton("selectall_sex", "Select All Genders/Unselect All"),
              checkboxGroupInput(
                "sankey_sex",
                label = "Gender of Your Choice",
                choices = unique(modified_data$sex),
                selected = "Male and Female"
              )
            ),
            box(
              status = "info",
              actionButton("selectall_race", "Select All Race/Unselect All"),
              checkboxGroupInput(
                "sankey_race",
                label = "Race of Your Choice",
                choices = unique(modified_data$race),
                selected = "All Races"
              )
            ),
            box(
              width = 12,
              status = "info",
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
    )
  )
))
