statsr
```{r}
adding file to r
```
mean(statsr,Inflation)
```{r}
code did not work
```

mean(statsr$Inflation)
```{r}
after replacing ',' with '$' code worked
```

median(statsr$Inflation)
```{r}
code for median
```

mode<- names(sort(-table(statsr$Inflation)))[1]
```{r}
code for finding mode
```

mode
```{r}
command to show mode
```

sd(statsr$Inflation)
```{r}
command to find standard deviation
```

hist(statsr$Inflation)
```{r}
command to make a histogram
```

barplot(statsr$Inflation)
```{r}
command to make a bar plot
```

plot(Time,Inflation)
```{r}
command to make a scatter plot
```

pie(Inflation)
```{r}
command to make a pie chart
```

regression <- lm(Inflation ~ Time, data=statsr)
```{r}
command for regression analysis
```

summary(regression)
```{r}
interpreting regression analysis output, including coefficients, R-squared value, and p-values.
```

abline(regression, col="blue")
```{r}
adding regression line to the plot 
```

