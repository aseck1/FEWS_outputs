library(ggplot2)
#library(Cairo)   # For nicer ggplot2 output when deployed on Linux

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
                    plotOutput("plot3", height = 300)
             )
           )
    
    
  
)

server <- function(input, output) {
  
  
  
  # -------------------------------------------------------------------
  # Linked plots (middle and right)
  ranges2 <- reactiveValues(x = NULL, y = NULL)
  
  output$plot2 <- renderPlot({
    #ggplot(mtcars, aes(wt, mpg)) +
     # geom_point()
    plot(data.df$datetime, 
         data.df$discharge_daily,
         type="l",
         xlab="",
         ylab="Flow (cfs)",
         col = "blue",
         frame.plot=TRUE)
    
    lines(lffs_daily_data1.df$datetime,
          lffs_daily_data1.df$discharge_daily,
          lty=2, lwd=2, col="red")
    
    lines(lffs_daily_data2.df$datetime,
          lffs_daily_data2.df$discharge_daily,
          lty=1, lwd=2, col="green")
    
    
  })
  
  output$plot3 <- renderPlot({
    #ggplot(mtcars, aes(wt, mpg)) +
     # geom_point() +
      #coord_cartesian(xlim = ranges2$x, ylim = ranges2$y, expand = FALSE)
    plot(data.df$datetime, 
         data.df$discharge_daily,
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