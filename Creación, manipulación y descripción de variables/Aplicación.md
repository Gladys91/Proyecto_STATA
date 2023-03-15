# REPLICAR DATOS OFICIALES DE LA INCIDENCIA DE LA POBREZA MONETARIA 2020

Para integrar todos los puntos de la sesión, replicaremos los datos oficiales de la tasa de pobreza del 2020 del INEI.

![image](https://user-images.githubusercontent.com/106888200/225192208-e356c23d-71f8-4a15-9ced-64fe3273ac06.png)

Esta información puedes leerla en el el informe técnico de [Evolución de la Pobreza 2009-2020](https://www.inei.gob.pe/media/MenuRecursivo/publicaciones_digitales/Est/pobreza2020/Pobreza2020.pdf "Evolución de la Pobreza 2009-2020"). 

Trabajaremos con el modulo 34 (sumaria - variables calculadas) de la ENAHO metodología actualizada y condiciones de vida y pobreza - ENAHO del año 2020. Podemos descargar los módulos directamente desde la [_base de microdatos del INEI_](https://proyectos.inei.gob.pe/microdatos/ "_ base de microdatos del INEI_") y descomprimirlos o descargalos ya descomprimidos y limpios desde el siguente [enlace](https://github.com/Gladys91/Proyecto_STATA/tree/main/_An%C3%A1lisis/Data "enlace").

```
use "sumaria-2020.dta"
```

Crearemos las variables de corte: el área urbano y rural se creará con la variable estrato mientras que para crear las regiones naturales costa, sierra y selva utilizaremos la variable dominio. Crearemos la variable Dominio con el comando `gen` y etiquetaremos costa urbana, costa rural, sierra urbana, sierra rural, selva urbana, selva rural y Lima metropolitana siguiendo el código. 

```
*Crear área (estrato)
replace estrato = 1 if dominio ==8 
recode estrato (1/5=1 "Urbana") (6/8=2 "Rural"), gen(Area)
lab var Area "Urbana = 1 Rural = 2"

*Crear Región Natural (dominio)
recode dominio (1/3 8 = 1 "Costa") (4/6 = 2 "Sierra") (7 = 3 "Selva"), g(RNatural)
lab var RNatural "Región Natural"
label define Natural 1"Costa" 2 "Sierra" 3"Selva"
label value RNatural Natural

*Crear dominio Geográfico (Area y Región Natural)
gen Dominio=1 if Area==1 & RNatural==1
replace Dominio=2 if Area==2 & RNatural==1
replace Dominio=3 if Area==1 & RNatural==2
replace Dominio=4 if Area==2 & RNatural==2
replace Dominio=5 if Area==1 & RNatural==3
replace Dominio=6 if Area==2 & RNatural==3
replace Dominio=7 if dominio==8
label var Dominio "Dominio Geográfico"
label define Dominio  1 "Costa urbana" 2 "Costa rural" 3 "Sierra urbana" 4 "Sierra rural" 5 "Selva urbana" 6 "Selva rural" 7 "Lima Metropolitana"
label value Dominio Dominio

*Crear departamentos (ubigeo)
gen dpto= real(substr(ubigeo,1,2))
lab var dpto "Departamentos"
label define dptos 1"Amazonas" 2"Ancash" 3"Apurimac" 4"Arequipa" 5"Ayacucho" 6"Cajamarca" 7 "Callao" 8"Cusco" 9"Huancavelica" 10"Huanuco" 11"Ica" 12"Junin" 13"La Libertad" 14"Lambayeque" 15"Lima" 16"Loreto" 17"Madre de Dios" 18"Moquegua" 19"Pasco" 20"Piura" 21"Puno" 22"San Martin" 23"Tacna" 24"Tumbes" 25"Ucayali"
lab val dpto dptos
```

Procederemos a calcular el gasto per cápita mensual y la linea de pobreza a precios reales de lima.

```
*Gasto real per capita mensual
gen grpm=gashog2d/(ld*mieperho*12)

*linea de pobreza a precios reales de Lima
gen linear_pl=linea/(ld)
```

Recordemos que cuando usemos Sumaria que está a nivel de hogar, para poder obtener las estadísticas oficiales, no podemos usar el factor de expansión de manera directa, se debe generar una nueva variable que multiplique el factor de expansión por mieperho.

```
* Factor de expansión
gen facpob=round(factor07*mieperho,1)
label var facpob "Factor de expansión individuos Sumaria"
```

Declaremos el diseño muestral de nuestra muestra con el comando `svyset`.

```
*Declarando la muestra
svyset [pweight = facpob], psu(conglome) strata(estrato)

svy: mean grpm
svy: mean grpm, over(Dominio)
```

Crearemos la variable pobre.

```
* Tasa de pobreza
g pobre = (grpm < linear_pl)

sum pobre [iw=facpob]
svy:mean pobre, over(dpto)
svy:mean pobre, over(Area)
svy:mean pobre, over(RNatural)
svy:mean pobre, over(Dominio)
```

Podemos verificar que nuestros resultados coinciden con los publicados por el INEI

![image](https://user-images.githubusercontent.com/106888200/225204922-24a968d7-8ac9-4fe0-add3-4d5fc43164aa.png)

![image](https://user-images.githubusercontent.com/106888200/225205074-e332653c-b2bd-43ec-bce9-9506d3c61522.png)

![image](https://user-images.githubusercontent.com/106888200/225205118-828c2fe1-96a5-46fc-8ca9-8f66bf464023.png)






*Puedes usar el kit de replicación de este módulo obteniendo el [script](https://github.com/Gladys91/Proyecto_STATA/blob/main/_An%C3%A1lisis/Scripts/Conceptos%20b%C3%A1sicos/6_merge_append.do "script") y [base de datos](https://github.com/Gladys91/Proyecto_STATA/tree/main/_An%C3%A1lisis/Data "base de datos")* 
