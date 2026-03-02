
# integer   # only integer numbers
# numeric   # integer, whole number, negative number, fractional number
# logical   # TRUE or FALSE (capital letters)
# character # String (use single or double qoutes)
# complex   # Complex numbers 1+5i
# raw       # raw bytes

 # Numeric
3
class(3)

 # Integer  
class(3)
class(3L)
class(-3L) 

```{r}
here before adding L r did not show the desired result 
```

 # Character

class("saloni")

 # Logical

TRUE
FALSE
class(TRUE)
class(FALSE)
class(NA)

 # Complex

class(3i)

```{r}
showing arithemetic functions with vectors
```

 # Vectors

x <- c(1,2,3,4,5,6)
x

```{r}
creating vector
```

 # Addition

x+4

 # Subtraction

x-4

 # Multiplication

x*4

 # Division

x/4

 # Operations between vectors

y<- c(2,3,4,5,6,7)
x+y
```{r}
adding vectors
```

x-y
```{r}
subtracting vectors
```

x*y
```{r}
multiplying vectors
```

x/y
```{r}
dividing vectors 
```

 
 # subset x, choose what we keep
z<- x[c(2,3)]
z

 # subset x, choose what we drop
q<- x[c(-1,-2)]
q

 # matrix
number_matrix = matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), nrow=3, ncol=4)
```{r}
creating matrix
```

number_matrix
```{r}
printing matrix
```

number_matrix = matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), nrow=3, ncol=4, byrow=T)
```{r}
changing matrix to be by row
```

number_matrix
number_matrix(1)
number_matrix[1,2]
```{r}
here by simpling asking for value (1) showed error
```

number_matrix= rbind(number_matrix, c(13,14,15,16))
```{r}
adding a row to the matrix
```

number_matrix
number_matrix= cbind(number_matrix, c(17,18,19,20))
```{r}
adding a column to the matrix
```

number_matrix


 # Array

number_array= array(c(1:30), dim=c(2,3,5))
```{r}
creating an array
```

number_array
dim(number_array)
```{r}
dimming the array
```


 # Factors

music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))
```{r}
creating a factor
```

music_genre
levels(music_genre)
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"), levels = c("Classic", "Jazz", "Pop", "Rock", "Other"))
```{r}
adding levels to the factors
```

levels(music_genre)
length(music_genre)
```{r}
asking for the length of the factor
```


 # List

thislist <- list("apple", "banana", "cherry")
```{r}
creating list
```

thislist
thislist[1]
```{r}
asking for the first value of the list
```

thislist[1] <- "blackcurrant"
```{r}
changing the first value of the list
```

thislist
```{r}
printing the updated list
```

length(thislist)
```{r}
asking the lenght of the list
```


 # Data Frames

Data_Frame = data.frame (Training = c("Strength", "Stamina", "Other"), Pulse = c(100, 150, 120), Duration = c(60, 30, 45))
```{r}
creating data frame
```


Data_Frame
summary(Data_Frame)
```{r}
summarizing data frame
```

Data_Frame <- rbind(Data_Frame, c("Power", 110, 110))
```{r}
adding row to data frame
```

Data_Frame
Data_Frame[-c(1), -c(1)]
```{r}
removing column from the list
```

dim(Data_Frame)


