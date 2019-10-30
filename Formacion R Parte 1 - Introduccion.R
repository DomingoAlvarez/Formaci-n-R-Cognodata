#----------------------------------------------#
############ Formacion R - Parte 1 #############
#----------------------------------------------#



#-----------------------------------------------------------------------#
########## Identificadores, palabras reservadas y comentarios ###########
#-----------------------------------------------------------------------#

# Esto es un comentario. Por ahora R no dispone de un carácter para comentar varias líneas (tipo /* de SQL)
#----------- Para crear una seccion: Terminar con 4 de estos caracteres (- = #) ####

if <- 1 #Palabra reservada.
a = 1; b <- 10; a+b; a-b #multiples operaciones en la misma linea con ;

var1 <- 'hola'
var2 = 12 * (2+1)
.var2 = var2 #forma de "esconder" una variable del workspace
ls() #ver variables en workspace
ls(all.names=TRUE) #ver todas variables en workspace


#-------------------------------------------------#
########## Tipos y estructuras de datos ###########
#-------------------------------------------------#
myLogical <- TRUE; class(myLogical)
myNumeric <- 7.3; class(myNumeric)
myInteger <- as.integer(37); class(myInteger)
myComplex <- 1 + 1i; class(myComplex)
myCharacter <- "Hola"; class(myCharacter)

#Vectores: Secuencia de elementos del mismo tipo
myVector <- c(2,4,6)
class(myVector)
length(myVector)
myVector[2]
myVector[1:2]

#Listas: Secuencia de elementos de cualquier tipo
myLists <- list(1,"23")
class(myLists)
length(myLists)
myLists[-1]

#Arrays: Secuencia rectangular (cada fila tiene la misma longitud, 
#al igual que cada columna y cualquier otra dimensión) de elementos del mismo tipo
myArray <- array( 1:24, dim = c(4, 3, 2), 
                  dimnames = list( 
                    c("dim1_1", "dim1_2", "dim1_3", "dim1_4"), 
                    c("dim2_1", "dim2_2", "dim2_3"), 
                    c("dim3_1", "dim3_2"))) 
myArray 
myArray[1,2,1] 
myArray[1:2,2,1] 
myArray[1,,] 

#Matrices: Caso particular de array en 2D
myMatrix <- matrix(c(11, 12, 13, 21, 22, 23), nrow=2, ncol=3, byrow = TRUE) 
myMatrix 
dim(myMatrix)
myMatrix[1, 1:2] 
myMatrix[, 2] 

#Factores: Variables categóricas
myFactor1 <- factor(c(1,3,7,9)) 
class(myFactor1) 
levels(myFactor1) 
nlevels(myFactor1)
myFactor2 <- factor(c("yes","no")) 
myFactor2 

#DataFrames: Es una lista de vectores de la misma longitud. Es el objeto usado para guardar tablas de SQL (tablón)
myDataFrames = data.frame( x = letters[1:10], y = rnorm(10), z = runif(10) > 0.5) 
myDataFrames 
myDataFrames$x #accede a una columna del dataframe
myDataFrames$x[1:4] 
myDataFrames$z[2] 

#Los dataframes por su propia estructura poseen funciones útiles para su tratamiento
head(myDataFrames); #primeras 6 filas
tail(myDataFrames); #últimas 6 filas
dim(myDataFrames); #dimension del dataframe
nrow(myDataFrames); #numero de filas
ncol(myDataFrames); #número de columnas
str(myDataFrames); #estructura del dataframe: Nombre columna, tipo dato y preview
names(myDataFrames); #nombres de las columnas
sapply(myDataFrames, class); #clase de cada columna
summary(myDataFrames); #estadísticos principales según tipo de columna

#Indexacion
#Al primer elemento de los arrays, vectores, matrices, listas y data frames se accede con el índice 1
myVector[1]
myLists[2]
myLists[[2]]
myMatrix[1,1]
myDataFrames[1]


#Se pueden seleccionar elementos seguidos utilizando a:b, donde a es el índice del primer elemento y b el índice del último elemento seleccionado 
myVector[1:2]
myMatrix[1:2,1]

#En las matrices y dataframes, si queremos seleccionar todos los elementos de una fila, el índice de la columna 
#lo dejaremos en blanco. Y, por el contrario, si queremos seleccionar todos los elementos de una columna, 
#el que dejaremos en blanco será el índice de la fila
myMatrix[2,]
myDataFrames[,2]

new <- data.frame(myDataFrames$x) #si queremos que devuelva un dataframe
myDataFrames$y
myDataFrames$z


#------------------------------#
########## Variables ###########
#------------------------------#

#R admite nombres de variables consistentes en letras, números, puntos y guión bajo.
#El nombre de la variable debe empezar con una letra o un punto no seguido de un número (en este caso la variable no se mostrará en el workspace)
#Para crear variables, podemos usar los comandos '=' o '<-': Asigna el valor a la variable
A = 1; b <- list(2,'3')

#La función class() muestra el tipo de dato de la variable
A = 1; class(A) 
b <- list(c(2,'3')); class(b) 

#Las variables se "reescriben" si se reasignan, y por tanto puede cambiar el tipo de dato
A = 1; class(A); 
A = TRUE; class(A) 
rm(A);

#Nota: Forma de generar números aleatorios
#distribución Uniforme
runif(1)
barplot(table(round(runif(100000), digits = 2)))

#distribución Normal
rnorm(1)
barplot(table(round(rnorm(100000), digits = 2)))

#----------------------------#
########## Strings ###########
#----------------------------#

#Los Strings se crean cuando se asocia a una variable un valor entre comillas (simples o dobles)
a <- (" writing any text between quotes ")

paste("a","b","c", sep = " _-_ ") #Concatena
format(23.123456789, digits = 4)
nchar("Count the number of characters") 

toupper("Count the number of characters") 
tolower("Count the number of characters") 

substring(" writing any text between quotes ",2, 8) 


#----------------------------#
########## Vectors ###########
#----------------------------#

#Los vectores son secuencias de elementos de un mismo tipo. Para ello se utiliza el comando c()
myVector <- c(2,4,6) 
class(myVector) 
length(myVector) 

#A los elementos de un vector se accede mediante indexación con [ ], empezando en la posición 1
#Si accedemos a un valor con índice negativo, selecciona todos los valores menos el indicado
myVector[2] 
myVector[1:2]
myVector[-3]

#TRUE, FALSE, 0, 1 también pueden ser usados para indexar. Si el índice es TRUE o 1, el elemento es seleccionado
test_gt_3 = myVector>3 
test_gt_3
myVector[test_gt_3] 

vector_01 = c(0,1,0) 
vector_01 
myVector[vector_01] 

myVector[c(2,2,2,2,2,2)] 




#--------------------------#
########## Lists ###########
#--------------------------#

#Las listas son secuencias de elementos de cualquier tipo: Números, strings, vectores, otras listas, matrices, objetos, etc
#Para ello se utiliza el comando list(). Se puede establecer un nombre para cada elemento de la lista
myLists <- list(1,"23")
class(myLists)
length(myLists)
myLists[-1]

# lista con un vector, una matriz y una lista
list_data <- list(c("Jan","Feb","Mar"), matrix(c(3,9,5,1,- 2,8), nrow=2), list("green",12.3))

# establecer nombres
names(list_data) <- c("1st Quarter", "A_Matrix", "A Inner list"); 
list_data

# indexación (puede hacerse por nombre con el comando $)
list_data$A_Matrix

str(list_data[1]) #extrae una sublista
str(list_data[[1]]) #extrae el componente de una lista



#-----------------------------#
########## Matrices ###########
#-----------------------------#

#Las matrices son arrays bidimensionales rectangulares. Contienen elementos del mismo tipo
#Se crean con el comando matrix() con la sintaxis. matrix(data, nrow, ncol, byrow, dimnames)
myMatrix <- matrix(c(11, 12, 13, 21, 22, 23),nrow=2, ncol=3, byrow = TRUE) 
myMatrix 

dim(myMatrix) 
myMatrix[1:2, 2] 
myMatrix[, 2]

rownames = c("row1", "row2", "row3", "row4") 
colnames = c("col1", "col2", "col3") 
P <- matrix(c(3:14), nrow=4, byrow=TRUE, dimnames=list(rownames, colnames)) 

P
P[4,2]
P[3,]


#---------------------------#
########## Arrays ###########
#---------------------------#

#Sirven para almacenar datos del mismo tipo en estructuras de más de 2 dimensiones
vector1 <- c(5,9,3) 
vector2 <- c(10,11,12,13,14,15) 
column.names <- c("COL1","COL2","COL3") 
row.names <- c("ROW1","ROW2","ROW3") 
matrix.names <- c("Matrix1","Matrix2")

#Creamos Array
new.array <- array(c(vector1,vector2),dim=c(3,3,2),dimnames = list(column.names,row.names,matrix.names)) 
new.array 

#Suma de todas las filas a través de todas las matrices 
result <- apply(new.array, c(1), sum) 
result

#Suma de columnas 
result <- apply(new.array, c(2), sum) 
result


#----------------------------#
########## Factors ###########
#----------------------------#

#Los factores son estructuras de datos que son usadas para categorizar los datos y guardarlo como niveles (pueden ser tanto strings como enteros)
#Se utilizan sobre todo si se quiere hacer análisis de datos o modelación estadística
#Para crearlos se utiliza la función factor() que toma un vector como entrada
input <- c("East", "West","East","North", "North","East","West", "West","West","East","North")
input
is.factor(input)

#Convertimos a factor
factor_data <- factor(input)
factor_data
is.factor(factor_data)

levels(factor_data)
nlevels(factor_data)

#Cambiar los factores
levels(factor_data) <- list(A="East", B="West", C="North")
factor_data


#-------------------------------#
########## DataFrames ###########
#-------------------------------#

#Son tablas o arrays bidimensionales en el que cada columna contiene valores de una variable
#y cada fila contiene un conjunto de valores para cada columna (tablón)

#Posee unas características especiales
  #Los nombres de columnas no pueden estar vacíos
  #Los nombres de fila deben ser únicos
  #Puede almacenar cualquier tipo de dato, pero cada columna solo puede almacenar un tipo de dato

myDataFrames <- data.frame( x = letters[1:10], y = rnorm(10), z = runif(10) > 0.5) 
myDataFrames
myDataFrames$x #accede a una columna del dataframe
myDataFrames$x[1:2] 
myDataFrames$z[2] 

#acceder a todas las columnas menos a las especificadas
myDataFrames[ ,!(names(myDataFrames) %in% "x")]


#A un data frame podemos añadirle filas o columnas con las funciones rbind y cbind, respectivamente
u <- list('a', 1, TRUE)
rbind(myDataFrames, u)
# R no respeta el tipo de dato!
u <- list('a', 1,'a')
aux_myDataFrames <- rbind(myDataFrames, u)

#Añadir columna
w <- seq(from=1, to=10, length.out=10)
cbind(myDataFrames,w)

#Con vectores
v1 <- c(1,2,3)
v2 <- c(4,5,6)
cbind(v1,v2)
rbind(v1,v2)

#Forma de seleccionar registros que cumplan una propiedad --> which
myDataFrames[which(myDataFrames$z==1),]

#------------------------------#
########## Operators ###########
#------------------------------#

#aritmeticos
x=10; y=23 
x + y 	  # suma 
x - y 	  # resta
x*y 		  # multiplicación 
x/y 		  # división 
x^y 		  # exponencial 
x**y 	    # exponencial
x %% y  	# módulo (x mod y)
x %/% y 	# división entera

#logicos y relacionales
x<y		# menor que
x<=y 		# menor o igual que
x>y 		# mayor que
x>=y 		# mayor o igual que
x==y 		# igual
x!=y 		# distinto

x=TRUE; y=FALSE
!x 		  # NOT
x | y 	# OR
x & y 	# AND
isTRUE(x)	# comprueba si X es TRUE

#asignacion
v1 <- c(3,1,TRUE,"word")
v2 <<- c(3,1,TRUE,"word")
v3 = c(3,1,TRUE,"word")
(v1 == v2) & (v2 == v3)

#Como convenio, para asignar valores a variables es preferible '<-' 
#ya que el '=' se suele utilizar para dar valores a los parámetros de las funciones
mean (x = 1:10) #no guarda x en el workspace
mean (x <-1:10) #guarda x en el workspace

#La asignación '<<-' se utiliza dentro de funciones, para modificar valores de variables ya existentes en entornos fuera de la función.
#Si la variable ya existe: Cambia su valor
#Si la variable no existe: Crea una variable global con el valor
a <- 1;
f <- function(){a <- 2}
f();a; #a=1

a <- 1;
f <- function(){a <<- 2}
f();a; #a=2


#--------------------------------------#
########## if, else if, else ###########
#--------------------------------------#
x <- as.integer(3)
if(is.integer(x)){
  print("Integer")
}

x <- 3.14
if(is.integer(x)){ 
  print("Integer") 
} else{ print("not Integer")
} 


x <- c("this", "is", "a", "car")
if("car" %in% x){ 
  print("car is found the first time") 
} else if ("car" %in% x) { 
  print("car is found the second time") 
} else { 
  print("No car found") 
} 



#---------------------------#
########## Switch ###########
#---------------------------#

#Sirve para evaluar una variable en una lista de valores (cada valor es un caso) 
switch(3, "first", "2nd", "third", "fourth" ); 

switch( "gamma", alpha = 1, beta = sqrt(4), gamma = 25);

x <- "gamma"
switch( x,
    "alpha" ={print('primer')},
    "beta"  ={print('segundo')},
    "gamma" ={print('tercer')}
)
    

#--------------------------#
########## Loops ###########
#--------------------------#

#Repeat
v <- c("Hello","you")
cnt <- 2

repeat{
  print(v)
  cnt <- cnt+1
  if(cnt > 5){
    break
  }
}


#While
v <- c("Hello","while loop")
cnt <- 2

while (cnt < 7){
  print(v)
  cnt = cnt + 1
}


#For
v <- LETTERS[1:4]

for ( i in v) {
  print(i)
}

for(i in 1:5){ 
  j <- i ^ 2
  print(j)
}


#------------------------------#
########## Funciones ###########
#------------------------------#

#Grupo de sentencias que se ejecutan según unos argumentos. Palabra clave function()
print_cubes <- function(arg_in) { 
  for(i in 1:arg_in) { 
    b <- i^3  #probar con <<-
    print(b) 
  } 
} 
print_cubes(10);

b <- 0
print_cubes(10);
b


#-----------------------------#
########## Packages ###########
#-----------------------------#

#Ver PPT
install.packages(paquete);	#instala el paquete
library(paquete);			#carga el paquete
library();				#lista los paquetes instalados
installed.packages()[,"Package"] #otra forma de ver los paquetes instalados


#Forma eficiente de instalar muchos paquetes, y obviar los instalados
list.of.packages <- c('neuralnet','rpart')

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

if(length(new.packages)) {  
	install.packages(new.packages)
}



#-------------------------------#
########## Utilidades ###########
#-------------------------------#

#Directorio de trabajo
print(getwd())
setwd("C:/") #el slash es al revés que en Windows!

#importar csv o txt
#Para csv o txt tenemos read.csv o read.delim. Son las mismas funciones, simplemente varían 
#en los parámetros por defecto, que podemos alterar a nuestra necesidad
data <- read.delim(file='Z:/Temporal/Programas/BBDD pruebas/Kaggle/GiveMeSomeCredit/cs-training.csv', header=TRUE, sep = ',' , dec = '.')

#importar Excel (no recomendado)
install.packages('xlsx')
library(xlsx)
data <- read.xlsx('Z:/Temporal/Programas/BBDD pruebas/Kaggle/GiveMeSomeCredit/cs-training.xlsx', sheetIndex = 1)

#Ejemplo SQL Server (en general puede conectarse a cualquiera)
library(RODBC)
con <- odbcDriverConnect( connection="Driver={SQL Server Native Client 11.0};server=srvsql;database=RIMAC;trusted_connection=yes;");
tablas <- sqlTables(con); #ver las tablas de la BBDD
tablas
data <- sqlQuery(con, "select top 10000 * from Fuga_PM_train"); 	#Ejecución Query
head(data)
str(data)

#Exportar
write.table(data, "c:/data.txt", sep="\t",row.names = F) #ruta absoluta
write.table(data, "data.txt", sep="\t",row.names = F) #ruta relativa al wd
write.xlsx(data, "c:/data.xlsx",row.names = F, sheetName = 'Nuevo')

#crea una variable que indique si el cliente tiene más de 40 años
#forma ineficiente
contador = nrow(data)

for (i in 1:contador) {
  if(data$EDAD[i]>40){ 
    data$edad_cat[i]=TRUE
  } else{ data$edad_cat[i]=FALSE
  } 
  print(i)
  #i = i+1 #No hace falta actualizar el contador
}
#Forma óptima
data$edad_cat2 = data$EDAD>40

#frecuencia de una variable
table(data$age)

#Frecuencia de 2 variables
table(data$age, data$SeriousDlqin2yrs)


#Contar clientes con la edad a nulo según el target
table(data$SeriousDlqin2yrs,is.na(data$age))

#Contar clientes con ingresos a nulo según target
table(data$SeriousDlqin2yrs,is.na(data$MonthlyIncome))

#diferencias al tratar la función table
data_df <- data.frame(table(data$SeriousDlqin2yrs,is.na(data$MonthlyIncome)))
data_mt <- as.data.frame.matrix(table(data$SeriousDlqin2yrs,is.na(data$MonthlyIncome)))

#--------------------------#
########## Plots ###########
#--------------------------#

#datos
peso <- c(80,60,48,55,105,78,90,61,89,65)
altura <- c(175,150,160,170,187,160,181,172,168,161)
colesterol <- c("si","no","si","si","si","si","no","no","si","no")
pais <- c('Espania','Francia','Francia','Reino Unido','Espania','Espania','Espania','Reino Unido', 'Espania','Espania')
datos <- data.frame(peso, altura, colesterol,pais)


#Lineas: plot con type='l' (help plot para ver todas las opciones)
datos <- datos[order(altura),] 
plot(datos$altura, datos$peso, type='l', main='Altura vs Peso', xlab='Altura (cm)', ylab='Peso (kg)', col="red", lwd=5)

#sector
tabla_paises <- table(datos$pais)
freq_paises <- data.frame(tabla_paises)
names(freq_paises) <- c("pais", "freq")
pie(freq_paises$freq, labels=freq_paises$pais, main = "Núm. Individuos por País", col=rainbow(length(freq_paises$pais)))

#barras
barplot(tabla_paises, main = "Núm. Individuos por País", col=rainbow(length(freq_paises$pais)), width=c(0.2, 0.5, 0.7), 
        xlab="País")

#barras apilado
tabla_doble_paises <- table(datos$colesterol,datos$pais )
barplot(tabla_doble_paises, main = "Núm. Individuos que tienen colesterol por País", col=c("darkblue","cyan"),
        legend = rownames(tabla_doble_paises))

#barras agrupado
barplot(tabla_doble_paises, main = "Núm. Individuos que tienen colesterol por País", col=c("darkblue","red"),
        legend = rownames(tabla_doble_paises), beside=TRUE)


#barras agrupado si tuvieramos un dataframe
tabla_doble_paises <- as.data.frame.matrix(table(datos$colesterol,datos$pais ))
barplot(tabla_doble_paises) #da error ya que se espera una matriz, no un dataframe

a<-as.matrix(rbind(tabla_doble_paises[1,],tabla_doble_paises[2,]))
barplot(a, main = "Núm. Individuos que tienen colesterol por País", col=c("darkblue","red"),
        legend = rownames(a),beside=TRUE)



#------------------------------#
########## Auditoria ###########
#------------------------------#

#estadísticos de todas las variables en función de una condicion
summary(data[which(data$SeriousDlqin2yrs==1),2:ncol(data)])

# histogramas
par(mfrow = c(4,3), mar=c(2,2,2,2)) #establecemos una malla de 4x3 para plotear, y los margenes de los plots
for (i in 2:ncol(data)) 
  hist(data[,i], col = 'darkblue', main = colnames(data)[i], cex.main = 1)

# diagramas de caja
par(mfrow = c(4,3), mar=c(2,2,2,2)) #establecemos una malla de 4x6 para plotear, y los margenes de los plots
for (i in 2:ncol(data)) 
  boxplot(data[,i], col = 'greenyellow', main = colnames(data)[i], cex.main = 1)


#### Dataframe para el Ejercicio ####
data<-read.csv(file='C:/Users/alvarezp/Desktop/Intro R/20180508 R - Modelación/Rimac_fuga_pm_train.txt', sep = "\t", dec = ".")


