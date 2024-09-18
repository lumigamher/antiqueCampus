-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS antiguedades_campuslands;
USE antiguedades_campuslands;

-- Tabla de Usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Tipos de Usuario
CREATE TABLE tipos_usuario (
    id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de Relación Usuario-Tipo
CREATE TABLE usuario_tipo (
    id_usuario INT,
    id_tipo_usuario INT,
    PRIMARY KEY (id_usuario, id_tipo_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_tipo_usuario) REFERENCES tipos_usuario(id_tipo_usuario)
);

-- Tabla de Categorías
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de Épocas
CREATE TABLE epocas (
    id_epoca INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de Estados de Conservación
CREATE TABLE estados_conservacion (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de Antigüedades
CREATE TABLE antiguedades (
    id_antiguedad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_categoria INT,
    id_epoca INT,
    id_estado_conservacion INT,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_epoca) REFERENCES epocas(id_epoca),
    FOREIGN KEY (id_estado_conservacion) REFERENCES estados_conservacion(id_estado)
);

-- Tabla de Estados de Antigüedad
CREATE TABLE estados_antiguedad (
    id_estado_antiguedad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de Relación Antigüedad-Estado
CREATE TABLE antiguedad_estado (
    id_antiguedad INT,
    id_estado_antiguedad INT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_antiguedad, id_estado_antiguedad, fecha_cambio),
    FOREIGN KEY (id_antiguedad) REFERENCES antiguedades(id_antiguedad),
    FOREIGN KEY (id_estado_antiguedad) REFERENCES estados_antiguedad(id_estado_antiguedad)
);

-- Tabla de Fotos de Antigüedades
CREATE TABLE fotos_antiguedades (
    id_foto INT AUTO_INCREMENT PRIMARY KEY,
    id_antiguedad INT,
    url_foto VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_antiguedad) REFERENCES antiguedades(id_antiguedad)
);

-- Tabla de Propietarios de Antigüedades
CREATE TABLE propietarios_antiguedades (
    id_antiguedad INT,
    id_propietario INT,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP NULL,
    PRIMARY KEY (id_antiguedad, id_propietario, fecha_inicio),
    FOREIGN KEY (id_antiguedad) REFERENCES antiguedades(id_antiguedad),
    FOREIGN KEY (id_propietario) REFERENCES usuarios(id_usuario)
);

-- Tabla de Precios de Antigüedades
CREATE TABLE precios_antiguedades (
    id_antiguedad INT,
    precio DECIMAL(10, 2) NOT NULL,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP NULL,
    PRIMARY KEY (id_antiguedad, fecha_inicio),
    FOREIGN KEY (id_antiguedad) REFERENCES antiguedades(id_antiguedad)
);

-- Tabla de Transacciones
CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_antiguedad INT,
    id_vendedor INT,
    id_comprador INT,
    precio_venta DECIMAL(10, 2) NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_antiguedad) REFERENCES antiguedades(id_antiguedad),
    FOREIGN KEY (id_vendedor) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_comprador) REFERENCES usuarios(id_usuario)
);

-- Tabla de Estados de Entrega
CREATE TABLE estados_entrega (
    id_estado_entrega INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de Relación Transacción-Estado de Entrega
CREATE TABLE transaccion_estado_entrega (
    id_transaccion INT,
    id_estado_entrega INT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_transaccion, id_estado_entrega, fecha_cambio),
    FOREIGN KEY (id_transaccion) REFERENCES transacciones(id_transaccion),
    FOREIGN KEY (id_estado_entrega) REFERENCES estados_entrega(id_estado_entrega)
);

-- Tabla de Visitas a Antigüedades
CREATE TABLE visitas_antiguedades (
    id_visita INT AUTO_INCREMENT PRIMARY KEY,
    id_antiguedad INT,
    id_usuario INT,
    fecha_visita TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_antiguedad) REFERENCES antiguedades(id_antiguedad),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Índices para optimizar las consultas más frecuentes
CREATE INDEX idx_antiguedad_estado ON antiguedad_estado(id_antiguedad, id_estado_antiguedad);
CREATE INDEX idx_propietarios_antiguedades ON propietarios_antiguedades(id_antiguedad, fecha_inicio);
CREATE INDEX idx_precios_antiguedades ON precios_antiguedades(id_antiguedad, fecha_inicio);
CREATE INDEX idx_transacciones_fecha ON transacciones(fecha_venta);
CREATE INDEX idx_visitas_fecha ON visitas_antiguedades(fecha_visita);
