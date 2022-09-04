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
	fecha_venta date default '09/09/9999',
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
	proxima_revision date default '09/09/9999',
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
	proxima_lectura date default '09/09/9999'
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
	fecha_baja date default '9999-09-09',
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
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('001','001','001','BRLSN4I49','18/01/2019','15/11/2021','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('002','002','002','BGEH3717BT','20/12/2020','09/09/9999','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('003','002','002','78759','20/12/2020','09/09/9999','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('004','003','002','4692LJI','20/12/2020','09/09/9999','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('005','004','003','7198GLY','20/12/2020','09/09/9999','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('006','004','003','9156IKG','20/12/2020','09/09/9999','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('007','005','004','8554DRN','01/08/2022','09/09/9999','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('008','005','004','2778DEO','01/08/2022','09/09/9999','que recuerdos');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('009','006','001','7091IUR','01/08/2022','09/09/9999','');
insert into amoperez.vehiculos (id_vehiculo,id_modelo,id_color,matricula,fecha_compra,fecha_venta,comentarios) values ('010','007','001','7805ENU','01/08/2022','09/09/9999','este es el mejor');


/********* cargando la tabla "revisiones" */
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('001','13/01/2020',7102,426,'002','2020-07-10','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('001','11/07/2020',10687,818,'002','2021-11-09','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('001','10/11/2021',14675,688,'002','09/09/9999','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('002','18/06/2021',26958,533,'002','2021-12-14','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('002','15/12/2021',52975,503,'002','2022-06-10','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('002','13/06/2022',79688,620,'001','09/09/9999','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('003','18/06/2021',16160,823,'002','2021-12-17','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('003','15/12/2021',32651,787,'002','2022-06-15','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('003','13/06/2022',48482,767,'001','09/09/9999','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('004','18/06/2021',7722,965,'002','2021-12-09','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('004','15/12/2021',15741,652,'002','2022-06-10','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('004','13/06/2022',23216,953,'001','09/09/9999','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('005','18/06/2021',14881,637,'002','2021-12-03','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('005','15/12/2021',28901,724,'002','2022-06-10','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('005','13/06/2022',42414,569,'001','09/09/9999','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('006','18/06/2021',22303,899,'002','2021-12-25','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('006','15/12/2021',47001,953,'002','2022-06-31','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('006','13/06/2022',57185,818,'001','09/09/9999','');
insert into amoperez.revisiones (id_vehiculo,fecha_revision,kilometros_rev,importe_revision,id_divisa,proxima_revision,comentarios) values ('001','17/07/2019',4225,426,'002','2019-12-30','este es el primero');

select * from amoperez.revisiones;