h <- function(n, f = -1, g = 1) {
  for(i in 1:n) {
    f <- f + g
    g <- f - g
  }
  return(g)
}
f <- 1
g <- 0
h(5, g, f)
y <- numeric(5)
class(y)
x <- c(1:3, 4:6, 7:9)
x[9]
y <- list(a = 1:3, b = 4:6, c = 7:9)
y[[2]]
z <- data.frame(a = 1:3, b = 4:6, c = 7:9)
z$c