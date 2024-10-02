### **(3) Determina las tres características de la población con mayor variabilidad. Obtener un individuo que tenga menor valor para cada una de las tres caractersíticas (tres individuos en total, uno con menor valor en la primera característica, otro con menor valor en la segunda y un tercero con menor valor en la tercera) usando un enfoque basado en *group***

#### Carga de los datos del conjunto de datos 

```
measure = load 'input/airQualityEsId.csv' using PigStorage(';') AS (id:int, date:chararray, co:float, no:float, no2:float, o3:float, pm10:float, sh2:float, pm25:float, pst:float, so2:float, province:chararray, station:chararray);
```

#### Proyecto sobre la variable a la que quiero calcular la variabilidad 

```
id = foreach measure generate id;
```

#### Creo grupos (agrupo) por valores iguales de la variable

```
groupid = group id by id;
```

#### Creo un único grupo (agrupo) con todos los grupos creados para poder contarlos 

```
groupallids = group groupid all;
```

#### Cuento el número de elementos agrupados en el único grupo (todos), generando un individuo con dos valores: una cadena de caracteres con el nombre de la variable y la cuenta de los elementos 

```
totalids = foreach groupallids generate 'id' as var, COUNT (groupid.id) as many;
```

#### Repito el proceso para todas las demás variables del conjunto 

```
date = foreach measure generate date;
groupdate = group date by date;
groupalldates = group groupdate all;
totaldates = foreach groupalldates generate 'date' as var, COUNT (groupdate.date) as many;

co = foreach measure generate co;
groupco = group co by co;
groupallcos = group groupco all;
totalcos = foreach groupallcos generate 'co' as var, COUNT (groupco.co) as many;

no = foreach measure generate no;
groupno = group no by no;
groupallnos = group groupno all;
totalnos = foreach groupallnos generate 'no' as var, COUNT (groupno.no) as many;

no2 = foreach measure generate no2;
groupno2 = group no2 by no2;
groupallno2s = group groupno2 all;
totalno2s = foreach groupallno2s generate 'no2' as var, COUNT (groupno2.no2) as many;

o3 = foreach measure generate o3;
groupo3 = group o3 by o3;
groupallo3s = group groupo3 all;
totalo3s = foreach groupallo3s generate 'o3' as var, COUNT (groupo3.o3) as many;

pm10 = foreach measure generate pm10;
grouppm10 = group pm10 by pm10;
groupallpm10s = group grouppm10 all;
totalpm10s = foreach groupallpm10s generate 'pm10' as var, COUNT (grouppm10.pm10) as many;

sh2 = foreach measure generate sh2;
groupsh2 = group sh2 by sh2;
groupallsh2s = group groupsh2 all;
totalsh2s = foreach groupallsh2s generate 'sh2' as var, COUNT (groupsh2.sh2) as many;

pm25 = foreach measure generate pm25;
grouppm25 = group pm25 by pm25;
groupallpm25s = group grouppm25 all;
totalpm25s = foreach groupallpm25s generate 'pm25' as var, COUNT (grouppm25.pm25) as many;

pst = foreach measure generate pst;
grouppst = group pst by pst;
groupallpsts = group grouppst all;
totalpsts = foreach groupallpsts generate 'pst' as var, COUNT (grouppst.pst) as many;

so2 = foreach measure generate so2;
groupso2 = group so2 by so2;
groupallso2s = group groupso2 all;
totalso2s = foreach groupallso2s generate 'so2' as var, COUNT (groupso2.so2) as many;

province = foreach measure generate province;
groupprovince = group province by province;
groupallprovinces = group groupprovince all;
totalprovinces = foreach groupallprovinces generate 'province' as var, COUNT (groupprovince.province) as many;

station = foreach measure generate station;
groupstation = group station by station;
groupallstations = group groupstation all;
totalstations = foreach groupallstations generate 'station' as var, COUNT (groupstation.station) as many;
```

#### Uno todos los individuos de tipo pareja (cadena de caracteres con el nombre de la variable, cuenta de valores distintos de la variable) en una única población 

```
allvars = UNION totalids, totaldates, totalcos, totalnos, totalno2s, totalo3s, totalpm10s, totalsh2s, totalpm25s, totalpsts, totalso2s, totalprovinces, totalstations;
```

#### Ordeno la población de parejas por orden descendente sobre la cuenta del número de valores distintos

```
allvarordered = order allvars by many desc;
```

#### Devuelvo las tres parejas (cadena de caracteres con el nombre de la variable, cuenta de valores distintos de la variable) con mayores valores distintos de la variable 

```
biggest3 = limit allvarordered 3;
```

#### Muestro el resultado 

```
dump biggest3;
```
