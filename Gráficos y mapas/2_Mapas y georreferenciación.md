# Gráficos y mapas

### 2. MAPAS Y GEORREFERENCIACIÓN

Stata también permite graficar mapas simples de manera rápida frente a otros softwares como ArcGis o Qgis que, aunque se especializan en mapas, pueden requerir de una curva de aprendizaje más trabajosa. Por lo que usar Stata para hacer mapas simples iniciales puede ser de mucha utilidad. A pesar de esto, un manejo más profundo y específicos de mapas requeriría usar los programas antes mencionados. 
Ahora, comenzaremos conociendo cómo manejar los datos necesarios para hacer mapas. Luego tomaremos estos datos y los combinaremos con datos más estándar para hacer mapas básicos informativos.

### 2.1 MANEJANDO DATOS GEOGRÁFICOS

Los softwares especializados en mapas pueden tomar como insumo distintos tipos de datos. En este caso partiremos de datos llamados shapefiles, estas bases contienen información de ubicaciones espaciales en términos de coordenadas (longitud y latitud). 
Podemos encontrar datos de shapefiles para distintos lugares buscando en google. Busquemos para Perú y descarguemos los shapefiles a nivel departamental (es decir, los límites de los departamentos).

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332387109_754218822598104_5975565281978748085_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=730e14&_nc_ohc=Xtkrm6hY3eoAX_5Ebyk&_nc_ht=scontent.flim30-1.fna&oh=00_AfCjzRVmuE2MgHl7e-n8W_JTr6ceDDKBI03FjigJOfQVwA&oe=63FF6A26)

Luego de descargar el archivo lo guardamos en las carpetas en donde guardamos los datos de la sesión. Deberíamos tener una carpeta con los siguientes datos: 

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332379359_737326274453580_1283137274598342126_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=730e14&_nc_ohc=V9-HoXebk4sAX8MpFag&_nc_ht=scontent.flim30-1.fna&oh=00_AfDJi9Go8D2Dtn3hf9R2KPJMyJbZXqH0klTwjWYIekYn6g&oe=64002A69)

La terminación de un archivo shapefile es ‘.shp’. El resto de archivos los podemos mantener en la misma carpeta.

#### 2.1.1 Transformando datos shapefile a datos dta

Luego de ordenar los shapefiles que usaremos tenemos que transformalo a un formato que Stata pueda interpretar. Para ello usamos el comando shp2dta (se debe instalar previamente si es que no se tiene disponibles). El comando usa (using) el archivo shapefile y crea dos nuevas bases de datos.

```
* Se debe instalar previamente shp2dta
ssc install shp2dta

* Transformamos los datos de shapefiles a dta

shp2dta using "$mapa",  ///
 data("$data_dpto") 	///
 coord("$coordenadas") 	///
 genid(dpto_id)  replace
```

Adicionalmente, indicamos el nombre de la nueva variable indicador, dpto_id. Por último, indicamos el comando replace.
Los nombres de estas bases están dadas en data() y en coord(), ambas son dpto y dpto_coord. Abramos las bases nuevas:

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332582770_928144051540185_600301955389990022_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=ev7QQXZmUQEAX-_7vm5&tn=Xc4MjXoFM9qCnvxH&_nc_ht=scontent.flim30-1.fna&oh=00_AfAsC8tOhnAKnsiFS0DTWJwPcz6PCDzGM5eG9IJd4pTJog&oe=6400915D)

En la base dpto encontramos los nombres de los departamentos junto a las variables indicador, ‘IDPPTO’ y ’dpto_id’.

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332768863_749613299834915_5577276815412978425_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=AzaK7RMkZnMAX-NHG66&_nc_ht=scontent.flim30-1.fna&oh=00_AfAqjG_a6xvvhUwd8jvHioSK_par7LMDq2OwZjmULSF0gQ&oe=64006D86)

En la base dpto_coord encontramos las coordenadas de los límites de cada unidad, en este caso las regiones.
Luego de transformar los datos podemos hacer un gráfico simple de los límites departamentales del Perú: 

```
* Se debe instalar previamente spmap 
ssc install spmap

* Cargammos la base 
use "$data_dpto", clear

spmap using "$coordenadas", 						///
id(dpto_id) ocolor(black) osize(vthin) title("Limites departamentales del Perú")
```

Luego de cargar la base que transformamos previamente usamos el comando spmap (hay que instalarlo previamente) usando (using) la base de coordenadas que creamos previamente. Adicionalmente, hay que indicar el indicador de cada departamento, en este caso dpto_id indica el indicador. Adicionalmente podemos definit el color de cada unidad (o polígonos) así como su tamaño, usando ocolor y osize.
Obtendríamos un mapa como el siguiente:

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332283902_916455929360980_5545608097480217182_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=730e14&_nc_ohc=H6Gd2h5BKI4AX-V2oBk&_nc_ht=scontent.flim30-1.fna&oh=00_AfB5YNUn9nGoYcpaL_aAJ2pqGE-WULEK0EX0iBvrHtmiBQ&oe=63FEF9A3)

### 2.2 HACIENDO MAPAS EN STATA 

Juntemos estos datos iniciales con alguna base externa. En este caso vamos a usar una base de datos de gasto público por alumno en educación secundaria que construimos a partir de los datos del INEI. En este caso hemos trabajado previamente el excel inicial para tener un formato fácil de cargar al programa y que tenga una variable indicador igual al que usamos en las bases de mapas, es decir dpto_id.

```
* Cargamos la  base de departamentos y lo juntamos con otra base 
use "$data_dpto", clear
merge 1:1 dpto_id using "$gastoporalumno"

gen delta = (log(y2018) - log(y2008))*100
 
spmap delta using "$coordenadas", ///
 id(dpto_id) ocolor(white ..) osize(thin) fcolor(YlGnBu) 				///
 legend(pos(7) title("Rangos de Gasto", size(*0.5))) 				///
 title("Gasto Público por Alumno" "en Educación Secundaria" "2018") 
```

Luego de cargar la base de mapas la juntamos con la base previamente construida ‘gastoporalumno_region’ usando la variable indicador. Posteriormente creamos una variable delta que mida la tasa de crecimiento entre le gasto del 2018 y el del 2008. Luego usamos un código similar al previo, pero indicando que se use la variable nueva.

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/333446589_3370756583167513_672598796710599362_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_ohc=aaeJYkplbHMAX_gyQie&tn=Xc4MjXoFM9qCnvxH&_nc_ht=scontent.flim30-1.fna&oh=00_AfDBYwuHfHkJ5P2nbS5VpZZcpG_eyqh4v4Xyy00BMyVk0A&oe=6400695A)

Los departamentos con mayor crecimiento en este gasto público serían Amazonas, Madre de Dios, Puno, Apurímac, Ayacucho y Huancavelica.
Las posibilidades para hacer mapas en Stata son bastante extensas por lo que se recomienda ver algunos recursos virtuales como guías o documentación en la ayuda del programa escribiendo help spmap o help shp2dta.



## Sigue aprendiendo
| Recurso  | Tema | Descripción |
| ------------- |:-------------:|:-------------:|
|   |  |   |
|   |  |   |


****Puedes usar el kit de replicación de este módulo obteniendo el [script](https://github.com/Gladys91/Proyecto_STATA/tree/main/_An%C3%A1lisis/Scripts/Conceptos%20b%C3%A1sicos "script") y [base de datos](https://github.com/Gladys91/Proyecto_STATA/tree/main/_An%C3%A1lisis/Data "base de datos")*
