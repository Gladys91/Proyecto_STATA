# Regresiones

### 5. ORDENANDO Y EXPORTANDO LOS RESULTADOS A DISTINTOS FORMATOS

En este modulo vamos a comenzar por explorar algunos comando bastante utilizados para el ordenamiento y exportación de resultados, tanto de regresiones como de otro tipo. Particularmente, el paquete de opciones de `estout` y `outreg2`. Ambas necesitan instalarse previamente usando `ssc install estout` y `ssc install outreg2`, respectivamente.
El objetivo es crear tablas usando los resultados de las regresiones, editarlas y ver en qué formatos se pueden exportar.

### 5.1 ESTOUT

El paquete de comandos de `estout` permite hacer tablas no solo de regresiones, pero también de estadísticos. Comencemos aprendiendo el comando `estout`. Si recuerda ya hemos usado previamente uno de los comandos de este paquete. Al momento de correr una regresión podemos usar el prefijo `estout` para ir almacenando los resultados. También podemos usar `estimates store` seguido por un nombre luego de una regresión para almacenar los resultados. Veamos un ejemplo:
   
```
reg i524a1 p208a i.p207
estimates store m1

reg i524a1 p208a i.p207 i.dpto
estimates store m2

estout m1 m2

eststo clear
eststo: reg i524a1 p208a i.p207
eststo: reg i524a1 p208a i.p207 i.dpto

estout
```

En la primera parte guardamos los resultados usando `estimates store` y en la segunda parte usamos `eststo`: En este caso i.dpto hace referencia a las categorías de regiones. Veamos el resultado.

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332694425_722651876202218_4323404106983198247_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=730e14&_nc_ohc=SS9W6CPOI4gAX_vrKwv&tn=Xc4MjXoFM9qCnvxH&_nc_ht=scontent.flim30-1.fna&oh=00_AfCknbKIB6_rXU6Mptag1p5IcmjGCkSFja4UPQFmyDWhJA&oe=6400394B) 

Cuando se usa `estout`, se junta los coeficientes estimados para ambos modelos y se agrega. Un problema claro con esta tabla es que no es clara. Se acumulan los resultados de las dummies por región y de la categoría base para género. Podemos editar esta tabla para mejorarla.

```
* Editando la tabla final
estout, drop(*dpto 1.p207) rename(p208a Edad 2.p207 Mujer _cons Const) ///
mlabels("(1)" "(2)") title("Tabla 1") legend ///
cells("b( star label(Coef.) fmt(2)) p(fmt(2) label(p-value))" ///
 se(fmt(2) label(S.E.)))  stats(r2 N, labels("R-cuadrado" "N. de obs."))
```

En este caso estamos agregando una serie de opciones para editar el resultado final de la tabla:

- `drop()`: Eliminamos las variables que no nos interesa agregar en la tabla final. Por ejemplo la categoría base de la variable de género y las dummies de región.
- `renam()`: Renombramos las etiquetas de las variables que están en la tabla para que se entienda mejor
- `mlabels()`: Son como los títulos de cada columna
- `title()`: El título de la tabla
- `legend`: Con esto se agrega la leyenda en las tablas.
- `cells()`: Son los resultados que se buscan presentar, en este caso b hace referencia a los betas, p al p-value y se al error estándar.
- `stats()`: Son estadísticos adicionales que se agregan al final de la tabla. En este caso el R-cuadrado y el número de observaciones.

Veamos a detalle el código para `cells()`. En este caso, además de indicar el resultado a agregar (como el beta o el error estándar), también podemos indicar algunos detalles adicionales como que se agreguen estrellas por la significancia, se cambie la etiqueta (se usa `label()` con el nombre final) y que se de formato (se usa `fmt()` indicando el formato, en este caso 2 indica dos decimales).

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332483388_3344059619242755_3178163821742137626_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_ohc=y-ItXwLPhsAAX_a8sFG&_nc_ht=scontent.flim30-1.fna&oh=00_AfAKmMMhoIcN8CKZo-4Pi3Yi0kT74epyanttOp2Tq4AIFQ&oe=6400BA1D)

Ojo: en el caso de `cells()` indicamos entre comillas b, para los coeficientes, y p, para el p-value. Esto indica que se posicionan verticalmente. Mientras que, para error estándar, está fuera de la comilla por lo que se ubica debajo de los coeficientes.

### 5.2 ESTTAB

El comando `esttab` es una simplificación de `estout`. Su uso es muy similar a este pero no precisa de detallar muchas opciones.

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332701584_745697820482034_5855358093779717234_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=730e14&_nc_ohc=qHeqBrjC0g0AX8Yd_Un&_nc_ht=scontent.flim30-1.fna&oh=00_AfB1-IlYhY6sIHuZ4cFpz4Y8VSxPIzNCGfr4ZoLBy4SksQ&oe=6400D8AE) 

Este comando permite el mismo nivel de detalle que el previo:

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332707245_2418637884984338_2165249918197313675_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=730e14&_nc_ohc=EplNMF61GD0AX8Jhj_K&_nc_ht=scontent.flim30-1.fna&oh=00_AfA_IX5FucroxMSjEoH2zQQJm8qa22WMn3Ylwas9r5uVXg&oe=6400050D) 

### 5.3 EXPORTANDO EL RESULTADO

Veamos como exportar las tablas que creamos a tres tipos de formato: a formato .csv (puede ser abierto en Excel), a formato .rtf (puede ser abierto en Word u otro editor de texto) y en formato .tex (para cargar la base a una documento de LATEX). Solo hay que agregar algunas cosas adicionales al código previo. Primero, la ubicación y el formato de la tabla. Para ello usamos _esttab using "/Users/direccion/tabla_1.csv"_, o también indicando alguno de los otros formatos.

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332213057_1873403136355574_4831801267764569711_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=730e14&_nc_ohc=ah8fMKmFtxIAX885qHO&tn=Xc4MjXoFM9qCnvxH&_nc_ht=scontent.flim30-1.fna&oh=00_AfB2i58UC_nY8hl50swUFTT6FyjTcBme8ACp3F8THwrcIw&oe=6400CC6E) 

El documento .csv se tiene que abrir como una base de datos de texto en excel para que se pueda ver bien (Abrimos _Excel -> Pestaña Datos -> Desde el texto-> Elegimos el archivo -> Elegimos el delimitador, en este caso es coma (,)_).

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332714945_1541061629723870_4733101633239423602_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=730e14&_nc_ohc=OBsCMXDIW-sAX911aEk&_nc_ht=scontent.flim30-1.fna&oh=00_AfBqxuDiSlzSqccEr1mfzBIrctWugtKmUMB0XhSMT8rMHg&oe=64002DFA) 

El archivo .rtf puede abrirse desde Word y el archivo .tex desde algún editor de LATEX como TexStudio u Overleaf.

### 5.4 OUTREG2

El comando `outreg2` es similar al anterior, pero tiene otro conjunto de comandos para opciones y otra forma de sintaxis. Una gran diferencia es que puede producir tablas en formato .doc, el formato directo de Word. También puede producir para exportar a LATEX. Veamos su sintaxis.

```
* Usando outreg2

reg i524a1 p208a i.p207
outreg2 using "/Users/2020-1/INFOX/Sesiones/4/code/tabla_2.doc" , ///
replace keep(p207 p208a)

reg i524a1 p208a i.p207 i.dpto
outreg2 using "/Users/2020-1/INFOX/Sesiones/4/code/tabla_2.doc" , ///
append keep(p207 p208a) 
```
En este caso no se ‘almacenan’ los resultados, en cambio se crea una tabla inmediatamente después de hacer una regresión. En este caso creamos un documento .doc e indicamos la opción replace para que cada vez que se corra esa línea se cree un archivo nuevo. En la segunda regresión hacemos algo similar, pero en vez de usar la opción replace usamos la opción `append` para anexar (append) los resultados a la tabla creada líneas arriba. En este caso usamos la opción `keep()` para quedarnos con un subconjunto de variables. Veamos el resultado:
La tabla, al menos en Word, parece estár más detallada que en el caso del formato .rtf de estout. Al menos si planea solo usar Word para editar sus tablas puede ser preferible practicar más usando el comando `outreg2`.

![](https://scontent.flim30-1.fna.fbcdn.net/v/t39.30808-6/332717945_904146587495090_6584954472461320864_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=730e14&_nc_ohc=3YJDNfksPEEAX9hdsl_&_nc_ht=scontent.flim30-1.fna&oh=00_AfDDrnaYWByB68UdfZM1SAL5RcBLcuqtyTOaoMPmARCn4A&oe=6400D91F) 

