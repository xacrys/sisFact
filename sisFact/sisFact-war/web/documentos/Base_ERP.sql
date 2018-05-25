CREATE SEQUENCE erp.impuesto_seq;

CREATE TABLE IF NOT EXISTS erp.impuesto (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.impuesto_seq'),
  nombre VARCHAR(64) NOT NULL,
  cantidad DOUBLE PRECISION NOT NULL,
  porcentaje DOUBLE PRECISION NOT NULL,
  tipo_impuesto VARCHAR(40) NOT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id));
  
  CREATE SEQUENCE erp.cuenta_seq;

  CREATE TABLE IF NOT EXISTS erp.cuenta (

  id INT NOT NULL DEFAULT NEXTVAL ('erp.cuenta_seq'),
  nombre VARCHAR(256) NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  tipo VARCHAR(64) NOT NULL,
  codigo VARCHAR(64) NOT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id));
    

    
CREATE SEQUENCE erp.producto_categoria_seq;

CREATE TABLE IF NOT EXISTS erp.producto_categoria (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.producto_categoria_seq'),
  nombre VARCHAR(40) NOT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id));

  
    
CREATE SEQUENCE erp.usuario_seq;

CREATE TABLE IF NOT EXISTS erp.usuario (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.usuario_seq'),
  login VARCHAR(64) NOT NULL,
  contrasena VARCHAR(64) NOT NULL,
  nombre VARCHAR(64) NOT NULL,
  tipo_usuario VARCHAR(64) NULL,
  imagen bytea NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id));


 CREATE SEQUENCE erp.producto_uom_categoria_seq;

 CREATE TABLE IF NOT EXISTS erp.producto_uom_categoria (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.producto_uom_categoria_seq'),
  nombre VARCHAR(64) NOT NULL,
  
  PRIMARY KEY (id));


  CREATE SEQUENCE erp.producto_uom_seq;

  CREATE TABLE IF NOT EXISTS erp.producto_uom (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.producto_uom_seq'),
  nombre VARCHAR(64) NOT NULL,
  decimales INT NOT NULL,
  categoria_id INT NOT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT producto_uom_categoria_id_fkey 
    FOREIGN KEY (categoria_id) 
    REFERENCES erp.producto_uom_categoria(id));



CREATE SEQUENCE erp.producto_seq;

CREATE TABLE IF NOT EXISTS erp.producto (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.producto_seq'),
  imagen bytea NULL,
  defecto_codigo VARCHAR(64) NULL,
  nombre VARCHAR(128) NOT NULL,
  tamano_imagen bytea NULL,
  precio_venta DOUBLE PRECISION NULL default 0, 
  precio_compra DOUBLE PRECISION NULL default 0,
  descripcion VARCHAR(128) NULL,
  peso DOUBLE PRECISION NULL,
  volumen DOUBLE PRECISION NULL,
  longitud DOUBLE PRECISION NULL,
  uom_id INT NOT NULL,
  categ_id INT NOT NULL,
  venta_ok SMALLINT NULL,
  compra_ok SMALLINT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT producto_template_categ_id_fkey
    FOREIGN KEY (categ_id)
    REFERENCES erp.producto_categoria (id),
  CONSTRAINT producto_template_uom_id_fkey
    FOREIGN KEY (uom_id)
    REFERENCES erp.producto_uom (id));

    
    
CREATE SEQUENCE erp.socio_seq;

CREATE TABLE IF NOT EXISTS erp.socio (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.socio_seq'),
  fecha_creacion TIMESTAMP(0) NOT NULL,
  nombre VARCHAR(128) NOT NULL,
  imagen bytea NULL,
  ciudad VARCHAR(128) NULL,
  pais VARCHAR(128) NULL,
  calle VARCHAR(128) NULL,
  proveedor SMALLINT NULL,
  cliente SMALLINT NULL,
  correo VARCHAR(64) NULL,
  sitio_web VARCHAR(64) NULL,
  fax VARCHAR(64) NULL,
  telefono VARCHAR(64) NULL,
  credito DOUBLE PRECISION NULL,
  debito DOUBLE PRECISION NULL,
  tamano_imagen bytea NULL,
  celular VARCHAR(64) NULL,
  es_compania SMALLINT NULL,
  ofertas_compra INT NULL default 0,
  ofertas_venta INT NULL default 0,
  activo BOOLEAN NOT NULL default true,
  cuenta_por_cobrar_id INT NOT NULL,
  cuenta_por_pagar_id INT NOT NULL,
  
  PRIMARY KEY (id),
  CONSTRAINT socio_cuenta_por_cobrar_id_fkey
    FOREIGN KEY (cuenta_por_cobrar_id)
    REFERENCES erp.cuenta (id),
  CONSTRAINT socio_cuenta_por_pagar_id_fkey
    FOREIGN KEY (cuenta_por_pagar_id)
    REFERENCES erp.cuenta (id));
    
    
CREATE SEQUENCE erp.orden_venta_seq;

CREATE TABLE IF NOT EXISTS erp.orden_venta (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.orden_venta_seq'),
  fecha TIMESTAMP(0) NOT NULL,
  socio_id INT NOT NULL,
  cantidad_impuesto DOUBLE PRECISION NULL,
  cantidad_total DOUBLE PRECISION NULL,
  cantidad_sinimpuesto DOUBLE PRECISION NULL,
  estado varchar(64) NULL,
  sistema_factura varchar(64) NULL,
  nombre varchar(64) NULL,
  entrega_creada SMALLINT NULL,
  enviado SMALLINT NULL,
  pagado SMALLINT NULL,
  no_pagado DOUBLE PRECISION NULL,
  notas varchar(5000) NULL,
  descuento INT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT orden_venta_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id));
    
  
CREATE SEQUENCE erp.orden_linea_venta_seq;

CREATE TABLE IF NOT EXISTS erp.orden_linea_venta (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.orden_linea_venta_seq'),
  fecha TIMESTAMP(0) NULL,
  uom VARCHAR(60) NOT NULL,
  cantidad DOUBLE PRECISION NOT NULL,
  orden_id INT NOT NULL,
  precio DOUBLE PRECISION NOT NULL,
  sub_total DOUBLE PRECISION NOT NULL,
  descuento DOUBLE PRECISION NOT NULL,
  impuesto_id INT NULL,
  nombre VARCHAR(128) NULL,
  producto_id INT  NOT NULL,
  activo BOOLEAN NOT NULL default true,
  facturado SMALLINT NOT NULL,
  
  PRIMARY KEY (id),
  CONSTRAINT orden_linea_venta_orden_id_fkey
    FOREIGN KEY (orden_id)
    REFERENCES erp.orden_venta (id),
  CONSTRAINT orden_linea_venta_producto_id_fkey
    FOREIGN KEY (producto_id)
    REFERENCES erp.producto (id),
  CONSTRAINT orden_linea_venta_impuesto_id_fkey
    FOREIGN KEY (impuesto_id)
    REFERENCES erp.impuesto (id));

   
CREATE SEQUENCE erp.diario_seq;

CREATE TABLE IF NOT EXISTS erp.diario (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.diario_seq'),
  nombre VARCHAR(64) NOT NULL,
  codigo VARCHAR(64) NOT NULL,
  tipo varchar(64) NOT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id));
   

    
CREATE SEQUENCE erp.orden_compra_seq;

CREATE TABLE IF NOT EXISTS erp.orden_compra (

  id INT NOT NULL DEFAULT NEXTVAL ('erp.orden_compra_seq'),
  fecha TIMESTAMP(0) NOT NULL,
  socio_id INT NOT NULL,
  cantidad_impuesto DOUBLE PRECISION NULL,
  cantidad_total DOUBLE PRECISION NULL,
  cantidad_sinimpuesto DOUBLE PRECISION NULL,
  nombre varchar(64) NULL,
  estado varchar(64) NULL,
  sistema_factura varchar(64) NULL,
  entrega_creada SMALLINT NULL,
  enviado SMALLINT NULL,
  pagado SMALLINT NULL,
  no_pagado DOUBLE PRECISION NULL,
  notas varchar(5000) NULL,
  descuento INT NULL,
  referencia  varchar(64) NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT orden_compra_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id));
    
    
CREATE SEQUENCE erp.entrada_diaria_seq;

CREATE TABLE IF NOT EXISTS erp.entrada_diaria (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.entrada_diaria_seq'),
  diario_id INT NULL,
  nombre VARCHAR(64) NULL,
  referencia VARCHAR(64) NULL,
  fecha TIMESTAMP(0) NULL,
  cantidad DOUBLE PRECISION NOT NULL,
  estado varchar(64) NULL,
  socio_id INT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT entrada_diaria_diario_id_fkey
    FOREIGN KEY (diario_id)
    REFERENCES erp.diario (id),
  CONSTRAINT entrada_diaria_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id));    
 
 
CREATE SEQUENCE erp.diario_item_seq;

CREATE TABLE IF NOT EXISTS erp.diario_item (
 
  id INT NOT NULL DEFAULT NEXTVAL ('erp.diario_item_seq'),
  socio_id INT NULL,
  cuenta_id INT NULL,
  debito DOUBLE PRECISION NOT NULL,
  credito DOUBLE PRECISION NOT NULL,
  costo_bienes_vendidos DOUBLE PRECISION NOT NULL,
  cantidad_residual DOUBLE PRECISION NULL,
  fecha TIMESTAMP(0) NOT NULL,
  diario_id INT NULL,
  nombre VARCHAR(64) NULL,
  referencia VARCHAR(64) NULL,
  entrada_id INT NULL,
  producto_id INT NULL,
  impuesto_cantidad DOUBLE PRECISION NULL,
  cantidad DOUBLE PRECISION NULL,
  uom_id INT NULL,
  impuesto_id INT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT entrada_diaria_line_impuesto_id_fkey
    FOREIGN KEY (impuesto_id)
    REFERENCES erp.impuesto (id),
  CONSTRAINT entrada_diaria_line_cuenta_id_fkey
    FOREIGN KEY (cuenta_id)
    REFERENCES erp.cuenta (id),
  CONSTRAINT entrada_diaria_line_diario_id_fkey
    FOREIGN KEY (diario_id)
    REFERENCES erp.diario (id),
  CONSTRAINT entrada_diaria_line_entrada_id_fkey
    FOREIGN KEY (entrada_id)
    REFERENCES erp.entrada_diaria (id),
  CONSTRAINT entrada_diaria_line_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id),
  CONSTRAINT entrada_diaria_line_producto_id_fkey
    FOREIGN KEY (producto_id)
    REFERENCES erp.producto (id),
  CONSTRAINT entrada_diaria_line_producto_uom_id_fkey
    FOREIGN KEY (uom_id)
    REFERENCES erp.producto_uom (id));


CREATE SEQUENCE erp.inventario_seq;

CREATE TABLE IF NOT EXISTS erp.inventario (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.inventario_seq'),
  maxima_cantidad DOUBLE PRECISION NULL,
  minima_cantidad DOUBLE PRECISION NULL,
  cantidad DOUBLE PRECISION NOT NULL,
  entrante DOUBLE PRECISION NOT NULL,
  reservado DOUBLE PRECISION NOT NULL,
  costo_unitario DOUBLE PRECISION NOT NULL,
  costo_total DOUBLE PRECISION NOT NULL,
  producto_id INT NOT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT inventario_producto_id_fkey
    FOREIGN KEY (producto_id)
    REFERENCES erp.producto (id));  
 
    
CREATE SEQUENCE erp.factura_seq;

CREATE TABLE IF NOT EXISTS erp.factura (

  id INT NOT NULL DEFAULT NEXTVAL ('erp.factura_seq'),
  venta_id INT NULL,
  compra_id INT NULL,
  fecha TIMESTAMP(0) NOT NULL,
  cuenta_id INT NULL,
  diario_id INT NULL,
  entrada_id INT NULL,
  socio_id INT NOT NULL,
  nombre varchar(64) NULL,
  cantidad_sinimpuesto DOUBLE PRECISION NULL,
  cantidad_total DOUBLE PRECISION NULL,
  cantidad_impuesto DOUBLE PRECISION NULL,
  tipo varchar(64) NULL,
  origen VARCHAR(64) NULL,
  referencia VARCHAR(64) NULL,
  comentario varchar(5000) NULL,
  residual DOUBLE PRECISION NULL, 
  estado varchar(64) NULL,
  numero VARCHAR(32) NULL,
  proveedor_factura_numero VARCHAR(64) NULL,
  activo BOOLEAN NOT NULL default true,
    
  PRIMARY KEY (id),
  CONSTRAINT factura_venta_id_fkey
    FOREIGN KEY (venta_id)
    REFERENCES erp.orden_venta (id),
  CONSTRAINT factura_compra_id_fkey
    FOREIGN KEY (compra_id)
    REFERENCES erp.orden_compra (id),
  CONSTRAINT factura_cuenta_id_fkey
    FOREIGN KEY (cuenta_id)
    REFERENCES erp.cuenta (id),
  CONSTRAINT factura_diario_id_fkey
    FOREIGN KEY (diario_id)
    REFERENCES erp.diario (id),
  CONSTRAINT factura_entrada_id_fkey
    FOREIGN KEY (entrada_id)
    REFERENCES erp.entrada_diaria (id),
  CONSTRAINT factura_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id));
    

CREATE SEQUENCE erp.pago_seq;

CREATE TABLE IF NOT EXISTS erp.pago  (

  id INT NOT NULL DEFAULT NEXTVAL ('erp.pago_seq'),
  fecha TIMESTAMP(0) NOT NULL,
  socio_id INT NULL,
  cantidad DOUBLE PRECISION NOT NULL,
  pago_excesivo DOUBLE PRECISION NOT NULL,
  nombre varchar(64) NULL,
  diario_id INT NULL,
  entrada_id INT NULL,
  cuenta_id INT NULL,
  factura_id INT NULL, 
  referencia VARCHAR(64) NULL,
  tipo VARCHAR(64) NULL,
  socio_tipo VARCHAR(64) NOT NULL,
  estado varchar(64) NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT pago_factura_id_fkey
    FOREIGN KEY (factura_id)
    REFERENCES erp.factura (id),
  CONSTRAINT pago_cuenta_id_fkey
    FOREIGN KEY (cuenta_id)
    REFERENCES erp.cuenta (id),
  CONSTRAINT pago_diario_id_fkey
    FOREIGN KEY (diario_id)
    REFERENCES erp.diario (id),
  CONSTRAINT pago_entrada_id_fkey
    FOREIGN KEY (entrada_id)
    REFERENCES erp.entrada_diaria (id),
  CONSTRAINT pago_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id));
  
  
CREATE SEQUENCE erp.linea_orden_compra_seq;

CREATE TABLE IF NOT EXISTS erp.linea_orden_compra (
 
  id INT NOT NULL DEFAULT NEXTVAL ('erp.linea_orden_compra_seq'),
  fecha TIMESTAMP(0) NULL,
  orden_id INT NOT NULL,
  precio DOUBLE PRECISION NOT NULL,
  cantidad DOUBLE PRECISION NOT NULL,
  uom VARCHAR(60) NOT NULL,
  estado varchar(64) NULL,
  producto_id INT NOT NULL,
  nombre varchar(64) NULL,
  sub_total DOUBLE PRECISION NOT NULL,
  impuesto_id INT NULL,
  activo BOOLEAN NOT NULL default true,
  facturado SMALLINT NOT NULL,
  
  
  PRIMARY KEY (id),
  CONSTRAINT linea_orden_compra_impuesto_id_fkey
    FOREIGN KEY (impuesto_id)
    REFERENCES erp.impuesto (id),
  CONSTRAINT linea_orden_compra_orden_id_fkey
    FOREIGN KEY (orden_id)
    REFERENCES erp.orden_compra (id),
  CONSTRAINT linea_orden_compra_producto_id_fkey
    FOREIGN KEY (producto_id)
    REFERENCES erp.producto (id));
    
    
CREATE SEQUENCE erp.linea_factura_seq;

CREATE TABLE IF NOT EXISTS erp.linea_factura (
    
  id INT NOT NULL DEFAULT NEXTVAL ('erp.linea_factura_seq'),
  fecha TIMESTAMP(0) NULL,
  uom VARCHAR(60) NOT NULL,
  cuenta_id INT NULL,
  nombre varchar(64) NULL,
  factura_id INT NOT NULL,
  precio DOUBLE PRECISION NOT NULL,
  subtotal_precio DOUBLE PRECISION NOT NULL,
  impuesto_id INT NULL,
  descuento DOUBLE PRECISION NOT NULL,
  cantidad DOUBLE PRECISION NOT NULL,
  producto_id INT NULL,
  socio_id INT NOT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT linea_factura_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id),
  CONSTRAINT linea_factura_cuenta_id_fkey
    FOREIGN KEY (cuenta_id)
    REFERENCES erp.cuenta (id),
  CONSTRAINT linea_factura_factura_id_fkey
    FOREIGN KEY (factura_id)
    REFERENCES erp.factura (id),
  CONSTRAINT linea_factura_producto_id_fkey
    FOREIGN KEY (producto_id)
    REFERENCES erp.producto (id),
  CONSTRAINT linea_factura_impuesto_id_fkey
    FOREIGN KEY (impuesto_id)
    REFERENCES erp.impuesto (id));

      
CREATE SEQUENCE erp.orden_entrega_seq;

CREATE TABLE IF NOT EXISTS erp.orden_entrega (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.orden_entrega_seq'),
  socio_id INT NOT NULL,
  orden_retornada_id INT NULL,
  fecha TIMESTAMP(0) NOT NULL,
  venta_id INT NULL,
  compra_id INT NULL,
  origen VARCHAR(64) NULL,
  nombre VARCHAR(64) NULL,
  estado varchar(64) NULL,
  metodo_entrega varchar(64)  NULL,
  tipo varchar(64) NULL,
  activo BOOLEAN NOT NULL default true,
 



  PRIMARY KEY (id),
  CONSTRAINT orden_entrega_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id),
  CONSTRAINT orden_entrega_orden_retornada_id_fkey
    FOREIGN KEY (orden_retornada_id)
    REFERENCES erp.orden_entrega (id),
  CONSTRAINT orden_entrega_compra_id_fkey
    FOREIGN KEY (compra_id)
    REFERENCES erp.orden_compra (id),
  CONSTRAINT orden_entrega_venta_id_fkey
    FOREIGN KEY (venta_id)
    REFERENCES erp.orden_venta (id));



CREATE SEQUENCE erp.linea_orden_entrega_seq;

CREATE TABLE IF NOT EXISTS erp.linea_orden_entrega (

  id INT NOT NULL DEFAULT NEXTVAL ('erp.linea_orden_entrega_seq'),
  entrega_id INT NOT NULL,
  uom VARCHAR(60) NOT NULL,
  producto_id INT NOT NULL,
  precio DOUBLE PRECISION NOT NULL,
  cantidad DOUBLE PRECISION NOT NULL,
  reservado DOUBLE PRECISION NOT NULL,  
  socio_id INT NULL,
  tipo varchar(64) NULL,  
  estado varchar(64) NOT NULL,
  activo BOOLEAN NOT NULL default true,
   
  PRIMARY KEY (id),
  CONSTRAINT linea_orden_entrega_socio_id_fkey
    FOREIGN KEY (socio_id)
    REFERENCES erp.socio (id),
  CONSTRAINT linea_orden_entrega_picking_id_fkey
    FOREIGN KEY (entrega_id)
    REFERENCES erp.orden_entrega (id),
  CONSTRAINT linea_orden_entrega_producto_id_fkey
    FOREIGN KEY (producto_id)
    REFERENCES erp.producto (id));
    
    
 CREATE SEQUENCE erp.factura_impuesto_seq;

 CREATE TABLE IF NOT EXISTS erp.factura_impuesto (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.factura_impuesto_seq'),
  fecha TIMESTAMP(0) NULL,
  impuesto_cantidad DOUBLE PRECISION NULL,
  cuenta_id INT NULL,
  nombre VARCHAR(64)  NULL,
  factura_id INT NULL,
  base_cantidad DOUBLE PRECISION NULL,
  impuesto_id INT NULL,
  activo BOOLEAN NOT NULL default true,
  
  PRIMARY KEY (id),
  CONSTRAINT cuenta_factura_impuesto_cuenta_id_fkey
    FOREIGN KEY (cuenta_id)
    REFERENCES erp.cuenta (id),
  CONSTRAINT cuenta_factura_impuesto_factura_id_fkey
    FOREIGN KEY (factura_id)
    REFERENCES erp.factura (id),
  CONSTRAINT cuenta_factura_impuesto_impuesto_id_fkey
    FOREIGN KEY (impuesto_id)
    REFERENCES erp.impuesto (id));

  

CREATE SEQUENCE erp.factura_pago_seq;

CREATE TABLE IF NOT EXISTS erp.factura_pago (
  id INT NOT NULL DEFAULT NEXTVAL ('erp.factura_pago_seq'),
  factura_id INT NOT NULL,
  entrada_diaria_id INT NOT NULL,
  fecha TIMESTAMP(0) NOT NULL,
  nombre VARCHAR(64)  NULL,
  pagado_cantidad DOUBLE PRECISION NOT NULL,

PRIMARY KEY (id),
CONSTRAINT factura_pago_entrada_diaria_id_fkey
    FOREIGN KEY (entrada_diaria_id)
    REFERENCES erp.entrada_diaria (id),
CONSTRAINT factura_pago_factura_id_fkey
    FOREIGN KEY (factura_id)
    REFERENCES erp.factura (id));