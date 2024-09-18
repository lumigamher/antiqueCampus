-- Insertar datos de prueba

-- Insertar usuarios
INSERT INTO usuarios (nombre, email, contrasena) VALUES 
('Luis Miguel', 'luismiguel@example.com', 'password1'),
('Laura Hernández', 'laura@example.com', 'password2'),
('Pedro Gomez', 'pedro@example.com', 'password3');

-- Insertar tipos de usuario
INSERT INTO tipos_usuario (nombre) VALUES 
('Admin'),
('Usuario Regular');

-- Relación usuario-tipo
INSERT INTO usuario_tipo (id_usuario, id_tipo_usuario) VALUES 
(1, 1),
(2, 2),
(3, 2);

-- Insertar categorías
INSERT INTO categorias (nombre) VALUES 
('Muebles'),
('Joyería'),
('Arte');

-- Insertar épocas
INSERT INTO epocas (nombre) VALUES 
('Renacimiento'),
('Barroco'),
('Edad Moderna');

-- Insertar estados de conservación
INSERT INTO estados_conservacion (nombre) VALUES 
('Excelente'),
('Bueno'),
('Regular');

-- Insertar antigüedades
INSERT INTO antiguedades (nombre, descripcion, id_categoria, id_epoca, id_estado_conservacion) VALUES 
('Silla Victoriana', 'Silla antigua de estilo victoriano', 1, 2, 1),
('Anillo de oro', 'Anillo de oro del renacimiento', 2, 1, 2),
('Pintura barroca', 'Pintura antigua del periodo barroco', 3, 2, 1);

-- Insertar estados de antigüedad
INSERT INTO estados_antiguedad (nombre) VALUES 
('Disponible'),
('Vendido');

-- Insertar relación antigüedad-estado
INSERT INTO antiguedad_estado (id_antiguedad, id_estado_antiguedad) VALUES 
(1, 1),
(2, 1),
(3, 1);

-- Insertar fotos de antigüedades
INSERT INTO fotos_antiguedades (id_antiguedad, url_foto) VALUES 
(1, 'https://example.com/silla.jpg'),
(2, 'https://example.com/anillo.jpg'),
(3, 'https://example.com/pintura.jpg');

-- Insertar propietarios de antigüedades
INSERT INTO propietarios_antiguedades (id_antiguedad, id_propietario) VALUES 
(1, 1),
(2, 2),
(3, 3);

-- Insertar precios de antigüedades
INSERT INTO precios_antiguedades (id_antiguedad, precio) VALUES 
(1, 5000.00),
(2, 3000.00),
(3, 8000.00);

-- Insertar transacciones
INSERT INTO transacciones (id_antiguedad, id_vendedor, id_comprador, precio_venta) VALUES 
(1, 1, 2, 5000.00),
(2, 2, 3, 3000.00);

-- Insertar estados de entrega
INSERT INTO estados_entrega (nombre) VALUES 
('En proceso'),
('Entregado');

-- Relación transacción-estado de entrega
INSERT INTO transaccion_estado_entrega (id_transaccion, id_estado_entrega) VALUES 
(1, 1),
(2, 2);

-- Insertar visitas a antigüedades
INSERT INTO visitas_antiguedades (id_antiguedad, id_usuario) VALUES 
(1, 2),
(2, 3),
(3, 1);
