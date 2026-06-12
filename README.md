# FlashRoute DSS - MVP para FlashLogistics

> Actividad 02: Formulacion del MVP - De la Raiz a la Solucion  
> Materia: Sistemas de Informacion II  
> Squad: ROBLOX


## Enlace al PDF
https://github.com/XxGROSOxX/Actividad-2.-Definici-n-del-problema-El-Product-Backlog/blob/main/docs/FlashLogistics_MVP_DSS_Actividad_02.pdf


## 1. Vision del producto
Para el gerente de operaciones, despachadores y conductores de FlashLogistics que necesitan planificar y controlar entregas con informacion confiable, **FlashRoute DSS** es una plataforma web/PWA de soporte a decisiones logisticas que optimiza rutas, monitorea pedidos y camiones, y ofrece KPIs operativos. A diferencia de la pizarra, Excel y las llamadas manuales, el producto centraliza datos, alerta desviaciones y recomienda acciones para reducir retrasos, combustible y carga cognitiva.

## 2. Problema central
FlashLogistics enfrenta una crisis operativa: baja confiabilidad, altos costos y perdida de control sobre la distribucion. El caso reporta 30% de entregas tardias, incremento de combustible de 15%, cancelacion de contratos por falta de informacion y 4 horas diarias de despachadores dedicadas a llamadas de seguimiento.

## 3. Objetivo SMART
En un plazo de **12 semanas**, desarrollar e implementar un MVP de DSS logistico para FlashLogistics que automatice la planificacion basica de rutas, proporcione trazabilidad operativa y genere KPIs en tiempo real, con la meta de reducir en al menos **50%** el tiempo de planificacion diaria, disminuir las entregas tardias del **30% al 21%**, reducir en **40%** las llamadas de seguimiento de pedidos y bajar en **8%** el costo de combustible por entrega durante un piloto de **30 dias**.

## 4. Canvas MVP

| Bloque | Definicion |
|---|---|
| Propuesta del MVP | Digitalizar el flujo minimo de distribucion: pedidos, rutas, recursos, estados, seguimiento y KPIs. |
| Personas atendidas | Gerente de Operaciones, despachadores, conductores y clientes corporativos. |
| Viajes atendidos | Planificar rutas, ejecutar entregas, consultar estado, gestionar incidencias y cerrar el dia con KPIs. |
| Funcionalidades minimas | Gestion de pedidos/flota/conductores; planificador de rutas; PWA conductor; portal de seguimiento; dashboard DSS; alertas. |
| Resultado esperado | Planificacion -50%, entregas tardias 30% -> 21%, llamadas -40%, combustible por entrega -8%. |
| Costo y cronograma | 4 sprints de 2 semanas + 2 semanas de piloto y estabilizacion. |

## 5. Es - No es - Hace - No hace

| ES | NO ES |
|---|---|
| Un DSS logistico modular para planificacion, trazabilidad y control operativo. | No es un ERP, sistema contable, sistema de mantenimiento mecanico ni TMS corporativo final. |

| HACE | NO HACE |
|---|---|
| Carga pedidos, sugiere rutas, asigna conductores, actualiza estados, muestra seguimiento y KPIs. | No repara vehiculos, no reemplaza decisiones legales/comerciales y no implementa IA avanzada en el primer MVP. |

## 6. Backlog inicial

| Codigo | Historia / Epica | Sprint |
|---|---|---|
| EPIC-01 | Modelo de datos de pedidos, conductores, vehiculos y rutas. | Sprint 1 |
| EPIC-02 | Planificador basico de rutas por zona, prioridad y capacidad. | Sprint 2 |
| EPIC-03 | PWA del conductor para actualizacion de estados. | Sprint 3 |
| EPIC-04 | Portal de seguimiento para clientes. | Sprint 3 |
| EPIC-05 | Dashboard DSS con KPIs y alertas. | Sprint 4 |
| EPIC-06 | Piloto, medicion de KPIs y ajuste de reglas. | Piloto |

## 7. GitHub Projects
Configurar un tablero Kanban con las siguientes columnas:

- Backlog
- Ready
- In Progress
- Review
- Done

Cada item del Canvas MVP debe convertirse en issue o historia de usuario para mantener trazabilidad entre vision, MVP y ejecucion tecnica.

## 8. Estructura sugerida

```text
flashlogistics-dss-mvp/
├── docs/
│   ├── arbol-problemas.png
│   ├── arbol-soluciones.png
│   └── actividad-02-flashlogistics.pdf
├── src/
│   ├── frontend/
│   └── backend/
├── .github/
│   └── ISSUE_TEMPLATE/
└── README.md
```
