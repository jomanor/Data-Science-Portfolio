
### **(3) Determina las tres características de la población con mayor variabilidad. Obtener un individuo que tenga menor valor para cada una de las tres caractersíticas (tres individuos en total, uno con menor valor en la primera característica, otro con menor valor en la segunda y un tercero con menor valor en la tercera) usando un enfoque basado en *distinct***

#### Carga de los datos del conjunto de datos 

```
measure = load 'input/airQualityEsId.csv' using PigStorage(';') AS (id:int, date:chararray, co:float, no:float, no2:float, o3:float, pm10:float, sh2:float, pm25:float, pst:float, so2:float, province:chararray, station:chararray);
```

#### Proyecto sobre la variable a la que quiero calcular la variabilidad 

```
id = foreach measure generate id;
```

#### Elimino los valores repetidos de la variable 

```
distinctid = distinct id;
```

#### Creo un único grupo (agrupo) con todos los valores distintos para poder contarlos 

```
groupallids = group distinctid all;
```

#### Cuento el número de elementos agrupados en el único grupo (todos), generando un individuo con dos valores: una cadena de caracteres con el nombre de la variable y la cuenta de los elementos 

```
totalids = foreach groupallids generate 'id' as var, COUNT (distinctid.id) as many;
```

#### Repito el proceso para todas las demás variables del conjunto 

```
date = foreach measure generate date;
distinctdate = distinct date;
groupalldates = group distinctdate all;
totaldates = foreach groupalldates generate 'date' as var, COUNT (distinctdate.date) as many;

co = foreach measure generate co;
distinctco = distinct co;
groupallcos = group distinctco all;
totalcos = foreach groupallcos generate 'co' as var, COUNT (distinctco.co) as many;

no = foreach measure generate no;
distinctno = distinct no;
groupallnos = group distinctno all;
totalnos = foreach groupallnos generate 'no' as var, COUNT (distinctno.no) as many;

no2 = foreach measure generate no2;
distinctno2 = distinct no2;
groupallno2s = group distinctno2 all;
totalno2s = foreach groupallno2s generate 'no2' as var, COUNT (distinctno2.no2) as many;

o3 = foreach measure generate o3;
distincto3 = distinct o3;
groupallo3s = group distincto3 all;
totalo3s = foreach groupallo3s generate 'o3' as var, COUNT (distincto3.o3) as many;

pm10 = foreach measure generate pm10;
distinctpm10 = distinct pm10;
groupallpm10s = group distinctpm10 all;
totalpm10s = foreach groupallpm10s generate 'pm10' as var, COUNT (distinctpm10.pm10) as many;

sh2 = foreach measure generate sh2;
distinctsh2 = distinct sh2;
groupallsh2s = group distinctsh2 all;
totalsh2s = foreach groupallsh2s generate 'sh2' as var, COUNT (distinctsh2.sh2) as many;

pm25 = foreach measure generate pm25;
distinctpm25 = distinct pm25;
groupallpm25s = group distinctpm25 all;
totalpm25s = foreach groupallpm25s generate 'pm25' as var, COUNT (distinctpm25.pm25) as many;

pst = foreach measure generate pst;
distinctpst = distinct pst;
groupallpsts = group distinctpst all;
totalpsts = foreach groupallpsts generate 'pst' as var, COUNT (distinctpst.pst) as many;

so2 = foreach measure generate so2;
distinctso2 = distinct so2;
groupallso2s = group distinctso2 all;
totalso2s = foreach groupallso2s generate 'so2' as var, COUNT (distinctso2.so2) as many;

province = foreach measure generate province;
distinctprovince = distinct province;
groupallprovinces = group distinctprovince all;
totalprovinces = foreach groupallprovinces generate 'province' as var, COUNT (distinctprovince.province) as many;

station = foreach measure generate station;
distinctstation = distinct station;
groupallstations = group distinctstation all;
totalstations = foreach groupallstations generate 'station' as var, COUNT (distinctstation.station) as many;
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
