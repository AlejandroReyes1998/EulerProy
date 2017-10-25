drop database ordenDia; 
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS=0;
create database ordenDia;
use ordenDia;

/*Creación de Tablas*/


create table Persona(
	idPersona integer,
    Nombre nvarchar(30),
    Direccion nvarchar(50),
    Correo nvarchar(50),
    Pass nvarchar(100),
    primary key(idPersona)
);

create table Telefono(
	idTelefono integer,
    idPersona integer,
    Telefono nvarchar(15),
    idCtgTelefono integer,
    primary key(idTelefono)
);

create table RelPerTipo(
	idRelPerTipo integer,
    idCtgTipoPer integer,
    idPersona integer,
    primary key(idRelPerTipo)
);

create table CtgTelefono(
	idCtgTelefono integer,
	TipoContacto integer,
    Descripción nvarchar(45),
    primary key (idCtgTelefono)
);

create table CtgTipoPersona(
	idCtgTipoPer integer,
	idTipoPer integer,
    Descripción nvarchar(45),
    primary key (idCtgTipoPer)
);

create table Restaurante(
	idRestaurante integer,
    Nombre nvarchar(30),
    Descripcion nvarchar(400),
    Direccion nvarchar(400),
    idPersona int,
    primary key(idRestaurante)
);

create table RelRestPlatillo(
	idRelRestPlatillo integer,
    idRestaurante integer,
    idPlatillo integer,
    primary key(idRelRestPlatillo)
);

create table Platillo(
	idPlatillo integer,
	Nombre nvarchar(50),
    Descripcion nvarchar(400),
    Precio double,
    idRestaurante integer,
    primary key(idPlatillo)
);
  
create table Reservacion(
	idReservacion integer,
    idPersona integer,
    Fecha nvarchar(50),
    Hora int,
    Minuto int,
    idRestaurante integer,
    primary key(idReservacion)
);

create table Orden(
	idOrden integer,
    idRestaurante integer,
    idPlatillo integer,
    idPersona integer,
    cantidad integer,
    Fecha timestamp,
    Precio double,
    primary key(idOrden)
);


/*create table DetalleOrden(
	idDetalleOrden integer,
    idOrden integer,
    idPlatillo integer,
    Cantidad integer,
    Subtotal double,
    primary key(idDetalleOrden)
);*/

/*Catalogos*/
insert into CtgTipoPersona VALUES (1,1,'Administrador');
insert into CtgTipoPersona VALUES (2,2,'Cliente');
select * from CtgTelefono;
insert into CtgTelefono VALUES (1,1,'Casa'); -- Casa
insert into CtgTelefono VALUES (2,2,'Celular'); -- Celular
insert into CtgTelefono VALUES (3,3,'Trabajo'); -- Oficina

/*Llaves Foraneas*/
alter table Telefono add foreign key(idPersona) references Persona(idPersona); 
describe Telefono;

alter table RelPerTipo add foreign key(idCtgTipoPer) references CtgTipoPersona(idCtgTipoPer);
alter table RelPerTipo add foreign key(idPersona) references Persona(idPersona);
describe RelPerTipo;

alter table Restaurante add foreign key(idPersona) references Persona(idPersona); 
describe Restaurante;

alter table RelRestPlatillo add foreign key(idRestaurante) references Restaurante(idRestaurante);
alter table RelRestPlatillo add foreign key(idPlatillo) references Platillo(idPlatillo);
describe RelRestPlatillo;

alter table Orden add foreign key(idRestaurante) references Restaurante(idRestaurante);
alter table Orden add foreign key(idPersona) references Persona(idPersona);
alter table Orden add foreign key(idPlatillo) references Platillo(idPlatillo);
describe Orden;

-- alter table DetalleOrden add foreign key(idOrden) references Orden(idOrden);
-- alter table DetalleOrden add foreign key(idPlatillo) references Platillo(idPlatillo);

alter table Platillo add foreign key(idRestaurante) references Restaurante(idRestaurante);

alter table Reservacion add foreign key(idPersona) references Persona(idPersona);
alter table Reservacion add foreign key(idRestaurante) references Restaurante(idRestaurante);
describe Reservacion;
use ordendia;
/*Pruebas*/
-- delete from persona where 1=1;
/*call sp_AltaUsuario('Abraham', 'TlaxcalaYork','999@gmail.com','juice','5577882',1);
call sp_AltaUsuario('A', 'Grandenko','prince@gmail.com','lefank','3223321',1);
call sp_AltaUsuario('Amahury', 'plex','defwf@gmail.com','pleymo','0553321334',3);
call sp_AltaUsuario('STING', 'Lima','tr@hotmail.com','kim','29013456',2);
call sp_ValidaLogIn('999gmail.com','juice');
select * from persona;
select * from telefono;
select * from restaurante;
select * from platillo;
select * from reservacion;
select * from platillo_restaurante;
call st_consultasUsuario('u', 'u');
call st_BajasUsuario('prince@gmail.com', 'lefank');
call st_consultasUsuario('Ivan', 'Mongol');
call st_CambioUsuario('Luis','Torres','prince@gmail.com','lefank');
select * from persona;
call st_consultasUsuario('iliana@iliana.com','1234');
SELECT * FROM persona_telefono where 'gerardo@gerardo.com' = Correo and SHA1('1234') = Pass;
/* Vistas */
-- drop view persona_telefono;
use ordenDia;
CREATE VIEW persona_telefono AS SELECT Persona.Nombre,Persona.idPersona,Direccion,Correo,Pass,Telefono.Telefono,CtgTelefono.Descripción 
FROM Persona INNER JOIN Telefono ON Persona.idPersona = Telefono.idPersona 
Inner JOIN CtgTelefono on Telefono.idCtgTelefono = CtgTelefono.idCtgTelefono;
Select * From PERSONA_TELEFONO;


Create View platillo_restaurante as Select platillo.nombre,restaurante.nombre as Restaurante, platillo.Descripcion,precio from platillo
Inner Join Restaurante  on platillo.idRestaurante = restaurante.idRestaurante;
Select * From platillo_restaurante;


create view platillo_orden as Select Restaurante.Nombre AS 'Restaurante',Platillo.idPlatillo,Platillo.idRestaurante,Platillo.Nombre,Platillo.Precio,Orden.cantidad,Orden.idPersona,Orden.idOrden from platillo
inner join orden on Orden.idPlatillo = Platillo.idPlatillo Inner JOIN restaurante on Platillo.idRestaurante = Restaurante.idRestaurante;
select * from platillo_orden;

Create view persona_reservacion as Select Persona.idPersona,Restaurante.idRestaurante,Reservacion.Hora,Reservacion.Minuto,Persona.Nombre,
Restaurante.Nombre AS 'Restaurante' , reservacion.Fecha from persona inner join reservacion on Persona.idPersona = reservacion.idPersona inner join restaurante
on reservacion.idRestaurante = restaurante.idRestaurante;
select * from persona_reservacion;

use ordendia;
/*Procedures*/
-- drop procedure sp_AltaUsuario;
delimiter // 
create procedure sp_AltaUsuario (in nom nvarchar (50), in direc nvarchar (50), in mail nvarchar(50), in contra nvarchar (18),in tel nvarchar(15), in tipo int)
begin 
	declare idtel int;
	declare idper int;
    declare existe int;
	set existe = (select count(*) from Persona where mail = Correo);
		IF EXISTE = 0 THEN 
			SET IDPER = (SELECT IFNULL(MAX(IDPERSONA), 0) + 1 FROM persona);
				INSERT INTO persona(Nombre, Direccion, Correo, Pass, idpersona) VALUES (nom, direc, mail, SHA1(contra), idper);			
            SET IDTEL = (SELECT IFNULL(MAX(IDTELEFONO), 0) + 1 FROM Telefono);
            if tipo = 1 then
				INSERT INTO Telefono(idTelefono,idPersona,Telefono,idCtgTelefono) values (idtel, idper,tel,1);
            else if tipo = 2 then 
				INSERT INTO Telefono(idTelefono,idPersona,Telefono,idCtgTelefono) values (idtel, idper,tel,2);
            else if tipo = 3 then    
				INSERT INTO Telefono(idTelefono,idPersona,Telefono,idCtgTelefono) values (idtel, idper,tel,3);
            end if; 
            end if; 
            end if;
            SELECT 'USUARIO REGISTRADO' AS MSJ;
		ELSE
			SELECT 'EL USUARIO YA EXISTE' AS MSJ;
		END IF;
END;
-- drop procedure st_consultasUsuario;
delimiter //
create procedure st_consultasUsuario(in scorreo nvarchar (50), in contra nvarchar (18))
begin
	declare existe int;
	set existe = (select count(*) from Persona where scorreo = Correo and SHA1(contra) = Pass);
    IF EXISTE = 0 THEN
		SELECT 'ESTE USUARIO NO EXISTE' AS MSJ;
 	ELSE 
		SELECT * FROM persona_telefono where scorreo = Correo and SHA1(contra) = Pass;
END IF;
END;

-- DROP PROCEDURE st_bajasUsuario;
delimiter //
create procedure st_bajasUsuario(in mail nvarchar (50), in contra nvarchar (100))
begin
	declare existe int;
	set existe = (select count(*) from Persona where mail = Correo and contra = Pass);
    IF EXISTE = 1 THEN
		DELETE Persona, Telefono FROM Persona, Telefono where Persona.idPersona = Telefono.idPersona
        and (mail = Correo and contra = Pass); 
		DELETE Persona, Telefono FROM Persona, Telefono where Persona.idPersona = Telefono.idPersona
        and (mail = Correo and contra = Pass); 
	SELECT 'EL USUARIO HA SIDO BORRADO' AS MSJ;
	ELSE 
		SELECT 'ESTE USUARIO NO EXISTE' AS MSJ;
	END IF;
END;

-- drop procedure st_cambioUsuario;
delimiter //
create procedure st_cambioUsuario(in nom nvarchar (50), in direc nvarchar (50), in mail nvarchar(50), in contra nvarchar (100))
begin
	declare existe int;
		set existe = (select count(*) from Persona where mail = Correo and contra = Pass);
		IF EXISTE = 1 THEN
			update persona SET Nombre = nom, Direccion = direc where contra = Pass and mail = Correo;
            SELECT 'EL USUARIO HA SIDO CAMBIADO' AS MSJ;
		ELSE 
			SELECT 'ESTE USUARIO NO EXISTE' AS MSJ;
	END IF;
END; 

-- DROP PROCEDURE sp_ValidaLogIn;
delimiter **
create procedure sp_ValidaLogIn(in email nvarchar(45), in contrasenia nvarchar(45))
begin
declare msj nvarchar(45);
declare existe int;
declare valido int;

set existe = (select count(*) from Persona where Correo = email and Pass = MD5(contrasenia));

if existe = 0 then
	set msj = 'usuario incorrecto';
    set valido = 0;
else
	set msj = 'Bienvenido';
    set valido = 1;
end if;

select valido as Estatus, msj as Msj;

end; **
delimiter ;

delimiter // 
delimiter // 
create procedure sp_AltaRestaurante (in idp int,in nom nvarchar (50), in descrip nvarchar (400),in direc nvarchar(400))
begin 
	declare IDRest int;
    declare existe int;
    set existe = (select count(*) from Restaurante where nom = Nombre);
    IF EXISTE = 0 THEN 
    SET IDRest = (SELECT IFNULL(MAX(idrestaurante), 0) + 1 FROM Restaurante);
    INSERT INTO restaurante(idPersona,idRestaurante, Nombre, Descripcion, Direccion) VALUES (idp,idRest,nom, descrip, direc);
    SELECT 'restaurante registrado' AS MSJ;
    ELSE
    SELECT 'restaurante repetido' AS MSJ;
    END IF;
END; //
-- drop procedure sp_ConsultaRestaurante2;
delimiter // 
create procedure sp_ConsultaRestaurante2 (in id int)
begin 
   
	SELECT * FROM restaurante where id = idPersona;
   
END;

delimiter // 
create procedure sp_ConsultaRestaurante(in nom nvarchar (50))
begin 
    declare existe int;
    set existe = (select count(*) from Restaurante where nom = Nombre);
    IF EXISTE = 1 THEN 
		SELECT * FROM restaurante where nom=Nombre;
    ELSE
    SELECT 'el restaurante no existe' AS MSJ;
    END IF;
END;
-- drop procedure sp_ConsultaRestaurante;

delimiter // 
create procedure sp_ConsultaRestaurante3 (in id int)
begin 
   
	SELECT * FROM restaurante where id = idRestaurante;
   
END;
call sp_ConsultaRestauranteFull ();
delimiter // 
create procedure sp_ConsultaRestauranteFull ()
begin 
   
	SELECT * FROM restaurante;
   
END;


-- delimiter // 
-- create procedure sp_ConsultaMiRestaurante (in id int)
-- begin 
   
-- SELECT Nombre, Descripcion, Direccion  FROM Restaurante WHERE id = idPersona;
   
-- END;

delimiter // 
create procedure sp_BajaRestaurante(in nom nvarchar (50))
begin 
    declare existe int;
    set existe = (select count(*) from Restaurante where nom = Nombre);
    IF EXISTE = 1 THEN 
		delete from restaurante where nom=Nombre;
        SELECT 'el restaurante ya no existe' AS MSJ;
    ELSE
    SELECT 'el restaurante no existe' AS MSJ;
    END IF;
END;
DROP PROCEDURE sp_CambioRestaurante;
delimiter // 
create procedure sp_CambioRestaurante (in nom nvarchar (50), in descrip nvarchar (400),in direc nvarchar(400))
begin 
    declare existe int;
    set existe = (select count(*) from Restaurante where nom = Nombre);
    IF EXISTE = 1 THEN 
		Update restaurante set Descripcion=descrip,Direccion=direc where nom=Nombre;
		SELECT 'el restaurante ha sido cambiado' AS MSJ;
    ELSE
    SELECT 'el restaurante no existe' AS MSJ;
    END IF;
END; //

delimiter //
create procedure sp_AltaPlatillo (in nom nvarchar (50), in descrip nvarchar (400),in prec double,in idRest int)
begin 
	declare idPlat int;
    declare existe int;
    set existe = (select count(*) from platillo where nom = Nombre and idRest = idRestaurante);
    IF EXISTE = 0 THEN 
    SET idPlat = (SELECT IFNULL(MAX(IDPlatillo), 0) + 1 FROM platillo);
    INSERT INTO Platillo(idPlatillo,Nombre,Descripcion, Precio,idRestaurante) VALUES (idPlat,nom,descrip,prec,idRest);
    SELECT 'platillo registrado' AS MSJ;
    ELSE
    SELECT 'platillo repetido' AS MSJ;
    END IF;
END;

delimiter // 
create procedure sp_ConsultaPlatillo(in nom nvarchar (50))
begin 
    declare existe int;
    set existe = (select count(*) from Platillo where nom = Nombre);
    IF EXISTE = 1 THEN 
		SELECT * FROM platillo_restaurante where nom=Nombre;
    ELSE
    SELECT 'el platillo no existe' AS MSJ;
    END IF;
END;



delimiter // 
create procedure sp_ConsultaPlatillo2(in id int)
begin 
   select * from platillo where id=idRestaurante;
END;


delimiter // 
create procedure sp_ConsultaPlatilloFull(in id int)
begin 
   select * from platillo_restaurante where id=idRestaurante;
END;

delimiter // 
create procedure sp_ConsultaPlatillo3(in id int)
begin 
   select * from platillo where id=idPlatillo;
END;

delimiter // 
create procedure sp_BajaPlatillo(in nom nvarchar (50))
begin 
    declare existe int;
    set existe = (select count(*) from Platillo where nom = Nombre);
    IF EXISTE = 1 THEN 
		Delete from platillo where nom=Nombre;
            SELECT 'el platillo ya no existe' AS MSJ;

    ELSE
    SELECT 'el platillo no existe' AS MSJ;
    END IF;
END;

delimiter // 
create procedure sp_CambioPlatillo(in nom nvarchar (50), in descrip nvarchar (400),in prec double,in idRest int)
begin 
    declare existe int;
    set existe = (select count(*) from Platillo where nom = Nombre);
    IF EXISTE = 1 THEN 
		Update Platillo set nom=Nombre,descrip=Descripcion,prec=Precio where nom=Nombre;
            SELECT 'platillo cambiado' AS MSJ;

    ELSE
    SELECT 'el platillo no existe' AS MSJ;
    END IF;
END;

-- drop procedure sp_AltaReservacion;
delimiter //
create procedure sp_AltaReservacion(in idRest int, in horas int, in minutos int, in fecha nvarchar (50), in idPer int)
begin
	declare existe int;
    declare idReserva int;
    set existe = (select count(*) from Reservacion where horas = Hora and idRest = idRestaurante and minutos = Minuto);
    if existe = 0 then 
	SET idReserva = (SELECT IFNULL(MAX(idReservacion), 0) + 1 FROM Reservacion);
	INSERT INTO Reservacion(idReservacion,idPersona,Fecha,Hora,Minuto,idRestaurante) VALUES (idReserva, idPer, fecha, horas, minutos, idRest);
    SELECT 'Reservacion realizada' AS MSJ;
    ELSE
    SELECT 'Reservacion ocupada' AS MSJ;
    END IF;
END;

delimiter //
create procedure sp_AltaPedido(in idPlat int,in idRest int,in idPer int,in precio int,IN cant int)
begin
	declare IDOr int;
	SET IDOr = (SELECT IFNULL(MAX(IDORDEN), 0) + 1 FROM orden);
    INSERT INTO orden(idPersona,idRestaurante,idPlatillo,Precio,idOrden,cantidad) VALUES (idper,IdRest,idPlat,precio,IDOr,cant);
    SELECT 'Pedido Tomado' AS MSJ;
end;  

delimiter //
create procedure sp_ConsultaPedido(in idPer int)
begin
	select * from orden where idPer = idPersona;
end;

delimiter // 
create procedure sp_ValidaCorreo (in Mail nvarchar(50))
begin 
   select Pass,Correo from persona where Mail=Correo;
END;
//

drop procedure sp_CambioContraCorreo ;
use OrdenDia;
delimiter //
create procedure sp_CambioContraCorreo (in passio nvarchar(50),in compara nvarchar(200))
begin 

Update persona p set p.Pass = sha1(passio) where concat(p.Pass,p.Correo)=compara;
select * from persona;
END;
//


delimiter //
create procedure sp_ConsultaPedido(in idPer int)
begin
	select * from platillo_orden where idPer = idPersona;
end;

delimiter //
create procedure sp_ConsultaReserva(in idPer int)
begin
	select * from persona_reservacion where idPer = idPersona;
end;

delimiter //
create procedure sp_ConsultaRestauranteChido(in res nvarchar(100))
begin
	declare existe int;
    set existe = (select count(*) from Restaurante where res = Nombre);
	if existe = 1 then
		select * from restaurante where res = nombre;
    else    
		 SELECT 'Restaurante INEXISTENTE' AS MSJ;
    END IF;
END;


delimiter //
create procedure sp_ConsultaPlatilloChido(in plat nvarchar(100))
begin
	declare existe int;
    set existe = (select count(*) from Platillo where plat = Nombre);
	if existe = 1 then 
		select * from platillo where plat = nombre;
    else    
		 SELECT 'Platillo INEXISTENTE' AS MSJ;
    END IF;
END;
select * from persona;
    