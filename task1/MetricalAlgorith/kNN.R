

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

  sidebarLayout(
    sidebarPanel(
      sliderInput("num",
                  "Число соседей:",
                  min = 1,
                  max = 10,
                  value = 1)
    ),
    mainPanel(
      plotOutput("carsPlot")
    )
 
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  euclideanDistance <- function(u, v)
  {
    sqrt(sum((u - v)^2))
  }
  sortObjectsByDist <- function(xl, z, metricFunction = euclideanDistance)
  {
    l <- dim(xl)[1]
    n <- dim(xl)[2] - 1
    ## Создаём матрицу расстояний
    distances <- matrix(NA, l, 2)
    for (i in 1:l)
    {
      distances[i, ] <- c(i, metricFunction(xl[i, 1:n], z))
    }
    ## Сортируем
    orderedXl <- xl[order(distances[, 2]), ]
    return (orderedXl);
  }
  
  ## Применяем метод kNN
  kNN <- function(xl, z)
  {
    ## Сортируем выборку согласно классифицируемого объекта
    orderedXl <- sortObjectsByDist(xl, z)
    n <- dim(orderedXl)[2] - 1
    ## Получаем классы первых k соседей
    classes <- orderedXl[1:input$num, n + 1]
    ##Составляем таблицу встречаемости каждого класса
    counts <- table(classes)
    ## Находим класс, который доминирует среди первых k соседей
    class <- names(which.max(counts))
    return (class)
  }
  
  
  colors <- c("setosa" = "red", "versicolor" = "green3",
              "virginica" = "blue")
  output$carsPlot <- renderPlot({
    plot(iris[, 3:4], pch = 10, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)
    z <- c(4.5, 2)
    xl <- iris[, 3:5]
    class <- kNN(xl, z)
    points(z[1], z[2], pch = 22, bg = colors[class], asp = 1)
  })
 
 
}

# Run the application 
shinyApp(ui = ui, server = server)