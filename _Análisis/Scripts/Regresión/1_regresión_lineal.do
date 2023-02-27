************
*PONTIFICIA UNIVERSIDAD CATÓLICA DEL PERÚ
* SCRIPT: 1_regresión_lineal.do
* OBJETIVO: Regresiones Lineales
************

* Preambulo 

clear all

global HD_database "C:/Users/Usuario/Desktop/STATA_ECOPUCP/Análisis/Data/HD_database"


**************************************************
use "$HD_database"

use "C:/Users/Usuario/Desktop/STATA_ECOPUCP/Análisis/Data/HD_database", clear

describe

* Estadísticos descriptivos de algunas variables
summarize life school chldmort adfert gdp

* Box plot para expectativa de vida por región
graph box life, over(region) marker(1, mlabel(country)) ///
ytitle("") title("Expectativas de vida al nacer, 2005/2010")

* Regresión inicial
regress life school

* Gráfico de dispersión
twoway ///
(scatter life school) ///
( lfit life school) ///
, legend(off) xlabel(,grid) ylabel(,grid) ///
 ytitle("Expectativas de vida al nacer") xtitle("Escolaridad en años") ///
text(85 4 "predicted {it:life} = 50.36 + 2.45{it:school}")

* Estimamos el valor de y condicional a ciertos valores de x
margins, at(school = (6(1)11))

marginsplot, xtitle("Escolaridad en años") ///
ytitle("Predicción lineal") ///
title("Estimación de la Expectativa de Vida")

* Ejemplos de post-estimatios. Predict
regress life school

predict residuos, residuals // Residuos

predict y_hat , xb 			// Dependiente

scatter y_hat life, xlabel(,grid) ylabel(,grid) ///
xtitle("Expectativa de vida, observada") ///
ytitle("Expectativa de vida, estimada") 

* Resultados almacenados
regress life school

scalar Numero_elementos = e(N)
scalar list  Numero_elementos

matrix betas = e(b)
matrix list betas

* Regresión con categóricas
regress life school i.region c.school#i.region // Opción 1

regress life c.school##i.region				   // Opción 2