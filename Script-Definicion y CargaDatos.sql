/* José Carlos Amo Perez Proyecto sql */


/********* creando esquema */

create schema amoperez authorization dpozoygs;


/***********************************************************/
/******* inicio de los scripts de creación de tablas *******/
/***********************************************************/



/********* creando tabla "divisas" y estableciendo PK  */

create table amoperez.divisas(
	id_divisa varchar(3) not null,  ---PK
	nombre_divisa varchar(100) not null,
	ticker varchar(3) not null
);
alter table amoperez.divisas add constraint divisas_PK primary key (id_divisa);


/********* creando tabla "aseguradoras" y estableciendo PK  */

create table amoperez.aseguradoras(
	id_aseguradora varchar(3) not null,  ---PK
	nombre_aseguradora varchar(100) not null
);
alter table amoperez.aseguradoras add constraint aseguradoras_PK primary key (id_aseguradora);


/********* creando tabla "colores" y estableciendo PK  */
create table amoperez.colores(
	id_color varchar(3) not null,   ---PK
	nombre_color varchar(100) not null
);
alter table amoperez.colores add constraint colores_PK primary key (id_color);


/********* creando tabla "grupos" (grupos automovilísticos)y estableciendo PK  */
create table amoperez.grupos(
	id_grupo varchar(3) not null,   ---PK
	nombre_grupo varchar(100) not null
);
alter table amoperez.grupos add constraint grupos_PK primary key (id_grupo);


/********* creando tabla "marcas" y estableciendo PK y FK  */
create table amoperez.marcas(
	id_marca varchar(3) not null,   ---PK
	nombre_marca varchar(100) not null,
	id_grupo varchar(3) not null  ---FK referencia a tabla "grupos"
);
alter table amoperez.marcas add constraint marcas_PK primary key (id_marca); --- declaro la PK

alter table amoperez.marcas           --- declaro la FK
	add constraint marcas_id_grupo_FK 
		foreign key (id_grupo) 
		references amoperez.grupos (id_grupo);
	

/********* creando tabla "modelos" y estableciendo PK y FK  */
create table amoperez.modelos(
	id_modelo varchar(3) not null,   ---PK
	nombre_modelo varchar(100) not null,
	id_marca varchar(3) not null  ---FK referencia a tabla "marcas"
);

alter table amoperez.modelos add constraint modelos_PK primary key (id_modelo); --- declaro la PK

alter table amoperez.modelos           --- declaro la FK
	add constraint modelos_id_marca_FK 
		foreign key (id_marca) 
		references amoperez.marcas (id_marca);
	

/********* creando tabla "vehiculos" y estableciendo PK y FK  */
create table amoperez.vehiculos(
	id_vehiculo varchar(6) not null,   ---PK
	id_modelo varchar(3) not null,     ---FK
	id_color varchar(3) not null,      ---FK
	matricula varchar(10) not null,
	fecha_compra date not null,
	fecha_venta date default '4000-01-01',
	comentarios varchar (500) null
); 

alter table amoperez.vehiculos add constraint vehiculos_PK primary key (id_vehiculo); --- declaro la PK

alter table amoperez.vehiculos           --- declaro la FK que apunta a colores
	add constraint vehiculos_id_color_FK 
		foreign key (id_color) 
		references amoperez.colores (id_color);

alter table amoperez.vehiculos           --- declaro la FK que apunta a modelos
	add constraint vehiculos_id_modelo_FK 
		foreign key (id_modelo) 
		references amoperez.modelos (id_modelo);


/********* creando tabla "revisiones" y estableciendo PK y FK  */
create table amoperez.revisiones(
	id_vehiculo varchar(6) not null,   ---PK y FK
	fecha_revision date not null,      ---PK
	kilometros_rev integer not null,
	importe_revision numeric (8,2),
	id_divisa varchar(3) not null,     ---FK
	proxima_revision date default '4000-01-01',
	comentarios varchar (500) null
);

alter table amoperez.revisiones add constraint revisiones_PK primary key (id_vehiculo, fecha_revision); --- declaro las dos PK

alter table amoperez.revisiones           --- declaro la FK que apunta a divisas
	add constraint revisiones_id_divisa_FK 
		foreign key (id_divisa) 
		references amoperez.divisas (id_divisa);
	
alter table amoperez.revisiones           --- declaro la FK que apunta a vehiculos
	add constraint revisiones_id_vehiculo_FK 
		foreign key (id_vehiculo) 
		references amoperez.vehiculos (id_vehiculo);


/********* creando tabla "kilometros" y estableciendo PK y FK  */
create table amoperez.kilometros(
	id_vehiculo varchar(6) not null,   ---PK y FK
	fecha_lectura date not null,       ---PK
	kilometros_tot integer not null,
	proxima_lectura date default '4000-01-01'
);

alter table amoperez.kilometros add constraint kilometros_PK primary key (id_vehiculo, fecha_lectura); --- declaro las dos PK

alter table amoperez.kilometros           --- declaro la FK que apunta a vehiculos
	add constraint kilometros_id_vehiculo_FK 
		foreign key (id_vehiculo) 
		references amoperez.vehiculos (id_vehiculo);


/********* creando tabla "polizas" y estableciendo PK y FK  */
create table amoperez.polizas(
	id_vehiculo varchar(6) not null,     ---PK y FK
	fecha_alta date not null,            ---PK
	id_aseguradora varchar(3) not null,  ---FK
	numero_poliza varchar(50) not null,
	fecha_baja date default '4000-01-01',
	comentarios varchar (500) null
);

alter table amoperez.polizas add constraint polizas_PK primary key (id_vehiculo, fecha_alta); --- declaro las dos PK
	
alter table amoperez.polizas           --- declaro la FK que apunta a vehiculos
	add constraint polizas_id_vehiculo_FK 
		foreign key (id_vehiculo) 
		references amoperez.vehiculos (id_vehiculo);
	
alter table amoperez.polizas           --- declaro la FK que apunta a aseguradoras
	add constraint polizas_id_aseguradora_FK 
		foreign key (id_aseguradora) 
		references amoperez.aseguradoras (id_aseguradora);	
	
/***********************************************************/
/********* fin de los scripts de creación de tablas ********/
/***********************************************************/
	
	
/***********************************************************/
/********* inicio de los scripts de carga de tablas ********/
/***********************************************************/	

/********* cargando la tabla "divisas" */
insert into amoperez.divisas (id_divisa, nombre_divisa,	ticker) values ('001','Dolar estadounidense','USD');
insert into amoperez.divisas (id_divisa, nombre_divisa,	ticker) values ('002','Euro','EUR');

/********* cargando la tabla "aseguradoras" */
insert into amoperez.aseguradoras (id_aseguradora,nombre_aseguradora) values ('001','Grupo Liberty');
insert into amoperez.aseguradoras (id_aseguradora,nombre_aseguradora) values ('002','Mutua Madrileña');
insert into amoperez.aseguradoras (id_aseguradora,nombre_aseguradora) values ('003','Zurich');



insert into amoperez.colores (id_color,nombre_color) values ('001','Blanco');
insert into amoperez.colores (id_color,nombre_color) values ('002','Gris Armadura');
insert into amoperez.colores (id_color,nombre_color) values ('003','Azul Francia');
insert into amoperez.colores (id_color,nombre_color) values ('004','Rojo Prusia');


/********* cargando la tabla "grupos" */
insert into amoperez.grupos (id_grupo,nombre_grupo) values ('001','Grupo Volkswagen (VAG)');
insert into amoperez.grupos (id_grupo,nombre_grupo) values ('002','Renault-Nissan-Mitsubishi');
insert into amoperez.grupos (id_grupo,nombre_grupo) values ('003','Stellantis');
select * from amoperez.grupos;


/********* cargando la tabla "marcas" */
insert into amoperez.marcas (id_marca,id_grupo,nombre_marca) values ('001','001','Volkswagen');
insert into amoperez.marcas (id_marca,id_grupo,nombre_marca) values ('002','001','Seat');
insert into amoperez.marcas (id_marca,id_grupo,nombre_marca) values ('003','002','Renault');
insert into amoperez.marcas (id_marca,id_grupo,nombre_marca) values ('004','003','Opel');
insert into amoperez.marcas (id_marca,id_grupo,nombre_marca) values ('005','003','Peugeot');


/********* cargando la tabla "modelos" */
insert into amoperez.modelos (id_modelo,id_marca,nombre_modelo) values ('001','001','Transporter');
insert into amoperez.modelos (id_modelo,id_marca,nombre_modelo) values ('002','002','Ibiza');
insert into amoperez.modelos (id_modelo,id_marca,nombre_modelo) values ('003','002','Leon');
insert into amoperez.modelos (id_modelo,id_marca,nombre_modelo) values ('004','003','Captur');
insert into amoperez.modelos (id_modelo,id_marca,nombre_modelo) values ('005','004','Corsa');
insert into amoperez.modelos (id_modelo,id_marca,nombre_modelo) values ('006','005','Partner');
insert into amoperez.modelos (id_modelo,id_marca,nombre_modelo) values ('007','005','Boxer');


/********* cargando la tabla "vehiculos" */
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('001','001','001','BRLSN4I49','2019-01-18','2021-11-15','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('002','002','002','BGEH3717BT','2020-12-20','4000-01-01','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('003','002','002','78759','2020-12-20','4000-01-01','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('004','003','002','4692LJI','2020-12-20','4000-01-01','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('005','004','003','7198GLY','2020-12-20','4000-01-01','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('006','004','003','9156IKG','2020-12-20','4000-01-01','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('007','005','004','8554DRN','2022-08-01','4000-01-01','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('008','005','004','2778DEO','2022-08-01','4000-01-01','que recuerdos');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('009','006','001','7091IUR','2022-08-01','4000-01-01','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('010','007','001','7805ENU','2022-08-01','4000-01-01','este es el mejor');


/********* cargando la tabla "revisiones" */
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('001','2019-07-17',4225,426,'002','2020-01-12','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('001','2020-01-13',7102,426,'002','2020-07-10','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('001','2020-07-11',10687,818,'002','2021-11-09','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('001','2021-11-10',14675,688,'002','4000-01-01','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('002','2021-06-18',26958,533,'002','2021-12-14','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('002','2021-12-15',52975,503,'002','2022-06-10','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('002','2022-06-13',79688,620,'001','4000-01-01','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('003','2021-06-18',16160,823,'002','2021-12-17','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('003','2021-12-15',32651,787,'002','2022-06-15','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('003','2022-06-13',48482,767,'001','4000-01-01','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('004','2021-06-18',7722,965,'002','2021-12-09','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('004','2021-12-15',15741,652,'002','2022-06-10','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('004','2022-06-13',23216,953,'001','4000-01-01','suena raro');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('005','2021-06-18',14881,637,'002','2021-12-03','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('005','2021-12-15',28901,724,'002','2022-06-10','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('005','2022-06-13',42414,569,'001','4000-01-01','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('006','2021-06-18',22303,899,'002','2021-12-25','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('006','2021-12-15',47001,953,'002','2022-06-28','vigilar si se calienta');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('006','2022-06-13',57185,818,'001','4000-01-01','');


/********* cargando la tabla "kilometros" */
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('001','2019-07-17',4225,'2020-01-10');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('001','2020-01-13',7102,'2020-07-09');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('001','2020-07-11',10687,'2021-11-09');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('001','2021-11-10',14675,'2021-11-10');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('001','2021-11-15',14675,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('002','2021-06-18',26958,'2021-12-15');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('002','2021-12-15',52975,'2022-06-13');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('002','2022-06-13',79688,'2022-09-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('002','2022-09-01',80073,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('003','2021-06-18',16160,'2021-12-15');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('003','2021-12-15',32651,'2022-06-13');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('003','2022-06-13',48482,'2022-09-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('003','2022-09-01',48646,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('004','2021-06-18',7722,'2021-12-15');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('004','2021-12-15',15741,'2022-06-13');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('004','2022-06-13',23216,'2022-09-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('004','2022-09-01',23400,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('005','2021-06-18',14881,'2021-12-15');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('005','2021-12-15',28901,'2022-06-13');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('005','2022-06-13',42414,'2022-09-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('005','2022-09-01',42414,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('006','2021-06-18',22303,'2021-12-15');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('006','2021-12-15',47001,'2022-06-13');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('006','2022-06-13',57185,'2022-09-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('006','2022-09-01',57185,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('007','2022-09-01',10629,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('008','2022-09-01',68859,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('009','2022-09-01',69523,'4000-01-01');
insert into amoperez.kilometros (id_vehiculo,fecha_lectura,kilometros_tot,proxima_lectura) values ('010','2022-09-01',57815,'4000-01-01');


/********* cargando la tabla "polizas" */
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('001','2019-01-18','002','CLUAKRN41663KAD','2020-01-18','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('001','2020-01-18','002','SSJHRTX68437RHQ','2021-01-18','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('001','2021-01-18','001','9ZC46QQ10ZZ','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('002','2020-12-20','002','ZESHIJJ68507ZYW','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('003','2020-12-20','002','YITLFRW49579CPB','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('004','2020-12-20','002','EJSRCPR15236DXU','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('005','2020-12-20','002','LHZMRUN38530HDQ','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('006','2020-12-20','001','6ZC52LI850N','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('007','2022-08-01','001','5IF39XU911E','2022-08-15','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('007','2022-08-15','001','4PI48XZ513A','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('008','2022-08-01','003','79EE224712JH177VBT','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('009','2022-08-01','003','65EE203827MO432VBT','4000-01-01','');
insert into amoperez.polizas (id_vehiculo,fecha_alta,id_aseguradora,numero_poliza,fecha_baja,comentarios) values ('010','2022-08-01','003','44EE581843AT690VBT','4000-01-01','');

