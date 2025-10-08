#Runnable examples of what base R can do ####
#Making background graphics for a presentation

squircle <- function(x,y) exp(-x^12-y^12)

isotherm <- function(f, rv=FALSE){
  x <- y <- seq(-1, 1, length.out=1000)
  z <- outer(x, y, f)
  s <- deparse1(substitute(f))
  op <- par(mar=rep(0,4))
  pal <- hcl.colors(10, palette="RdYlGn")
  if(rv) pal <- rev(pal)
  png(filename=paste0("iso_", s, ".png"), width=1600, height=900)
  par(op)
  contour(x, y, z, drawlabels=FALSE, col=pal, nlevels=10, lwd=2, axes=FALSE)
  dev.off()
}

isotherm(squircle, rv=TRUE)

#Four scatterplots showing deviation from the line y=x in one image

png(filename="quad_scatter.png", width=1000, height=1000)
op <- par(mfrow=c(2, 2))
quarter <- function(){
  plot(runif(100), runif(100), pch=4)
  abline(a=0, b=1, col="red")
  invisible()
}
replicate(4, quarter())
par(op)
dev.off()

#Drawing a projection of a cuboid

cuboid <- function(w, h, d){
  plot(x=NA, xlim=c(0,(w+d)*sqrt(3)/2), ylim=c(0,h+(w+d)/2), xlab=NA, ylab=NA, asp=1)
  polygon(x=c(0,w*sqrt(3)/2,w*sqrt(3)/2,0), 
          y=c(w/2,0,h,h+w/2), 
          col="red")
  polygon(x=c(0,w*sqrt(3)/2,(w+d)*sqrt(3)/2,d*sqrt(3)/2), 
          y=c(h+w/2,h,h+d/2,h+(w+d)/2), 
          col="blue")
  polygon(x=c(w*sqrt(3)/2,(w+d)*sqrt(3)/2,(w+d)*sqrt(3)/2,w*sqrt(3)/2), 
          y=c(0,d/2,h+d/2,h), 
          col="yellow")
}

png(filename="Cuboid-R.png", width=1000, height=1000)
cuboid(2,3,4)
dev.off()

#Using contour() to draw an implicitly defined curve

draw_superellipse <- function(a, b, n){
  superellipse <- function(x,y) abs(x/a)^n+abs(y/b)^n-1
  x <- y <- seq(from=-200, to=200, length.out=1000)
  z <- outer(x, y, superellipse)
  png(filename="Superellipse-R.png", width=1000, height=1000)
  contour(x, y, z, levels=0, drawlabels=FALSE)
  dev.off()
}

draw_superellipse(1, 1, 2/3)

#Using image() to generate a "plasma effect"

plasma <- function(x, y) sin(x/16)+sin(y/8)+sin((x+y)/16)+sin(sqrt(x^2+y^2)/8)
x <- y <- seq(-32*pi, 32*pi, length.out=1000)
bigmat <- outer(x, y, plasma)
png(filename="PlasmaEffect-R.png", width=1000, height=1000)
image(bigmat, col=hcl.colors(12, "Plasma"), xaxt="n", yaxt="n")
dev.off()