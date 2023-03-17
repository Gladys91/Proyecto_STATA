# Modelos Multinomiales


Recordemos que una variable nominal es aquella donde la variable tiene varias categorías, cuandos la variable dependiente es una variable nomimal con dos categorías nos encontramos ante un modelo binomial, sin embargo cuando estás variables tienen más de dos categorías, nos encontramos ante modelos multinomiales.

Los  modelos econométricos que se pueden utilizar para modelar modelos de respuesta multinomial son los siguientes:

- Logit o Probit multinomial
- Logit condicional
- Logit anidado

En este módulo nos enfocaremos en el módelo de logit multinomial. 


## 1.  LOGIT MULTINOMIAL

La variable dependiente tiene más  m  categorías, siendo $P_1$, $P_2$,..., $P_m$, las probabilidades de escoger o caer en alguna de estas categorias.

Generzalizando el caso logit, la probabilidad de que el individuo i elija la alternativa j es:


$$P_{ji}=\frac{exp(x_i\beta_j)}{1 + \sum_{k=1}^{m-1} exp(x_i\beta_k)}$$


$$P_{mi}=\frac{1}{1 + \sum_{k=1}^{m-1} exp(x_i\beta_k)}$$

$$j = 1, ..., m-1$$

- La categoría "m" es la categoría base.
- La decisión por algunas de las alternartivas depende de las características de $x_i$
- Este modelo es una generalización del modelo logit bonimial.
- En general para m alternativas se estimaran m-1 vectores de parámetros, \beta_1, \beta_2,..., \beta_{m-1}, maximizando la verosimilitud. Tomando logaritmos:

$$lnL=\sum_{i=1}^n\sum_{j=1}^m Y_{ij}lnP_{ij}$$

- Maximizando esta función se obtienen los estimadores $\hat{\beta_1}$, $\hat{\beta_2}$, ...., $\hat{\beta_{m-1}}$


### 1.1 EFECTOS MARGINALES






## Sigue aprendiendo
| Recurso  | Tema | Descripción |
| ------------- |:-------------:|:-------------:|
| UCLA - Stata learning module  | [Getting help](https://stats.oarc.ucla.edu/stata/modules/getting-help-using-stata/ "Getting help") | Cómo obtener ayuda en Stata  |
| UCSF GSI  | [Thinking like Stata](https://www.youtube.com/watch?v=jTtIREfhyEY&t=108s&ab_channel=UCSFGSI "Thinking like Stata") | Manejar la sintaxis de los comandos en Stata  |


****Puedes usar el kit de replicación de este módulo obteniendo el [script](https://github.com/Gladys91/Proyecto_STATA/tree/main/_An%C3%A1lisis/Scripts/Conceptos%20b%C3%A1sicos "script") y [base de datos](https://github.com/Gladys91/Proyecto_STATA/tree/main/_An%C3%A1lisis/Data "base de datos")* 
