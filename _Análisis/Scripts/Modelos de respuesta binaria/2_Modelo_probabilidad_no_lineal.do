************
*PONTIFICIA UNIVERSIDAD CATÓLICA DEL PERÚ
* SCRIPT: 2_Modelo_probabilidad_no_lineal.do
* OBJETIVO: Modelo Logit - Probit
************

*Preámbulo
clear all
sysuse lbw 

*************

describe 

tab low // variable dependiente

*MPL
*estimación sin considerar la heterocedasticidad
reg low age lwt i.race smoke ht  //
est store mpl_1

*estimación considerando la heterocedasticidad
reg low age lwt i.race smoke ht, robust  //
est store mpl_2

*comparando los resultados
esttab mpl_1 mpl_2, nomtitle r2 p


*Modelo Logit

logit low age lwt i.race smoke ht
logit low age lwt i.race smoke ht, or // odds - ratios

predict low_predict, xb
 
*modelo logit/probit no se estiman por minimos cuadrados ordinarios, se estiman por máxima verosimilitud
margins, dydx(race)
margins, dydx(*)

*Modelo Probit
probit low age lwt i.race smoke ht
margins, dydx(*)

