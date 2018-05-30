#Adapted from https://shiny.rstudio.com/gallery/plot-interaction-zoom.html
library(ggplot2)
#library(Cairo)   # For nicer ggplot2 output when deployed on Linux

source('functions/functions.R')

ui <- fluidPage(
           h4("To zoom in, brush on top plot"),
           fluidRow(
             column(width = 8,
                    plotOutput("plot2", height = 300,
                               brush = brushOpts(
                                 id = "plot2_brush",
                                 resetOnNew = TRUE
                               )
                    )
             ),
             column(width =8,
                    plotOutput("plot3", height = 500)
             )
           )
    
    
  
)

server <- function(input, output) {
  
########################################
usgs_data.df <- get_usgs("data/usgs_flow.csv")
lffs_daily_data1.df <- get_lffs("data/PM7_4820_0001_1.flow")
lffs_daily_data2.df <- get_lffs("data/PM7_4820_0001_2.flow")

  
  # -------------------------------------------------------------------
  # Linked plots (middle and right)
  ranges2 <- reactiveValues(x = NULL, y = NULL)

  
  output$plot2 <- renderPlot({
    #ggplot(mtcars, aes(wt, mpg)) +
     # geom_point()
    plot(usgs_data.df$datetime, 
         usgs_data.df$discharge_daily,
         type="l",
         xlab="",
         ylab="Flow (cfs)",
         col = "blue",
         frame.plot=TRUE,
         main = "Flow at Little Falls")
    
    lines(lffs_daily_data1.df$datetime,
          lffs_daily_data1.df$discharge_daily,
          lty=2, lwd=2, col="red")
    
    lines(lffs_daily_data2.df$datetime,
          lffs_daily_data2.df$discharge_daily,
          lty=1, lwd=2, col="green")
    
    legend("topright", inset=.04, legend=c("USGS", "LFFS_05_29_2018", "LFFS_03_12_2018" ), col=c("blue", "red", "green"), lty=1:1, cex=1.2)
  })
  
  output$plot3 <- renderPlot({
    #ggplot(mtcars, aes(wt, mpg)) +
     # geom_point() +
      #coord_cartesian(xlim = ranges2$x, ylim = ranges2$y, expand = FALSE)
    plot(usgs_data.df$datetime, 
         usgs_data.df$discharge_daily,
         type="l",
         xlab="",
         ylab="Flow (cfs)",
         col = "blue",
         frame.plot=TRUE,
         xlim=ranges2$x,
         ylim = ranges2$y)
    
    lines(lffs_daily_data1.df$datetime,
          lffs_daily_data1.df$discharge_daily,
          lty=2, lwd=2, col="red")
    
    lines(lffs_daily_data2.df$datetime,
          lffs_daily_data2.df$discharge_daily,
          lty=1, lwd=2, col="green")
  })
  
  # When a double-click happens, check if there's a brush on the plot.
  # If so, zoom to the brush bounds; if not, reset the zoom.
  observe({
    brush <- input$plot2_brush
    if (!is.null(brush)) {
      ranges2$x <- c(brush$xmin, brush$xmax)
      ranges2$y <- c(brush$ymin, brush$ymax)
      
    } else {
      ranges2$x <- NULL
      ranges2$y <- NULL
    }
  })
  
}

shinyApp(ui, server)