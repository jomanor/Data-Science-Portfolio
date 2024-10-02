## Ejercicio 1

**(1) Generar flujo de datos de calidad del aire con Id. Hay que generar tres flujos independientes: Id + datos de gases, Id + datos de partículas, Id + resto**


### Cargar los datos

```
measure = load 'input/airQualityEsId.csv' using PigStorage(';') AS (id:int, date:chararray, co:float, no:float, no2:float, o3:float, pm10:float, sh2:float, pm25:float, pst:float, so2:float, province:chararray, station:chararray);
```
### Tomar la id y los datos de los gases y almacenarlos

```
gases = foreach measure generate id, co,  no, no2, o3, sh2,  so2;
store gases into 'pigResults/gases' using PigStorage(';');
```
### Tomar la id y los datos de las partículas y almacenarlos

```
parts = foreach measure generate id, pm10, pm25, pst;
store parts into 'pigResults/particles' using PigStorage(';');
```
### Tomar la id y el resto de datos y almacenarlo

```
rest_data = foreach measure generate id, date, province, station;
store rest_data into 'pigResults/other_data' using PigStorage(';');
```
