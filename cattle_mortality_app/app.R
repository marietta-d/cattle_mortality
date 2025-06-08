#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)
library(ggplot2)
library(reactable)
library(DT)
library(survival)
library(survminer)

cattle_data <- readRDS("C:/Users/i-mar//Desktop/MSc Data analytcs/placement/thesis_code/cattle_mortality_app/shiny_data.Rda")
new_cattle_data <- cattle_data[, c(4:6, 9:15)]
new_cattle_data <- new_cattle_data %>%
  rename(Production_type = Beef_or_Dairy, Place_of_death = Abattoir_._Died_on_Farm)
new_cattle_data

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Cattle mortality in Northern Ireland"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("selection",
                        "Risk factor",
                        c("All" = 1,
                          "Sex" = "Sex",
                          "Place of death" = "Place_of_death"),
                        )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("survival_curve"),
           reactableOutput("table")
        )
        

    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
    output$survival_curve <- renderPlot({
      formula_str <- paste("Surv(days_alive, status) ~", input$selection)
      survival_formula <- as.formula(formula_str)
      fit <- do.call(survfit, args = list(formula = survival_formula, data = new_cattle_data))
      ggsurvplot(fit, data = new_cattle_data)
    })
    output$table <- renderReactable({
      if(input$selection != 1){ 
      reactable(new_cattle_data,filterable= TRUE,
                groupBy = input$selection,
                columns = list(days_alive = colDef(aggregate="mean"),
                               Total_Conditions_per_Animal = colDef(aggregate = "mean")))
      }
      else{
        reactable(new_cattle_data,filterable= TRUE)
        
      }
    })

    

}

# Run the application 
shinyApp(ui = ui, server = server)

