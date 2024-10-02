### **(2) A partir de los flujos separados en el ejercicio anterior obtener la máxima medida de CO2 y de PM10 por provincia en un sólo filtrado.**

#### Cargar los tres flujos en tres relaciones

```
gases = load 'pigResults/gases/part-m-00000' using PigStorage(';') AS (id:int, co:float, no:float, no2:float, o3:float, sh2:float, so2:float);
parts = load 'pigResults/particles/part-m-00000' using PigStorage(';') AS (id:int, pm10:float, pm25:float, pst:float);
rest_data = load 'pigResults/other_data/part-m-00000' using PigStorage(';') AS (id:int, date:chararray, province:chararray, station:chararray);
```

#### Filtrar las características que necesitamos de las tres relaciones: el ID para poner juntos los datos de cada muestra y las características de salidad para el resultado

```
filtradoGases = foreach gases generate id, co;
filtradoParticulas = foreach parts generate id, pm10;
filtradoResto = foreach rest_data generate id, province;
```

#### Reunir los datos de los tres flujos en uno (poner los datos juntos) a través de la característica que los une (ID)

```
filtradosJuntos = JOIN filtradoGases BY id, filtradoParticulas BY id, filtradoResto BY id;
```

#### Crear grupos (poner juntas) todas las muestras que tengan la misma provincia (el mismo valor en la característica)

```
agrupados = GROUP filtradosJuntos BY province;
```

#### Para cada grupo creado, generar una relación que contenga al representante de grupo (la provincia) y los máximos de los valores de CO y PM10 en las muestras del grupo 

```
final = foreach agrupados generate group, MAX(filtradosJuntos.filtradoGases::co), MAX(filtradosJuntos.filtradoParticulas::pm10);
```

#### Almacenar el resultado

```
store final into 'pigResults/other_data' using PigStorage(';');
```
