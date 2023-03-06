# Modelo de series de tiempo

## 6.  DIAGNÓSTICO DE LOS MODELOS
---------------------------------

### 6.1 ESTACIONARIEDAD

Para poder hacer un análisis a partir de los modelos que hemos revisado necesitamos que la serie en cuestión sea estacionaria. Esta propiedad puede ser definida como estacionariedad fuerte o como estacionariedad débil. Para términos del análisis usaremos el concepto de estacionariedad débil. Este asume que:

Para un proceso {Yt:t=1,2, …} con argumento segundo finito ![]() es débilmente estacionario si:

(I)  ![]() es constante
(II) ![]() es constante
(III) para cualquier t, h > 1, Cov[yt; yt+h] depende solo de h pero no de t. 

Esta propiedad se puede evaluar matemáticamente en distintos procesos que consideremos. De nuevo, si están interesados en el tema, deben revisar a profundidad la parte teórica de este desarrollo.

¿Cómo podemos verificar si nuestras series son estacionarias? Hay varioas consideraciones que se pueden hacer:

- Ver gráficos de funciones de autocorrelaciones y autocorrelaciones parciales, usaremos este procedimiento en la sección de selección de rezagos.
- Usar tests formales que permitan evaluar la presencia de raíz unitaria. En slides posteriores veremos los paseos aleatorios y la presencia de raíces unitarias.
- Ver si existen tendencias en los gráficos. Si una serie presenta una tendencia, entonces el promedio de esta no será constante sino que cambiará de acuerdo al cambio de los valores de la serie.
- Verificar en los datos o fuera de los datos si hay alguna presencia de cambio estructural. Un cambio estructural hace referencia a la presencia de cambios en los procesos generadores de datos subyacentes. Pensemos en situaciones inesperadas como una reforma que cambian la dinámica total de la serie.

Consideremos un proceso como el siguiente:

![]()

A este tipo de procesos se les llama paseos aleatorios. Si lo comparamos con un proceso AR(1) tendríamos un Φ1 = 1 lo que indicaría presencia de raíz unitaria. Bajo esta condición no se cumplen con los supuestos de estacionariedad débil, el promedio no es constante y la varianza tiende a infinito. 
Simulemos un modelo AR(1) con raíz unitaria.
Creamos cinco series j = 1(1)5 a partir de los ruidos blancos. Como vemos el valor de rho va a definir si la serie tiene o no raíz unitaria.

```
```

Veamos las series que obtenemos.

![]()

Comparemos un AR(1) bajo distintos valores de coeficiente.

![]()

Para implementarlo hemos seguido la misma lógica previa, pero considerando un mismo vector de valores de perturbaciones y solo cambios.

#### 6.1.1 Tests de raíz unitaria

En los datos que observamos en la realidad no es posible saber el valor de  de antemano. Por lo que podemos acercarnos a rechazar o no rechazar estadísticamente el valor a través de test. Estos test se llaman Tests de raíz unitaria. En este caso revisaremos algunos test básicos que se aplican, usualmente, a una cantidad amplia de casos. Cada test regresiona los datos de acuerdo a cierta manera y sobre esa regresión plantea una hipótesis nula.

- Test Augmented Dickey-Fuller (ADF): Considera el siguiente modelo:

![]()

Y se considera H0: Θ = 0 y H1: Θ > 0
- Test GLS - Augmented Dickey-Fuller (ADF-GLS): Sigue la misma formulación previa pero se detrend bajo GLS (esto significa que se retira un componente tendencial de los datos estimado por mínimos cuadrados generalizados o GLS en inglés).
- Test Phillips-Perron (PP): Estima un modelo AR simple y luego se estiman dos estadísticos Z y Z que se comparan con una distribución propia de los autores. 

Tomemos la serie mensual de los términos de intercambio para Perú desde la página del BCRP.
Podemos comenzar a analizar la serie mirándola en un gráfico. 

![]()

A primera observación podemos encontrar que hay presencia de una tendencia. Los datos siguen un patrón de subida hasta la crisis del 2008, luego rebotan a un punto más alto para posteriormente empezar a disminuir. Usemos los test sobre esta serie:
Algunos test permiten dos tipos de opciones importantes: trend y/o drift. El primero hace referencia a que se asume una tendencia determinística (esto significa que nosotros sabemos de antemano cómo aumenta esta tendencia) mientras que drift hace referencia a que la serie tiene un intercepto.
¿Cómo decidimos incluir algunas de estas opciones? Para ello vemos la serie en el gráfico. En este caso parece haber una tendencia determinística por lo que indicamos la opción trend. O Veamos los resultados de usar los tres test sobre la serie mensual de términos de intercambio:

#### 6.1.1.1 Augmented Dickey – Fuller

Para hacer un test ADF usamos el comando dfuller seguido por la variable a ser analizada.

![]()

La hipótesis nula de este test considera que la serie tiene raíz unitaria mientras que la alternativa asume que proviene de un proceso estacionario. En este caso encontramos que el estadísticos estimado es -1.474 mientras que los puntos críticos son más negativos que este. Por lo que podemos concluir que no podemos rechazar la hipótesis nula de raíz unitaria en la serie.

#### 6.1.1.1 Phillip Perron

Para implementar el test Phillips Perron usamos el comando pperron. La hipótesis asume también que el proceso de los datos no es estacionario mientras que la alternativa considera que si es estacionaria.

![]()

Una diferencia entre este test y el test estándar ADF es que el test PP es robusto ante presencia de heterocedasticidad en los datos. Adicionalmente obtenemos dos estadísticos, Zp y Zt . De estos, podemos enfocarnos en Zt. Al igual que en el resto de los test no es posible rechazar la presencia de raíz unitaria en la serie.

#### 6.1.1.3 DF-GLS

Este test también es presentado por Elliot-Rothenberg-Stock(1996). Es una modificación al test ADF pero se incluye un detrending de los datos mediante una estimación GLS. La hipótesis nula en este caso indica la presencia de de raíz unitaria con un posible drift mientras que la alternativa considere una serie estacionaria con o sin tendencia.

![]()

Para implementar el test usamos el comando dfgls. La serie, por default, considera la presencia de una tendencia. Si no queremos considerar esto usamos la opción notrend. Adicionalmente, debemos seleccionar un número de rezagos máximos a considerar. En este caso, no es posible rechazar la hipótesis nula en ningún caso.
Luego de verificar que hay cierta evidencia a favor de que la serie tiene raíz unitaria podemos tomar una estrategia simple para transformar nuestra serie en estacionaria, tomar la primera diferencia o la tasa de crecimiento. En este caso, vamos a crear una variable nueva igual a la tasa de crecimiento mes a mes.

![]()

A primera vista, la serie parece no tener tendencia. Tomemos los test sobre esta serie.
En este caso ya no consideramos la opción trend

![]()

Ambos test concluyen en los mismo, la serie de la tasa de crecimiento de los términos de intercambio no presenta raíz unitaria. Ahora que ya sabemos identificar a una serie estacionaria vamos a ver como seleccionar el número de rezagos a usar al momento de modelar los datos.

### 6.2 SELECCIÓN DE REZAGOS

Luego de confirmar la estacionariedad vamos a seguir con la metodología de Box Jenkins para seleccionar el modelo. Para ello podemos seguir el siguiente orden:

- Identificar los posibles rezagos. Para ello usamos las funciones de autocorrelación y autocorrelación parcial.
- Estimar los modelos
- Seleccionar el rezago con menor valor de criterio de información 
- Verificar que los residuos estimados tengan una distirbución i.i.d.

Para analizar la autocorrelación y autocorrelación parcial (AC y PAC, en inglés) usamos los comandos ac y pac, los cuales generan un gráfico de los estadísticos. También podemos usar el comando corrgram para tener un resultado no gráfico. En esta etapa se buscan ciertos comportamientos. Veamos un cuadro resumen:

![]()

De esta manera tenemos cierta idea de cómo seleccionar el número de rezagos p para la parte autorregresiva y q para la parte de media móvil. Veamos un ejemplo aplicando los comandos y esta primera parte de la metodología para los datos de términos de intercambio.
De estos gráficos encontramos que hay una caída consecutiva en la función de autocorrelación, signo ser una función AR. A partir de la autocorrelación parcial tenemos una serie de picos que nos indicarían los rezagos a usar.

![]()

![]()

Para interpretar los picos en la PAC debemos ver qué picos están por encima de la zona sombreada. Esto significa que son significativos. Para ver las posiciones exactas así como otro conjunto de información podemos usar el comando corrgram. Veamos:
Este comando nos permite ampliar los resultados del gráfico. Las primeras columnas hacen referencia a los valores de AC y PAC mientras que las últimas columnas presenta una forma resumida de los gráficos previos.

![]()

Entonces, tendríamos un proceso AR con posibles rezagos en 1, 3, 6, 7,12, 13 y 25 (el resto de rezagos se muestra en el resultado completo de Stata). Ahora pasemos a estimar los modelos.
Para estimar los modelos usaremos el comando arima. Este comando nos permite seleccionar el número de rezagos que usaremos tanto para la parte AR como para la parte MA. Cómo veran se usa ARIMA en vez de ARMA, esto debido a que se deja la posibilidad de definir un parámetro adicional para los procesos autorregresivos integrados de medias móviles. Este elemento intermedio, I, será dejado de lado ya que es parte de temas más avanzados en series de tiempo. 

![]()

Luego de estimar los modelos, necesitamos recuperar los criterios de información con el comando estat ic en la línea posterior a la estimación.
En esta parte tenemos que repetir los códigos para distintas combinaciones de rezagos. Para almacenar los criterios de información de manera adecuada podemos crear una matriz previamente. En este caso almacenaremos los resultados de siete modelos. Comenzando con el modelo más simple de solo 1 rezago, aumentando de una a uno hasta tener los rezagos 1, 3, 6, 7, 12, 13 y 25.

```
```

Para crear una matriz tenemos que usar el comando matrix seguido por el nombre que queremos usar, por ejemplo, CritInfor. Para definir que sea una matriz vacía usamos J(2,7,.). El primer valor define el número de filas mientras que el segundo, el número de columnas. Por último, se define que se componga de missing values, ..
Adicionalmente podemos editar el nombre de las filas y columnas con matrix colnames y matrix rownames. Podemos ver la matriz usando matrix list CritInfor:

![]()

Estimemos el primero modelo, AR(1), usando el comando arima seguido por la(s) variables(s) a usar. En este caso, definimos ar(1) para seleccionar solo el rezago 1. Veamos el resultado.

![]()

Este resultado se parece a los que ya hemos visto previamente. Se presentan los resultados de la log verosimilitud estimada para cada iteración. Luego, algunos datos adicionales relacionados con el número de observaciones, las fechas y el contraste conjunto del modelo.
En la siguiente parte encontramos los estimadores de la constante y del rezago, _cons y L1.ar, respectivamente. Luego de estimar el modelo generamos los criterios de información ACI y BIC con el comando estat ic:

![]()

Si revisamos las opciones de post-estimation de este comando encontraremos que podemos recuperar los resultados para AIC y BIC en la matriz r(S). Veamos cómo manejamos estos datos.
Luego de correr el AR(1) y generar los criterios de información recuperamos la matriz r(s) creando una nueva matriz.

```
```

A partir de la nueva matrix ic creamos dos valores escalares para el AIC y BIC. Para ello, indicamos la posición de cada valor. El AIC se encuentra en la posición 1×5 de la matriz mientras que el BIC se encuentra en la siguiente posición 1×6. Luego reemplazamos los espacios 1×1 y 1×2 de la matriz de criterios de información con los dos nuevos valores.
Debemos de repetir este procedimiento para todos los modelos que consideremos.
Repetimos el bloque de códigos pero cambiando la ubicación en donde vamos a guardar los datos de la matriz. Por ejemplo, para el caso AR(1 3) guardamos en la ubicación 1 × 2 y 2 × 1. En este caso, solo estamos usando el proceso AR pero también podemos comparar un modelo ARMA(1,1) a modo de benchmark para el resto de modelos.
Luego de correr todos los bloques de códigos, visualizamos los datos usando matrix list CritInfor.

```
```

La regla para decidir el modelo es seleccionar aquel con menor valor para el criterio de información. Si consideramos el AIC entonces seleccionaremos el Modelo 6, AR(1 3 6 7 12 13).

![]()

A partir de esta última tabla seleccionamos AR(1) frente al resto. Mientras que en la primera tabla seleccionamos AR(1 3 6 7 12 13) frente a AR(1). Entonces, aquella última es la tabla final.
Luego de estimar el modelo debemos revisar si los errores estimados se distribuyen como una normal mediante un histograma y algún test de normalidad. Hagamos un gráfico del histograma.

![]()

El gráfico nos indica que no hay una gran diferencia entre el histograma y la distribución normal. Para un análisis numérico podemos usar el estadístico de Shapiro Wilk para testear la normalidad con el comando swilk. En este caso la nula indica que se distribuye como normal. Encontramos que no es posible rechazarla por lo que nuestros errores serían normales.

![]()

Con esto hemos modelado, bajo ciertos criterios, a la serie de tasa de crecimiento de los términos de intercambio. A partir de esto podemos pronosticar los valores de las series.