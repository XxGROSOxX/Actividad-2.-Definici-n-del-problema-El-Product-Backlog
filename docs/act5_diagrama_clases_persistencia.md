# Actividad 5 - Diagrama de Clases de Persistencia

```mermaid
classDiagram
    class Cliente {
        -int idCliente
        -string razonSocial
        -string nit
        -string telefono
        -string email
        +registrarCliente()
        +actualizarDatos()
    }

    class Direccion {
        -int idDireccion
        -string ciudad
        -string zona
        -string calle
        -decimal latitud
        -decimal longitud
        +validarCoordenadas()
    }

    class Pedido {
        -int idPedido
        -string codigoSeguimiento
        -date fechaCreacion
        -date fechaEntregaEstimada
        -string estadoActual
        -decimal volumen
        -decimal peso
        -string prioridad
        +generarCodigoSeguimiento()
        +cambiarEstado()
        +calcularRetraso()
    }

    class PedidoEstado {
        -int idEstado
        -string estado
        -datetime fechaHora
        -string observacion
        +registrarEstado()
    }

    class Vehiculo {
        -int idVehiculo
        -string placa
        -string modelo
        -decimal capacidadKg
        -decimal capacidadVolumen
        -decimal consumoKmLitro
        -string estadoOperativo
        +validarDisponibilidad()
        +calcularConsumoEstimado()
    }

    class Conductor {
        -int idConductor
        -string nombre
        -string licencia
        -string telefono
        -string estado
        +validarDisponibilidad()
        +calcularPuntualidad()
    }

    class Ruta {
        -int idRuta
        -date fechaPlanificada
        -string estado
        -decimal distanciaEstimadaKm
        -decimal costoEstimado
        -decimal tiempoEstimadoMin
        +calcularCosto()
        +asignarVehiculo()
        +confirmarRuta()
        +evaluarRentabilidad()
    }

    class RutaPedido {
        -int idRutaPedido
        -int ordenEntrega
        -decimal distanciaParcialKm
        +actualizarOrden()
    }

    class UbicacionVehiculo {
        -int idUbicacion
        -datetime fechaHora
        -decimal latitud
        -decimal longitud
        +registrarUbicacion()
    }

    class Incidencia {
        -int idIncidencia
        -string tipo
        -string descripcion
        -datetime fechaHora
        -string severidad
        +registrarIncidencia()
    }

    class Alerta {
        -int idAlerta
        -string tipo
        -string mensaje
        -string nivel
        -datetime fechaHora
        -boolean atendida
        +generarAlerta()
        +marcarAtendida()
    }

    class KpiOperativo {
        -int idKpi
        -date fechaCalculo
        -decimal entregasTardiasPorcentaje
        -decimal costoPromedioRuta
        -decimal puntualidadConductor
        +calcularKPIs()
        +generarReporte()
    }

    class Usuario {
        -int idUsuario
        -string nombre
        -string email
        -string passwordHash
        -string rol
        +autenticar()
        +validarPermiso()
    }

    Cliente "1" *-- "1..*" Direccion : posee
    Cliente "1" --> "0..*" Pedido : solicita
    Direccion "1" --> "0..*" Pedido : destino
    Pedido "1" *-- "1..*" PedidoEstado : historial
    Ruta "1" o-- "1..*" RutaPedido : agrupa
    Pedido "1" --> "0..1" RutaPedido : asignado
    Ruta "1" --> "1" Vehiculo : usa
    Ruta "1" --> "1" Conductor : asigna
    Vehiculo "1" *-- "0..*" UbicacionVehiculo : registra
    Ruta "1" --> "0..*" Incidencia : reporta
    Ruta "1" --> "0..*" Alerta : genera
    Ruta "1" --> "0..*" KpiOperativo : alimenta
    Conductor "1" --> "0..*" KpiOperativo : evalua
    Usuario "1" --> "0..*" PedidoEstado : registra
