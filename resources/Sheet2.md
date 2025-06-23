Sheet 2: Statistical tests, models, and charts in R
================
José Boue
2025-06-23

- [2.1: Tests](#21-tests)
  - [2.1.1: *z*-test](#211-z-test)
  - [2.1.2: *t*-test](#212-t-test)
  - [2.1.3: Chi-squared test](#213-chi-squared-test)
  - [2.1.4: *F*-test](#214-f-test)
  - [2.1.5: Fisher’s exact test](#215-fishers-exact-test)
  - [2.1.6: Kruskal-Wallis test](#216-kruskal-wallis-test)
  - [2.1.7: Pearson correlation](#217-pearson-correlation)
  - [2.1.8: Spearman’s rank
    correlation](#218-spearmans-rank-correlation)
  - [2.1.9: Wilcoxon signed-rank test](#219-wilcoxon-signed-rank-test)
  - [2.1.10: Kolmogorov-Smirnov test](#2110-kolmogorov-smirnov-test)
- [2.2: Models](#22-models)
  - [2.2.1: Linear regression](#221-linear-regression)
  - [2.2.2: Poisson regression](#222-poisson-regression)
    - [2.2.2a: Conditional Poisson regression
      (untested)](#222a-conditional-poisson-regression-untested)
  - [2.2.3: Logistic regression](#223-logistic-regression)
    - [2.2.3a: Conditional logistic
      regression](#223a-conditional-logistic-regression)
  - [2.2.4: Cox regression](#224-cox-regression)
  - [2.2.5: Self-controlled case
    series](#225-self-controlled-case-series)
  - [2.2.6: Accelerated failure time](#226-accelerated-failure-time)
  - [2.2.7: LOESS regression](#227-loess-regression)
- [2.3: Charts](#23-charts)
  - [2.3.1: Scatterplot](#231-scatterplot)
  - [2.3.2: Bar plot](#232-bar-plot)
  - [2.3.3: Box plot](#233-box-plot)
  - [2.3.4: Histogram](#234-histogram)
  - [2.3.5: Pie chart](#235-pie-chart)
  - [2.3.6: Radar chart](#236-radar-chart)
  - [2.3.7: Q-Q plot](#237-q-q-plot)
  - [2.3.8: Forest plot](#238-forest-plot)
  - [2.3.9: Kaplan-Meier plot](#239-kaplan-meier-plot)
  - [2.3.10: Choropleth map](#2310-choropleth-map)
  - [2.3.11: Cartogram](#2311-cartogram)

All functions in this document are assumed to require the `stats`
package, which is built-in to current versions of R and doesn’t need to
be manually installed.

# 2.1: Tests

If a function has an argument `alternative`, this can be `two.sided`,
`less`, or `greater`.

## 2.1.1: *z*-test

``` r
pnorm(mu, mean=mu_0, sd=s) #one-sided
```

## 2.1.2: *t*-test

``` r
t.test(x, alternative, mu) #one-sample
t.test(x, y, alternative, mu_diff) #two-sample
t.test(x, y, alternative, mu_diff, paired=TRUE) #two-sample, paired
```

## 2.1.3: Chi-squared test

``` r
chisq.test(x, p) #one-way table with probabilities
chisq.test(x, y) #two-way table as two vectors
chisq.test(M) #two-way table as a matrix
```

## 2.1.4: *F*-test

``` r
pf(v, df1, df2) #one-sided
```

## 2.1.5: Fisher’s exact test

``` r
fisher.test(x, y, alternative) #inputs are two vectors
fisher.test(M, alternative) #input is a matrix
```

## 2.1.6: Kruskal-Wallis test

``` r
kruskal.test(x, g) #vector with groupings
kruskal.test(L) #list of vectors
```

## 2.1.7: Pearson correlation

``` r
cor.test(x, y, alternative, method="pearson")
```

## 2.1.8: Spearman’s rank correlation

``` r
cor.test(x, y, alternative, method="spearman")
```

## 2.1.9: Wilcoxon signed-rank test

``` r
wilcox.test(x, mu, alternative) #one-sample test
wilcox.test(x, y, mu, alternative) #two-sample test
wilcox.test(x, y, mu, alternative, paired=TRUE) #two-sample paired test
```

## 2.1.10: Kolmogorov-Smirnov test

``` r
ks.test(x, y, alternative) #two-sample test
ks.test(x, cdf, alternative) #one-sample test
```

# 2.2: Models

## 2.2.1: Linear regression

``` r
lm(y ~ ..., data)
```

## 2.2.2: Poisson regression

``` r
glm(y ~ ..., family="poisson", data)
```

### 2.2.2a: Conditional Poisson regression (untested)

Requires `acp` package.

``` r
acp(y ~ ..., data, p, q, family="poisson")
```

## 2.2.3: Logistic regression

``` r
glm(y ~ ..., family="binomial", data)
```

### 2.2.3a: Conditional logistic regression

Requires `survival` package.

``` r
clogit(y ~ ..., data)
```

## 2.2.4: Cox regression

Requires `survival` package.

``` r
coxph(Surv(t,y) ~ ..., data)
```

## 2.2.5: Self-controlled case series

Requires `SCCS` package.

``` r
#Basic model, dose-independent exposure
standardsccs(event ~ adrug[,1], indiv, astart, aend, aevent, adrug, aedrug, data)
#Dose-dependent exposure
standardsccs(event ~ adrug_i, indiv, start, aend, aevent, adrug, aedrug, data)
#Age effect
standardsccs(event ~ adrug[,1] + age, indiv, astart, aend, adrug, aedrug, agegrp, dob, data)
#Seasonal effect
standardsccs(event ~ adrug[,1] + season, indiv, astart, aend, adrug, aedrug, seasongrp, dob, data)
#With washouts and/or pre-exposures
standardsccs(event ~ adrug[,1], indiv, astart, aend, aevent, adrug, aedrug, expogrp, washout, data)
```

## 2.2.6: Accelerated failure time

Requires `survival` or `eha` package.

``` r
survreg(Surv(t,y) ~ ..., data, id, dist) #survival package version
aftreg(Surv(t,y) ~ ..., data, id, dist) #eha package version
```

## 2.2.7: LOESS regression

``` r
loess(y ~ ..., data)
```

# 2.3: Charts

No purely cosmetic arguments are included here, only ones that affect
how the data is interpreted.

## 2.3.1: Scatterplot

``` r
plot(x, y, type)
```

## 2.3.2: Bar plot

``` r
barplot(height=v, width) #simple bar plot, v is a vector
barplot(height=M, width) #juxtaposed bar plot, M is a matrix
barplot(height=M, width, beside=FALSE) #stacked bar plot
```

## 2.3.3: Box plot

``` r
boxplot(y ~ ..., data)
```

## 2.3.4: Histogram

``` r
hist(x, breaks, right)
```

## 2.3.5: Pie chart

``` r
pie(x)
```

## 2.3.6: Radar chart

``` r
stars(x, full, locations)
```

## 2.3.7: Q-Q plot

``` r
qqnorm(y) #Normal distribution Q-Q plot
qqplot(x, y) #Generic Q-Q plot
```

## 2.3.8: Forest plot

Requires `forestploter` package.

``` r
plot(forest(data, est, lower, upper, sizes, ci_column, ref_line))
```

## 2.3.9: Kaplan-Meier plot

Requires `survival` package.

``` r
plot(survfit(y ~ x, data))
```

## 2.3.10: Choropleth map

Requires `sf` package. Other packages optional.

``` r
plot(shapefile[,"var_name"])
```

## 2.3.11: Cartogram

Requires `cartogram` package. Other packages optional.

``` r
plot(cartogram_cont(shapefile, weight)) #contiguous cartogram (shape-distorting)
plot(cartogram_ncont(shapefile, weight)) #non-contiguous cartogram (shape-preserving, but leaves gaps)
plot(cartogram_dorling(shapefile, weight)) #Dorling cartogram (represents regions as circles)
```
