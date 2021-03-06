## code to generate little "shape" images that we'll inject into the
## table.  I'm sure it'll give the typesetters a lot of grief though.

shape_base <- function(xlim, ylim=c(0, 1)) {
  par(mar=rep(0.1, 4))
  plot.new()
  plot.window(xlim, ylim)
  points(0, 0, pch=19, col="red")
  lines(c(0, 0), c(0, ylim[[2]]), lty=2, col="red")
}

shape_constant <- function() {
  shape_base(c(-4, 4), c(0, 1))
  f <- function(x) rep(0.8, length(x))
  curve(f, n=2, add=TRUE)
}

shape_gaussian <- function() {
  shape_base(c(-4, 4), c(0, 1))
  curve(dnorm(x) / dnorm(0), n=200, add=TRUE)
}

shape_platykurtic <- function() {
  shape_base(c(-4, 4), c(0, 1))
  curve(dnorm(x) / dnorm(0), n=200, add=TRUE, col="grey")
  curve(exp(-x^4), n=200, add=TRUE)
}

## Kisdi uses:
##
##  c * (1 - 1 / (1 + v * exp(- k * dx)))
shape_logistic <- function() {
  shape_base(c(-8, 8), c(0, 1))
  curve(1 / (1 + exp(-x)), n=200, add=TRUE)
}

shape_gaussian_offset <- function() {
  shape_base(c(-4, 4), c(0, dnorm(0)))
  curve(dnorm, n=200, add=TRUE, col="grey")
  curve(dnorm(x - 1), n=200, add=TRUE)
}

shape_exponential <- function() {
  xmax <- 1
  shape_base(c(-xmax, xmax), c(0, exp(xmax)))
  curve(exp, add=TRUE)
}

shape_gaussian_with_hat <- function() {
  shape_base(c(-4, 4), ylim=c(0, 1))
  curve(0.75*dnorm(x)/dnorm(0), n=200, add=TRUE, col="grey")
  f <- function(x) 0.75*exp(-x^4) + 0.25*dnorm(x, sd = 0.12)/dnorm(0, sd = 0.12)
  curve(f(x)/f(0), n=200, add=TRUE)
}

shape_laplacian <- function() {
  shape_base(c(-2, 2), c(0, 1))
  curve(exp(-2 * abs(x)), add=TRUE)
}

shape_gaussian_with_spike <- function() {
  shape_base(c(-4, 4), ylim=c(0, 1))
  curve(0.75*dnorm(x)/dnorm(0) , n=200, add=TRUE)
  lines(c(0, 0), c(0.75, 1), lwd=2)
}

shape_step_asymmetric <- function() {
  shape_base(c(-2, 2), c(0, 1))
  curve(0 + 0*x, from = -2, to=0, n=100, add=TRUE)
  curve(1 + 0*x, from = 0, to=2, n=100, add=TRUE)
}
