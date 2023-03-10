# Regresiones

### 7. ENDOGENEIDAD EN LOS MODELO

### 7.1 ENDOGENEIDAD

Los problemas de endogeneidad son constantes al momento de estimar un modelo. Una forma fácil de entender la endogeneidad es considerar que hay una correlación entre una variable explicativa (incluida o no ) y el término de error. Es decir:  

  ![image](https://user-images.githubusercontent.com/106888200/224231853-c90b37b8-b4a0-4159-9f6e-5785c45f4470.png)


Definamos que esto puede ocurrir producto de:
- Sesgo por omisión de variables
- Simultaneidad entre variable dependiente e independiente
- Mala especificación del modelo
- Sesgo de selección

Veamos un ejemplo clásico de simultaneidad.
Consideremos una ecuación de oferta y otra de demanda:

![image](https://user-images.githubusercontent.com/106888200/224231802-c2d58206-8120-4035-bda0-d12c729c94d0.png)


Si queremos estimar Qd sin considerar que P se determina simultáneamente en las ecuaciones entonces tendríamos problemas de endogeneidad. Si encontramos los valores de equilibrio de las variables obtenemos:

![image](https://user-images.githubusercontent.com/106888200/224231925-aa43209d-4b62-4fc6-95b1-6191f5797a6a.png)

A partir de esto, podemos verificar que:

![image](https://user-images.githubusercontent.com/106888200/224231972-71b5e77e-67c8-46e4-8a36-9d21cf3a2cdc.png)

Por lo que no se cumpliría que E(P_d_ ε_d_),  por lo tanto, hay endogeneidad

### 7.2 VARIABLES INSTRUMENTALES

Para resolver este problema podemos proponer un o un conjunto de variables instrumentales. Un instrumento debería no estar correlacionado con el término de error y solo afectar a la variable independiente mas no a la dependiente. Definamos a un instrumento como z. Comparemos distintos escenarios:

![image](https://user-images.githubusercontent.com/106888200/224232364-8493a449-cff1-49db-bd42-e7bd4540ebb5.png)

- Exogeneidad, cov(z,u)=0
- Relevancia, Corrz(z,x),x≠0 . Es decir que z tenga la capacidad de explicar x.

El uso de variables instrumentales se puede dar bajo distintos métodos de estimación, no solo bajo MCO. En este caso revisaremos cómo estimar el modelo básico usando dos métodos: Mínimo Cuadrado en 2 Etapas y el Método Generalizado de Momentos. 

### 7.3 ESTIMANDO PASO A PASO, IVREGRESS Y IVREG2

Comenzamos viendo la estimación por dos etapas. Consideremos a x1 como la variable endógena, x2 como otra variable explicativa no endógena, a z como la variable instrumental y a y como la variable dependiente. La primera etapa consiste en estimar:

![image](https://user-images.githubusercontent.com/106888200/224233074-6a7aeeaa-81b1-4ce5-aa7f-b2d577a78c00.png)

A partir de esto se obtiene:

![image](https://user-images.githubusercontent.com/106888200/224233143-e672bdd0-cdbc-40a0-a35b-3d4d642bcc24.png)

Usamos el valor estimado de x1 para regresionar:

![image](https://user-images.githubusercontent.com/106888200/224233175-0bdd80a6-3379-45f0-98f8-57db19abb099.png)

Podemos llegar a esta estimación paso a paso, estimando cada etapa, o usando un comando en particular. Hay dos comandos bastante usados, `ivregress` y `ivreg2`. Comparemos los tres caminos.

Como ejemplo tomemos los datos del estudio de Romer (1993) en donde se busca estimar la correlación entre la tasa de inflación de un país y su nivel de apertura comercial (controlado por el nivel de ingreso per cápita en logaritmo). Para ello planteamos un modelo simple:

![image](https://user-images.githubusercontent.com/106888200/224233259-e2ac0fd4-b42c-4052-ab08-9b2eed1abcc8.png)

En este caso planteamos como variable instrumental al logaritmo de la extensión territorial del país. Veamos:

```
* Estimamos un modelo por MC2E

* Manualmente
reg open lland lpcinc 
predict open_hat, xb
reg inf open_hat lpcinc

* Usando ivregress
ivregress 2sls inf (open = lland) lpcinc

* Usando ivreg2
ivreg2 inf (open = lland) lpcinc
```

Si lo hacemos paso a paso, primero debemos estimar la primera etapa del modelo, luego predecir el valor de la variable endógena y, por último, usar esta nueva variable como regresor en la ecuación final. En el caso de `ivregress` debemos indicar que estime el modelo en dos etapa indicando 2sls:

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332675962_1180619832590750_5698837841389207216_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_ohc=xB-fiOrR1i4AX8xXYgj&_nc_ht=scontent.flim30-1.fna&oh=00_AfDvfCQiQnaRO_mU2GLSjC0VXFLqbHNIk1OIodhLjhF5cA&oe=6401DE37)

Entre paréntesis debemos indicar la variable endógena y el o los instrumentos a usar. Fuera podemos indicar las variables explicativas que no son endógenas. En el caso de `ivreg2` no es necesario indicar expresamente que se estime por dos etapas puesto que es la opción por default. Este último comando tiene una amplia cantidad de opciones disponibles para usar, así como un resultado acompañado de mayor información.
Al comparar los tres resultados obtenemos los mismos coeficientes y estadísticos. En el resultado de `ivreg2` podemos ver la información usual sino también más información sobre algunos tests realizados. Regresaremos a estos test posteriormente.

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332161135_604947761452221_7908653181058958762_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_ohc=JhI1GzXCOO0AX93GFdl&_nc_ht=scontent.flim30-1.fna&oh=00_AfAvHnHsw05pW95AUmNxqOydWThSjjv8Q9a27FSuBHL54A&oe=64017DA9)

En el resultado de `ivreg2` podemos ver la información usual sino también mayor información sobre algunos tests realizados. Regresaremos a estos test posteriormente.

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332512148_5932290493498014_4182605900052236939_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=730e14&_nc_ohc=F1mj4rH1x7QAX-SHQSV&_nc_ht=scontent.flim30-1.fna&oh=00_AfCUNMs5Qe0vRSxGCo-N4zq5QwuHuCBMqZUrRRkxnEhTCQ&oe=640202BB)

#### 7.3.1 Gmm 

El método generalizado de momentos estima el modelo de manera distinta al estimador de dos etapas. En este escenario se busca que los estimadores cumplan con:

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332168954_1265504714378707_3638066314985912383_n.jpg?stp=cp0_dst-jpg&_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_ohc=loAYKTii0fQAX9jwAwd&_nc_ht=scontent.flim30-1.fna&oh=00_AfBNt5I4n_xScTaJ5ZhojAo6tDyqV2iZCpliuhQP3Bw1Ag&oe=64012D05)

Siendo g() la función generalizadora de momentos y el vector de coeficientes a estimar. Este no es un método lineal como en el caso anterior. Veamos las diferencias de estimar el modelo considerando dos etapas y considerando el Método generalizado de momentos:

```
* Estimemos el modelo usando el método generalizado de momentos o GMM

eststo clear
eststo: ivregress 2sls inf (open = lland) lpcinc
eststo: ivregress gmm  inf (open = lland) lpcinc
esttab , mtitle("2SLS" "GMM")

```

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332624921_757725422157251_4450961197310592529_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_ohc=DqXYbgZfKZYAX_1tOiT&_nc_ht=scontent.flim30-1.fna&oh=00_AfCoOpHX9qh0oOtw-PTf7Hq97-ASrX0EnVQjtKre35JTEA&oe=640121A8)

En este caso vemos que el coeficiente estimado es igual pero los errores estándar son distintos. Esto se debe a que son dos maneras distintas de obtener los valores de los coeficientes.

## Sigue aprendiendo
| Recurso  | Tema | Descripción |
| ------------- |:-------------:|:-------------:|
|   |  |   |
|   |  |   |


****Puedes usar el kit de replicación de este módulo obteniendo el [script](https://github.com/Gladys91/Proyecto_STATA/tree/main/_An%C3%A1lisis/Scripts/Conceptos%20b%C3%A1sicos "script") y [base de datos](https://github.com/Gladys91/Proyecto_STATA/tree/main/_An%C3%A1lisis/Data "base de datos")*

