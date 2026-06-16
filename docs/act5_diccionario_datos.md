# Diccionario de Datos - SmartRoute DSS

## clientes

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_cliente | SERIAL | PK | Identificador del cliente |
| razon_social | VARCHAR(120) | NOT NULL | Nombre o razón social |
| nit | VARCHAR(30) | UNIQUE | Identificación tributaria |
| telefono | VARCHAR(30) | NULL | Teléfono de contacto |
| email | VARCHAR(120) | NULL | Correo del cliente |

## direcciones

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_direccion | SERIAL | PK | Identificador de dirección |
| id_cliente | INT | FK, NOT NULL | Cliente propietario de la dirección |
| ciudad | VARCHAR(80) | NOT NULL | Ciudad |
| zona | VARCHAR(80) | NULL | Zona o barrio |
| calle | VARCHAR(150) | NOT NULL | Dirección textual |
| latitud | DECIMAL(10,7) | CHECK | Coordenada geográfica |
| longitud | DECIMAL(10,7) | CHECK | Coordenada geográfica |

## usuarios

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_usuario | SERIAL | PK | Identificador del usuario |
| nombre | VARCHAR(100) | NOT NULL | Nombre completo |
| email | VARCHAR(120) | UNIQUE, NOT NULL | Correo de acceso |
| password_hash | VARCHAR(255) | NOT NULL | Contraseña cifrada |
| rol | VARCHAR(30) | CHECK | ADMIN, GERENTE, DESPACHADOR o CONDUCTOR |
| activo | BOOLEAN | DEFAULT TRUE | Estado de la cuenta |

## vehiculos

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_vehiculo | SERIAL | PK | Identificador del vehículo |
| placa | VARCHAR(20) | UNIQUE, NOT NULL | Placa del vehículo |
| modelo | VARCHAR(80) | NOT NULL | Modelo |
| capacidad_kg | DECIMAL(10,2) | CHECK > 0 | Capacidad de carga |
| capacidad_volumen | DECIMAL(10,2) | CHECK > 0 | Capacidad volumétrica |
| consumo_km_litro | DECIMAL(10,2) | CHECK > 0 | Rendimiento |
| estado_operativo | VARCHAR(30) | CHECK | Disponible, en ruta, mantenimiento o inactivo |

## conductores

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_conductor | SERIAL | PK | Identificador del conductor |
| nombre | VARCHAR(120) | NOT NULL | Nombre completo |
| licencia | VARCHAR(50) | UNIQUE, NOT NULL | Licencia de conducir |
| telefono | VARCHAR(30) | NULL | Contacto |
| estado | VARCHAR(30) | CHECK | Disponibilidad operativa |

## pedidos

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_pedido | SERIAL | PK | Identificador del pedido |
| id_cliente | INT | FK, NOT NULL | Cliente solicitante |
| id_direccion | INT | FK, NOT NULL | Dirección de entrega |
| codigo_seguimiento | VARCHAR(40) | UNIQUE, NOT NULL | Código para consulta del cliente |
| fecha_creacion | TIMESTAMP | DEFAULT | Fecha de registro |
| fecha_entrega_estimada | TIMESTAMP | NOT NULL | Fecha comprometida |
| estado_actual | VARCHAR(30) | CHECK | Estado operativo del pedido |
| volumen | DECIMAL(10,2) | CHECK > 0 | Volumen del pedido |
| peso | DECIMAL(10,2) | CHECK > 0 | Peso del pedido |
| prioridad | VARCHAR(20) | CHECK | Baja, media, alta o urgente |

## pedido_estados

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_estado | SERIAL | PK | Identificador del estado |
| id_pedido | INT | FK, NOT NULL | Pedido relacionado |
| id_usuario | INT | FK | Usuario que registra el cambio |
| estado | VARCHAR(30) | CHECK | Estado registrado |
| fecha_hora | TIMESTAMP | DEFAULT | Fecha y hora del cambio |
| observacion | VARCHAR(255) | NULL | Comentario operativo |

## rutas

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_ruta | SERIAL | PK | Identificador de ruta |
| id_vehiculo | INT | FK, NOT NULL | Vehículo asignado |
| id_conductor | INT | FK, NOT NULL | Conductor asignado |
| fecha_planificada | DATE | NOT NULL | Fecha de ejecución |
| estado | VARCHAR(30) | CHECK | Propuesta, confirmada, en ruta, finalizada o cancelada |
| distancia_estimada_km | DECIMAL(10,2) | CHECK >= 0 | Distancia estimada |
| costo_estimado | DECIMAL(12,2) | CHECK >= 0 | Costo estimado |
| tiempo_estimado_min | DECIMAL(10,2) | CHECK >= 0 | Tiempo estimado |

## ruta_pedidos

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_ruta_pedido | SERIAL | PK | Identificador |
| id_ruta | INT | FK, NOT NULL | Ruta asociada |
| id_pedido | INT | FK, NOT NULL | Pedido asignado |
| orden_entrega | INT | CHECK > 0 | Orden de entrega |
| distancia_parcial_km | DECIMAL(10,2) | CHECK >= 0 | Distancia parcial |

## ubicaciones_vehiculo

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_ubicacion | SERIAL | PK | Identificador |
| id_vehiculo | INT | FK, NOT NULL | Vehículo reportado |
| fecha_hora | TIMESTAMP | DEFAULT | Fecha de reporte |
| latitud | DECIMAL(10,7) | CHECK | Latitud |
| longitud | DECIMAL(10,7) | CHECK | Longitud |

## incidencias

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_incidencia | SERIAL | PK | Identificador |
| id_ruta | INT | FK, NOT NULL | Ruta afectada |
| id_pedido | INT | FK | Pedido afectado |
| tipo | VARCHAR(40) | NOT NULL | Tipo de incidencia |
| descripcion | VARCHAR(255) | NOT NULL | Detalle |
| severidad | VARCHAR(20) | CHECK | Baja, media, alta o crítica |
| fecha_hora | TIMESTAMP | DEFAULT | Fecha del evento |

## alertas

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_alerta | SERIAL | PK | Identificador |
| id_ruta | INT | FK | Ruta asociada |
| id_pedido | INT | FK | Pedido asociado |
| tipo | VARCHAR(40) | NOT NULL | Tipo de alerta |
| mensaje | VARCHAR(255) | NOT NULL | Mensaje |
| nivel | VARCHAR(20) | CHECK | Nivel de alerta |
| atendida | BOOLEAN | DEFAULT FALSE | Estado de atención |
| fecha_hora | TIMESTAMP | DEFAULT | Fecha de generación |

## kpi_operativos

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_kpi | SERIAL | PK | Identificador |
| id_ruta | INT | FK | Ruta evaluada |
| id_conductor | INT | FK | Conductor evaluado |
| fecha_calculo | DATE | DEFAULT | Fecha de cálculo |
| entregas_tardias_porcentaje | DECIMAL(5,2) | CHECK 0-100 | Porcentaje de retrasos |
| costo_promedio_ruta | DECIMAL(12,2) | CHECK >= 0 | Costo promedio |
| puntualidad_conductor | DECIMAL(5,2) | CHECK 0-100 | Indicador de puntualidad |
