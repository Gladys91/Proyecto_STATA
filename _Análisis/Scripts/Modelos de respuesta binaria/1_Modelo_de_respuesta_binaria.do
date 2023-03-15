************
*PONTIFICIA UNIVERSIDAD CATÓLICA DEL PERÚ
* SCRIPT: 1_Modelo de respuesta binaria.do
* OBJETIVO: Modelo Logit - Probit
************

*Preámbulo
clear all
sysuse lbw 

*************

describe 

tab low // variable dependiente

*Logit
