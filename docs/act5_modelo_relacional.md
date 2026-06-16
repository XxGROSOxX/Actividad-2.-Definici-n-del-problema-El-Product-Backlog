# Actividad 5 - Modelo Relacional SmartRoute DSS

```mermaid
erDiagram
    CLIENTES ||--o{ DIRECCIONES : posee
    CLIENTES ||--o{ PEDIDOS : solicita
    DIRECCIONES ||--o{ PEDIDOS : destino
    PEDIDOS ||--o{ PEDIDO_ESTADOS : historial
    VEHICULOS ||--o{ RUTAS : asignado
    CONDUCTORES ||--o{ RUTAS : asignado
    RUTAS ||--o{ RUTA_PEDIDOS : contiene
    PEDIDOS ||--o| RUTA_PEDIDOS : asignado
    VEHICULOS ||--o{ UBICACIONES_VEHICULO : registra
    RUTAS ||--o{ INCIDENCIAS : reporta
    RUTAS ||--o{ ALERTAS : genera
    RUTAS ||--o{ KPI_OPERATIVOS : alimenta
    CONDUCTORES ||--o{ KPI_OPERATIVOS : evalua
    USUARIOS ||--o{ PEDIDO_ESTADOS : registra

    CLIENTES {
        int id_cliente PK
        varchar razon_social
        varchar nit UK
        varchar telefono
        varchar email
    }

    DIRECCIONES {
        int id_direccion PK
        int id_cliente FK
        varchar ciudad
        varchar zona
        varchar calle
        decimal latitud
        decimal longitud
    }

    PEDIDOS {
        int id_pedido PK
        int id_cliente FK
        int id_direccion FK
        varchar codigo_seguimiento UK
        timestamp fecha_creacion
        timestamp fecha_entrega_estimada
        varchar estado_actual
        decimal volumen
        decimal peso
        varchar prioridad
    }

    PEDIDO_ESTADOS {
        int id_estado PK
        int id_pedido FK
        int id_usuario FK
        varchar estado
        timestamp fecha_hora
        varchar observacion
    }

    VEHICULOS {
        int id_vehiculo PK
        varchar placa UK
        varchar modelo
        decimal capacidad_kg
        decimal capacidad_volumen
        decimal consumo_km_litro
        varchar estado_operativo
    }

    CONDUCTORES {
        int id_conductor PK
        varchar nombre
        varchar licencia UK
        varchar telefono
        varchar estado
    }

    RUTAS {
        int id_ruta PK
        int id_vehiculo FK
        int id_conductor FK
        date fecha_planificada
        varchar estado
        decimal distancia_estimada_km
        decimal costo_estimado
        decimal tiempo_estimado_min
    }

    RUTA_PEDIDOS {
        int id_ruta_pedido PK
        int id_ruta FK
        int id_pedido FK
        int orden_entrega
        decimal distancia_parcial_km
    }

    UBICACIONES_VEHICULO {
        int id_ubicacion PK
        int id_vehiculo FK
        timestamp fecha_hora
        decimal latitud
        decimal longitud
    }

    INCIDENCIAS {
        int id_incidencia PK
        int id_ruta FK
        int id_pedido FK
        varchar tipo
        varchar descripcion
        varchar severidad
        timestamp fecha_hora
    }

    ALERTAS {
        int id_alerta PK
        int id_ruta FK
        int id_pedido FK
        varchar tipo
        varchar mensaje
        varchar nivel
        boolean atendida
        timestamp fecha_hora
    }

    KPI_OPERATIVOS {
        int id_kpi PK
        int id_ruta FK
        int id_conductor FK
        date fecha_calculo
        decimal entregas_tardias_porcentaje
        decimal costo_promedio_ruta
        decimal puntualidad_conductor
    }

    USUARIOS {
        int id_usuario PK
        varchar nombre
        varchar email UK
        varchar password_hash
        varchar rol
        boolean activo
    }
