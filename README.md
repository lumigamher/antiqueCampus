# antiqueCampus

# Documentación de la Base de Datos Antigüedades CampusLands

## Visión General

Esta base de datos está diseñada para gestionar un negocio de antigüedades, permitiendo a los usuarios listar, vender y comprar piezas antiguas. La base de datos está altamente normalizada para minimizar la redundancia de datos y mejorar la integridad de la información.

## Estructura de la Base de Datos

### 1. Usuarios y Roles

#### Tabla: `usuarios`
- Propósito: Almacena la información básica de todos los usuarios del sistema.
- Campos:
  - `id_usuario` (PK): Identificador único del usuario.
  - `nombre`: Nombre completo del usuario.
  - `email`: Correo electrónico del usuario (único).
  - `contrasena`: Contraseña encriptada del usuario.
  - `fecha_registro`: Fecha y hora de registro del usuario.

#### Tabla: `tipos_usuario`
- Propósito: Define los diferentes tipos de roles que un usuario puede tener.
- Campos:
  - `id_tipo_usuario` (PK): Identificador único del tipo de usuario.
  - `nombre`: Nombre del tipo de usuario (ej. vendedor, comprador, administrador).

#### Tabla: `usuario_tipo`
- Propósito: Relaciona usuarios con sus tipos, permitiendo que un usuario tenga múltiples roles.
- Campos:
  - `id_usuario` (PK, FK): Referencia a `usuarios`.
  - `id_tipo_usuario` (PK, FK): Referencia a `tipos_usuario`.

### 2. Antigüedades y Características

#### Tabla: `categorias`
- Propósito: Define las categorías de las antigüedades.
- Campos:
  - `id_categoria` (PK): Identificador único de la categoría.
  - `nombre`: Nombre de la categoría.

#### Tabla: `epocas`
- Propósito: Define las épocas históricas de las antigüedades.
- Campos:
  - `id_epoca` (PK): Identificador único de la época.
  - `nombre`: Nombre de la época.

#### Tabla: `estados_conservacion`
- Propósito: Define los posibles estados de conservación de las antigüedades.
- Campos:
  - `id_estado` (PK): Identificador único del estado de conservación.
  - `nombre`: Descripción del estado de conservación.

#### Tabla: `antiguedades`
- Propósito: Almacena la información principal de cada antigüedad.
- Campos:
  - `id_antiguedad` (PK): Identificador único de la antigüedad.
  - `nombre`: Nombre o título de la antigüedad.
  - `descripcion`: Descripción detallada de la antigüedad.
  - `id_categoria` (FK): Referencia a `categorias`.
  - `id_epoca` (FK): Referencia a `epocas`.
  - `id_estado_conservacion` (FK): Referencia a `estados_conservacion`.
  - `fecha_publicacion`: Fecha y hora de publicación de la antigüedad.

#### Tabla: `estados_antiguedad`
- Propósito: Define los posibles estados de una antigüedad en el sistema (ej. en venta, vendido, retirado).
- Campos:
  - `id_estado_antiguedad` (PK): Identificador único del estado.
  - `nombre`: Nombre del estado.

#### Tabla: `antiguedad_estado`
- Propósito: Registra los cambios de estado de las antigüedades a lo largo del tiempo.
- Campos:
  - `id_antiguedad` (PK, FK): Referencia a `antiguedades`.
  - `id_estado_antiguedad` (PK, FK): Referencia a `estados_antiguedad`.
  - `fecha_cambio` (PK): Fecha y hora del cambio de estado.

#### Tabla: `fotos_antiguedades`
- Propósito: Almacena las URLs de las fotos de las antigüedades.
- Campos:
  - `id_foto` (PK): Identificador único de la foto.
  - `id_antiguedad` (FK): Referencia a `antiguedades`.
  - `url_foto`: URL de la foto.

### 3. Propietarios y Precios

#### Tabla: `propietarios_antiguedades`
- Propósito: Registra el historial de propietarios de cada antigüedad.
- Campos:
  - `id_antiguedad` (PK, FK): Referencia a `antiguedades`.
  - `id_propietario` (PK, FK): Referencia a `usuarios`.
  - `fecha_inicio` (PK): Fecha de inicio de la propiedad.
  - `fecha_fin`: Fecha de fin de la propiedad (NULL si es el propietario actual).

#### Tabla: `precios_antiguedades`
- Propósito: Registra el historial de precios de cada antigüedad.
- Campos:
  - `id_antiguedad` (PK, FK): Referencia a `antiguedades`.
  - `precio`: Precio de la antigüedad.
  - `fecha_inicio` (PK): Fecha de inicio de vigencia del precio.
  - `fecha_fin`: Fecha de fin de vigencia del precio (NULL si es el precio actual).

### 4. Transacciones y Entregas

#### Tabla: `transacciones`
- Propósito: Registra todas las transacciones de compra/venta.
- Campos:
  - `id_transaccion` (PK): Identificador único de la transacción.
  - `id_antiguedad` (FK): Referencia a `antiguedades`.
  - `id_vendedor` (FK): Referencia a `usuarios` (vendedor).
  - `id_comprador` (FK): Referencia a `usuarios` (comprador).
  - `precio_venta`: Precio final de venta.
  - `fecha_venta`: Fecha y hora de la transacción.

#### Tabla: `estados_entrega`
- Propósito: Define los posibles estados de entrega de una transacción.
- Campos:
  - `id_estado_entrega` (PK): Identificador único del estado de entrega.
  - `nombre`: Nombre del estado de entrega.

#### Tabla: `transaccion_estado_entrega`
- Propósito: Registra los cambios de estado de entrega de las transacciones.
- Campos:
  - `id_transaccion` (PK, FK): Referencia a `transacciones`.
  - `id_estado_entrega` (PK, FK): Referencia a `estados_entrega`.
  - `fecha_cambio` (PK): Fecha y hora del cambio de estado de entrega.

### 5. Actividad de Usuarios

#### Tabla: `visitas_antiguedades`
- Propósito: Registra las visitas de los usuarios a las páginas de las antigüedades.
- Campos:
  - `id_visita` (PK): Identificador único de la visita.
  - `id_antiguedad` (FK): Referencia a `antiguedades`.
  - `id_usuario` (FK): Referencia a `usuarios`.
  - `fecha_visita`: Fecha y hora de la visita.

## Consideraciones de Diseño

1. **Alta Normalización**: La base de datos está diseñada para alcanzar la Quinta Forma Normal (5NF) en la mayoría de sus aspectos, lo que minimiza la redundancia de datos y mejora la integridad de la información.

2. **Historial Temporal**: Se utilizan tablas separadas para rastrear cambios a lo largo del tiempo (ej. propietarios, precios, estados) permitiendo un seguimiento detallado del historial de cada antigüedad.

3. **Flexibilidad de Roles**: La estructura `usuario_tipo` permite que los usuarios tengan múltiples roles, proporcionando flexibilidad en la gestión de permisos.

4. **Escalabilidad**: El diseño permite fácilmente añadir nuevas categorías, épocas, estados, etc., sin necesidad de modificar la estructura de las tablas principales.

5. **Optimización de Consultas**: Los índices creados están diseñados para mejorar el rendimiento de las consultas más comunes, como búsquedas por estado de antigüedad, fechas de transacciones y visitas.

