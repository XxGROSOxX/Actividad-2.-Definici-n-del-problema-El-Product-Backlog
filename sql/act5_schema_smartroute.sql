-- Actividad 5 - Arquitectura de Persistencia
-- Proyecto: SmartRoute / FlashRoute DSS
-- DBMS sugerido: PostgreSQL

DROP TABLE IF EXISTS kpi_operativos CASCADE;
DROP TABLE IF EXISTS alertas CASCADE;
DROP TABLE IF EXISTS incidencias CASCADE;
DROP TABLE IF EXISTS ubicaciones_vehiculo CASCADE;
DROP TABLE IF EXISTS ruta_pedidos CASCADE;
DROP TABLE IF EXISTS rutas CASCADE;
DROP TABLE IF EXISTS pedido_estados CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS direcciones CASCADE;
DROP TABLE IF EXISTS conductores CASCADE;
DROP TABLE IF EXISTS vehiculos CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    razon_social VARCHAR(120) NOT NULL,
    nit VARCHAR(30) UNIQUE,
    telefono VARCHAR(30),
    email VARCHAR(120),
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE direcciones (
    id_direccion SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    ciudad VARCHAR(80) NOT NULL,
    zona VARCHAR(80),
    calle VARCHAR(150) NOT NULL,
    latitud DECIMAL(10,7),
    longitud DECIMAL(10,7),
    CONSTRAINT fk_direccion_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE CASCADE,
    CONSTRAINT chk_latitud CHECK (latitud IS NULL OR latitud BETWEEN -90 AND 90),
    CONSTRAINT chk_longitud CHECK (longitud IS NULL OR longitud BETWEEN -180 AND 180)
);

CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(30) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_rol_usuario CHECK (rol IN ('ADMIN', 'GERENTE', 'DESPACHADOR', 'CONDUCTOR'))
);

CREATE TABLE vehiculos (
    id_vehiculo SERIAL PRIMARY KEY,
    placa VARCHAR(20) NOT NULL UNIQUE,
    modelo VARCHAR(80) NOT NULL,
    capacidad_kg DECIMAL(10,2) NOT NULL,
    capacidad_volumen DECIMAL(10,2) NOT NULL,
    consumo_km_litro DECIMAL(10,2) NOT NULL,
    estado_operativo VARCHAR(30) NOT NULL DEFAULT 'DISPONIBLE',
    CONSTRAINT chk_capacidad_kg CHECK (capacidad_kg > 0),
    CONSTRAINT chk_capacidad_volumen CHECK (capacidad_volumen > 0),
    CONSTRAINT chk_consumo CHECK (consumo_km_litro > 0),
    CONSTRAINT chk_estado_vehiculo CHECK (estado_operativo IN ('DISPONIBLE', 'EN_RUTA', 'MANTENIMIENTO', 'INACTIVO'))
);

CREATE TABLE conductores (
    id_conductor SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    licencia VARCHAR(50) NOT NULL UNIQUE,
    telefono VARCHAR(30),
    estado VARCHAR(30) NOT NULL DEFAULT 'DISPONIBLE',
    CONSTRAINT chk_estado_conductor CHECK (estado IN ('DISPONIBLE', 'EN_RUTA', 'DESCANSO', 'INACTIVO'))
);

CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_direccion INT NOT NULL,
    codigo_seguimiento VARCHAR(40) NOT NULL UNIQUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_entrega_estimada TIMESTAMP NOT NULL,
    estado_actual VARCHAR(30) NOT NULL DEFAULT 'PENDIENTE',
    volumen DECIMAL(10,2) NOT NULL,
    peso DECIMAL(10,2) NOT NULL,
    prioridad VARCHAR(20) NOT NULL DEFAULT 'MEDIA',
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_pedido_direccion
        FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion),
    CONSTRAINT chk_pedido_volumen CHECK (volumen > 0),
    CONSTRAINT chk_pedido_peso CHECK (peso > 0),
    CONSTRAINT chk_pedido_prioridad CHECK (prioridad IN ('BAJA', 'MEDIA', 'ALTA', 'URGENTE')),
    CONSTRAINT chk_pedido_estado CHECK (estado_actual IN ('PENDIENTE', 'PLANIFICADO', 'EN_RUTA', 'ENTREGADO', 'RETRASADO', 'NO_ENTREGADO', 'CANCELADO'))
);

CREATE TABLE pedido_estados (
    id_estado SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_usuario INT,
    estado VARCHAR(30) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacion VARCHAR(255),
    CONSTRAINT fk_estado_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE,
    CONSTRAINT fk_estado_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT chk_estado_historial CHECK (estado IN ('PENDIENTE', 'PLANIFICADO', 'EN_RUTA', 'ENTREGADO', 'RETRASADO', 'NO_ENTREGADO', 'CANCELADO'))
);

CREATE TABLE rutas (
    id_ruta SERIAL PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    id_conductor INT NOT NULL,
    fecha_planificada DATE NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'PROPUESTA',
    distancia_estimada_km DECIMAL(10,2) NOT NULL DEFAULT 0,
    costo_estimado DECIMAL(12,2) NOT NULL DEFAULT 0,
    tiempo_estimado_min DECIMAL(10,2) NOT NULL DEFAULT 0,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ruta_vehiculo
        FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
    CONSTRAINT fk_ruta_conductor
        FOREIGN KEY (id_conductor) REFERENCES conductores(id_conductor),
    CONSTRAINT chk_ruta_estado CHECK (estado IN ('PROPUESTA', 'CONFIRMADA', 'EN_RUTA', 'FINALIZADA', 'CANCELADA')),
    CONSTRAINT chk_ruta_distancia CHECK (distancia_estimada_km >= 0),
    CONSTRAINT chk_ruta_costo CHECK (costo_estimado >= 0),
    CONSTRAINT chk_ruta_tiempo CHECK (tiempo_estimado_min >= 0)
);

CREATE TABLE ruta_pedidos (
    id_ruta_pedido SERIAL PRIMARY KEY,
    id_ruta INT NOT NULL,
    id_pedido INT NOT NULL,
    orden_entrega INT NOT NULL,
    distancia_parcial_km DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_ruta_pedido_ruta
        FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta)
        ON DELETE CASCADE,
    CONSTRAINT fk_ruta_pedido_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    CONSTRAINT uq_ruta_pedido UNIQUE (id_ruta, id_pedido),
    CONSTRAINT uq_ruta_orden UNIQUE (id_ruta, orden_entrega),
    CONSTRAINT chk_orden_entrega CHECK (orden_entrega > 0),
    CONSTRAINT chk_distancia_parcial CHECK (distancia_parcial_km >= 0)
);

CREATE TABLE ubicaciones_vehiculo (
    id_ubicacion SERIAL PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    latitud DECIMAL(10,7) NOT NULL,
    longitud DECIMAL(10,7) NOT NULL,
    CONSTRAINT fk_ubicacion_vehiculo
        FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
        ON DELETE CASCADE,
    CONSTRAINT chk_ubicacion_latitud CHECK (latitud BETWEEN -90 AND 90),
    CONSTRAINT chk_ubicacion_longitud CHECK (longitud BETWEEN -180 AND 180)
);

CREATE TABLE incidencias (
    id_incidencia SERIAL PRIMARY KEY,
    id_ruta INT NOT NULL,
    id_pedido INT,
    tipo VARCHAR(40) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    severidad VARCHAR(20) NOT NULL DEFAULT 'MEDIA',
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_incidencia_ruta
        FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta)
        ON DELETE CASCADE,
    CONSTRAINT fk_incidencia_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    CONSTRAINT chk_incidencia_severidad CHECK (severidad IN ('BAJA', 'MEDIA', 'ALTA', 'CRITICA'))
);

CREATE TABLE alertas (
    id_alerta SERIAL PRIMARY KEY,
    id_ruta INT,
    id_pedido INT,
    tipo VARCHAR(40) NOT NULL,
    mensaje VARCHAR(255) NOT NULL,
    nivel VARCHAR(20) NOT NULL DEFAULT 'MEDIA',
    atendida BOOLEAN NOT NULL DEFAULT FALSE,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_alerta_ruta
        FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta)
        ON DELETE CASCADE,
    CONSTRAINT fk_alerta_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    CONSTRAINT chk_alerta_nivel CHECK (nivel IN ('BAJA', 'MEDIA', 'ALTA', 'CRITICA'))
);

CREATE TABLE kpi_operativos (
    id_kpi SERIAL PRIMARY KEY,
    id_ruta INT,
    id_conductor INT,
    fecha_calculo DATE NOT NULL DEFAULT CURRENT_DATE,
    entregas_tardias_porcentaje DECIMAL(5,2) NOT NULL DEFAULT 0,
    costo_promedio_ruta DECIMAL(12,2) NOT NULL DEFAULT 0,
    puntualidad_conductor DECIMAL(5,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_kpi_ruta
        FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta)
        ON DELETE SET NULL,
    CONSTRAINT fk_kpi_conductor
        FOREIGN KEY (id_conductor) REFERENCES conductores(id_conductor)
        ON DELETE SET NULL,
    CONSTRAINT chk_kpi_entregas_tardias CHECK (entregas_tardias_porcentaje BETWEEN 0 AND 100),
    CONSTRAINT chk_kpi_puntualidad CHECK (puntualidad_conductor BETWEEN 0 AND 100),
    CONSTRAINT chk_kpi_costo CHECK (costo_promedio_ruta >= 0)
);

CREATE INDEX idx_pedidos_estado ON pedidos(estado_actual);
CREATE INDEX idx_pedidos_codigo ON pedidos(codigo_seguimiento);
CREATE INDEX idx_rutas_fecha ON rutas(fecha_planificada);
CREATE INDEX idx_ruta_pedidos_ruta ON ruta_pedidos(id_ruta);
CREATE INDEX idx_ubicacion_vehiculo_fecha ON ubicaciones_vehiculo(id_vehiculo, fecha_hora);
CREATE INDEX idx_alertas_atendida ON alertas(atendida);
CREATE INDEX idx_kpi_fecha ON kpi_operativos(fecha_calculo);
