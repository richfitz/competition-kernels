## NOTE: If changing parameters, be sure to update (manually) the
## values in appendix sec:Rstar.
dat_rstar <- function() {
  x1 <- c(0.6, 0.5)
  x2 <- c(0.7, 0.9)
  C1 <- c(.2, .2) * 10
  C2 <- c(.3, .7)
  x1b <- c(0.6, 0.5)
  x2b <- c(0.9, 0.7)
  p1 <- rstar_parameters(rstar_mat_2_tradeoff, matrix(C1, nrow=2), S=0.5)
  p2 <- rstar_parameters(rstar_mat_2_tradeoff, matrix(C2, nrow=2), S=0.5)
  p1b <- rstar_parameters(rstar_mat_2_tradeoff, rstar_mat_2_tradeoff, S=0.5)
  p2b <- rstar_parameters(rstar_mat_2_tradeoff, rstar_mat_2_tradeoff, S=c(0.7, 0.3))
  list(dat_rstar1(p1, x1),
       dat_rstar1(p2, x2),
       dat_rstar1(p1b, x1b),
       dat_rstar1(p2b, x2b))
}

dat_rstar1 <- function(p, x_resident) {
  dat <- lapply(x_resident,
                function(xi) rstar_competition(matrix(xi, 1, 1), p))
  list(p=p,
       x=drop(dat[[1]]$x_invade),
       r=dat[[1]]$r_invade,
       K=dat[[1]]$K_invade,
       x1=x_resident[[1]],
       x2=x_resident[[2]],
       N1=dat[[1]]$N_resident,
       N2=dat[[2]]$N_resident,
       w1=dat[[1]]$w_invade,
       w2=dat[[2]]$w_invade,
       a1=dat[[1]]$alpha,
       a2=dat[[2]]$alpha)
}

fig_rstar <- function() {
  dat <- dat_rstar()
  dat1 <- dat[[1]]
  dat2 <- dat[[2]]

  xx <- seq(0, 1, length.out=6)
  ylim_alpha <- c(.45, 1.75)

  par(mfrow=c(2, 2), mar=rep(1, 4), oma=c(3, 3, 1, 1))

  plot(dat1$x, dat1$a1, type="l", ylim=ylim_alpha, las=1, xaxt="n")
  axis(1, labels=FALSE)
  abline(h=1.0, v=dat1$x1, lty=2, col="darkgrey")
  points(dat1$x1, 1.0, pch=19)
  add_black_bar(dat1$x, dat1$w1)
  label_panel(1)
  mtext(expression("Competition (" * alpha * ")"), 2, 1.6, outer=TRUE)
  mtext("Trait value", 1, 1.8, outer=TRUE)
#  mtext("Away from attractor", 3, 0.5, xpd=NA, cex=.8)

  plot(dat1$x, dat1$a2, type="l", ylim=ylim_alpha, xaxt="n", yaxt="n")
  axis(1, labels=FALSE)
  axis(2, labels=FALSE)
  abline(h=1.0, v=dat1$x2, lty=2, col="darkgrey")
  points(dat1$x2, 1.0, pch=19)
  label_panel(2)
 # mtext("At attractor", 3, 0.5, xpd=NA, cex=.8)
  mtext("Equal resources", 4, 0.5, xpd=NA, cex=.8)

  plot(dat2$x, dat2$a1, type="l", ylim=ylim_alpha, las=1)
  abline(h=1.0, v=dat2$x1, lty=2, col="darkgrey")
  points(dat2$x1, 1.0, pch=19)
  add_black_bar(dat2$x, dat2$w1)
  label_panel(3)

  plot(dat2$x, dat2$a2, type="l", ylim=ylim_alpha, yaxt="n")
  axis(2, labels=FALSE)
  abline(h=1.0, v=dat2$x2, lty=2, col="darkgrey")
  points(dat2$x2, 1.0, pch=19)
  label_panel(4)
  mtext("Unequal resources", 4, 0.5, xpd=NA, cex=.8)
}

fig_rstar_components <- function(i) {
  d <- dat_rstar()[[i]]
  plot_components(d$x, d$r, d$K, d$x1, d$x2, d$N1, d$N2,
                  d$w1, d$w2, d$a1, d$a2)
}

