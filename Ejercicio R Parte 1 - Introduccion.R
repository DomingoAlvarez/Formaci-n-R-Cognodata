
#--------------------------------------#
########## Cargar los datos  ###########
#--------------------------------------#
data<-read.csv(file='C:/Users/alvarezp/Desktop/Intro R/20180508 R - Modelación/Rimac_fuga_pm_train.txt', sep = "\t", dec = ".")

# Limpiar NA's

data[is.na(data)]<-0

# Cambiar el nombre al target (o las columnas que queramos)

colnames(data)[which(names(data) == "TARGET")] <- "Target"

# Estadísticos principales

summary(data)


#--------------------------------------------------------------------------------------------#
########## Calcular la correlación entre las variables independientes y el target  ###########
#--------------------------------------------------------------------------------------------#
install.packages("Hmisc")
library(Hmisc)
cor <- rcorr(as.matrix(data), type="pearson")

#correlacion
matrix_cor <- data.frame(cor$r)

#p-valor de la correlación (por encima de un umbral no es significativo)
matrix_sig <- data.frame(cor$P)

#pintar correlacion
corrplot::corrplot(cor$r, method='circle', tl.cex = 0.7, #matriz de correlacion, método de ploteo y tamaño de fuente
                   type = 'lower', #nos quedamos con la diagonal inferior
                   p.mat = cor$P, sig.level = 0.01, #tachamos con una cruz los niveles de significancia > 0.01
                   addCoef.col = "black",number.cex=0.5,# añadimos valor del coeficiente y el tamaño
                   tl.col = "darkblue", tl.srt = 45) #color y orientación


target_vs_rest <- data.frame(t(matrix_cor[1,2:ncol(matrix_cor)]))
# Tomamos el valor absoluto para seleccionar aquellas 3 variables con mayor correlación, el signo no importa
target_vs_rest[2] <- abs(target_vs_rest$Target)
target_vs_rest[1] <- rownames(target_vs_rest)
colnames(target_vs_rest) <- c('variable', 'corr_target')
rownames(target_vs_rest) <- NULL
target_vs_rest <- target_vs_rest[order(target_vs_rest$corr_target, decreasing = TRUE),]

# Convertimos la variable target en factor y ordenamos los niveles
data$Target <- factor(data$Target, levels(factor(data$Target))[c(2,1)])


#---------------------------------------------------------------------------------------------------#
########## Dibujar un histograma con las 3 variables con mayor correlación target 0 vs 1  ###########
#---------------------------------------------------------------------------------------------------#

# Vector con el nombre con las 3 variables con mayor correlación
mayor_correlacion <- target_vs_rest$variable[1:3]

# Creamos una función con una paleta de colores continuos
rbPal <- colorRampPalette(c('blue', 'red', 'yellow'))

# Definimos el porcentaje de clientes fugados (sobre el conjunto total) para dibujar la línea en los gráficos
media_count_fuga <- (prop.table(table(data$Target)) * 100)[[1]]


# VARIABLE 1 

# Calculamos la tabla de frecuencias
tabla_doble_var1 <- table(data$Target, data[,mayor_correlacion[1]])

# Calculamos la tabla anterior en porcentajes
tabla_doble_var1_scale <- scale(tabla_doble_var1, FALSE, colSums(tabla_doble_var1)) * 100

# Definimos una variable con los colores a incluir en el histograma, donde a cada intervalo de valores
# (definimos 10 colores) se le asigna un color. La función cut es para crear los intervalos
color <- rbPal(10)[as.numeric(cut(tabla_doble_var1[1,],breaks = 10))]

# Creamos el histograma, la leyenda y la línea con el porcentaje total de clientes fugados
barplot(tabla_doble_var1_scale[1,], main = mayor_correlacion[1], col=color, ylab="Porcentaje de clientes fugados")
legend("topright",legend=unique(cut(tabla_doble_var1[1,],breaks = 10)),col=color, title="Núm. Clientes", pch=15)
abline(media_count_fuga, 0, col="red")


# VARIABLE 2: análogo al 1

# Calculamos la tabla de frecuencias
tabla_doble_var2 <- table(data$Target, data[,mayor_correlacion[2]])

# Calculamos la tabla anterior en porcentajes
tabla_doble_var2_scale <- scale(tabla_doble_var2, FALSE, colSums(tabla_doble_var2)) * 100

# Definimos una variable con los colores a incluir en el histograma, donde a cada intervalo de valores
# (definimos 10 colores) se le asigna un color. La función cut es para crear los intervalos
color <- rbPal(10)[as.numeric(cut(tabla_doble_var2[1,],breaks = 10))]

# Creamos el histograma, la leyenda y la línea con el porcentaje total de clientes fugados
barplot(tabla_doble_var2_scale[1,], main = mayor_correlacion[2], col=color, ylab="Porcentaje de clientes fugados")
legend("topright",legend=unique(cut(tabla_doble_var2[1,],breaks = 10)),col=color, title="Núm. Clientes", pch=15)
abline(media_count_fuga, 0, col="red")

# VARIABLE 3 

# Vamos a representar dos gráficos: uno para cuando la nomina sea 0 y otro para el resto. Ya que si observamos 
# los estadístico, al menos el 25% de los registros toman el valor 0:
summary(data[,mayor_correlacion[3]])


# nomina = 0 
nomina_0 <- subset(data, data[,mayor_correlacion[3]]==0)

# Calculamos la tabla de frecuencias
tabla_doble_var3 <- table(nomina_0$Target, nomina_0[,mayor_correlacion[3]])

# Calculamos la tabla anterior en porcentajes
tabla_doble_var3_scale <- scale(tabla_doble_var3, FALSE, colSums(tabla_doble_var3)) * 100

# Definimos una variable con los colores a incluir en el histograma, donde a cada intervalo de valores
# (definimos 10 colores) se le asigna un color. La función cut es para crear los intervalos
color <- rbPal(10)[as.numeric(cut(tabla_doble_var3[1,],breaks = 10))]

# Creamos el histograma, la leyenda y la línea con el porcentaje total de clientes fugados
barplot(tabla_doble_var3_scale[1,], main = mayor_correlacion[3], col=color, ylab="Porcentaje de clientes fugados")
legend("topright",legend=unique(cut(tabla_doble_var3[1,],breaks = 10)),col=color, title="Núm. Clientes", pch=15)
abline(media_count_fuga, 0, col="black")


# nomina != 0 
nomina_distinto_0 <- subset(data, data[,mayor_correlacion[3]]!=0)

# Como esta variable toma muchos valores distintos, vamos a crear intervalos a partir de los cuartiles
quartiles <- data.frame(quantile(nomina_distinto_0[,mayor_correlacion[3]]))
colnames(quartiles) <- "corte"
nomina_cat <- cut(nomina_distinto_0[,mayor_correlacion[3]], quartiles$corte)
nomina_distinto_0_cat <- cbind(nomina_distinto_0,nomina_cat)

# Calculamos la tabla de frecuencias
tabla_doble_var3 <- table(nomina_distinto_0_cat$Target, nomina_distinto_0_cat$nomina_cat)

# Calculamos la tabla anterior en porcentajes
tabla_doble_var3_scale <- scale(tabla_doble_var3, FALSE, colSums(tabla_doble_var3)) * 100

# Definimos una variable con los colores a incluir en el histograma, donde a cada intervalo de valores
# (definimos 10 colores) se le asigna un color. La función cut es para crear los intervalos
color <- rbPal(10)[data.frame(factor(tabla_doble_var3[1,]))[,1]]

# Creamos el histograma, la leyenda y la línea con el porcentaje total de clientes fugados
barplot(tabla_doble_var3_scale[1,], main = mayor_correlacion[3], col=color, ylab="Porcentaje de clientes fugados")
legend("topright",legend=tabla_doble_var3[1,],col=color, title="Núm. Clientes", pch=15)
abline(media_count_fuga, 0, col="red")


