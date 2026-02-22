## Proyecto centinela logistica 
**Integrantes**

- Kely Andrea Barrientos Pino
- Tomas Henao Cardona
- Brayan Zabdiel Leon Mendoza
- Lesly Tatiana Tabares Muñoz

**Descripción**

La arquitectura de este sistema se basa en la trazabilidad total. El diseño parte de una estructura donde el paquete es la entidad central, el cual nace de un Usuario (remitente) y se vincula mediante una relación 1:1 a un Envío. Esta estructura garantiza que cada bulto físico tenga un identificador único e irrepetible en el inventario, facilitando el seguimiento en tiempo real.
En el Diagrama de Chen, visualizamos la lógica del negocio mediante entidades como Sucursales y Vehículos, conectadas por relaciones de cardinalidad 1:N. Esto significa que una sucursal puede gestionar múltiples paquetes en espera y un vehículo puede consolidar diversos envíos en una sola ruta, optimizando el espacio de carga y los tiempos de entrega.
Finalmente, el Modelo Relacional traduce estas conexiones en tablas normalizadas. Mediante el uso de Llaves Primarias (PK) y Foráneas (FK), aseguramos la integridad referencial; por ejemplo, no se puede registrar un envío si el vehículo o la sucursal de destino no existen previamente en la base de datos. Esta normalización evita la redundancia de datos y permite consultas ágiles para reportes de inventario y logística.
