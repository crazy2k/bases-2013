-- Creo primero todas las tablas que no tienen foreign keys

CREATE TABLE `linea-aerea`.`Encuesta`
(
    `id_encuesta`               int             not null    auto_increment, 
    `viaja_frecuentemente`      varchar(255)    not null, 
    `preferencias_de_comida`    varchar(255)    not null, 
    `ciudades_elegidas`         varchar(255)    not null,
    `clase_mas_frecuente`       varchar(255)    not null, 
    `epoca_mas_frecuente`       varchar(255)    not null, 
    `acompaniantes`             varchar(255)    not null,

    Constraint                  PK_Encuesta     primary key (id_encuesta)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Telefono`
(
    `nro_tel`   int             not null, 
    
    Constraint  PK_Telefono     primary key (nro_tel)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Direccion`
(
    `calle`         varchar(255)    not null, 
    `nro`           int             not null, 
    `localidad`     varchar(255)    not null, 
    `codigo_postal` varchar(50)     not null, 
    
    Constraint      PK_Direccion    primary key (calle, nro)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Pais`
(
    `id_pais`   int             not null, 
    `nombre`    varchar(255)    not null,     

    Constraint  PK_Pais         primary key (id_pais)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Avion`
(
    `id_avion`          int             not null, 
    `modelo`            varchar(255)    not null, 
    `anio_fabricacion`  int             not null,
    `millas`            int             not null,
    `asiestos`          int             not null,
    `origen`            varchar(255)    not null,

    Constraint          PK_Avion        primary key (id_avion)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Tripulante`
(
    `id_trip`       int             not null, 
    `nombre`        varchar(255)    not null,
    
    Constraint      PK_Tripulante   primary key (id_trip)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Estado`
(
    `id_estado`     int             not null, 
    `descripcion`   varchar(255)    not null,
    
    Constraint      PK_Estado   primary key (id_estado)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Clase`
(
    `id_clase`      int             not null, 
    `descripcion`   varchar(255)    not null,
    
    Constraint      PK_Clase   primary key (id_clase)
) engine = InnoDB;


-- Dependen de País


CREATE TABLE `linea-aerea`.`Ciudad`
(
    `id_ciudad` int             not null,
    `id_pais`   int             not null,
    `nombre`    varchar(255)    not null,     

    Constraint  PK_Ciudad       primary key (id_ciudad),

    Constraint  FK_Ciudad       foreign key (id_pais)
                                references Pais(id_pais)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Usuario`
(
    `id_user`           int             not null,
    `username`          varchar(255)    not null, 
    `clave`             varchar(255)    not null, 
    `nacionalidad`      int             not null,

    Constraint          PK_Usuario      primary key (id_user),

    Constraint          FK_Usuario      foreign key (nacionalidad) 
                                        references Pais(id_pais)
) engine = InnoDB;


-- Dependen de Usuario


CREATE TABLE `linea-aerea`.`DatosPersonales`
(
    `id_user`       int            not null, 
    `nombre`        varchar(100)   not null, 
    `apellido`      varchar(100)   not null, 
    `email`         varchar(100)   not null, 
    `profesion`     varchar(100)   not null,
    `nacimiento`    datetime       not null,

    Constraint      PK_Personales  primary key (id_user, nombre, apellido),

    Constraint      FK_Personales  foreign key (id_user) 
                                   references Usuario(id_user)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`DatosTarjeta`
(
    `id_user`       int             not null, 
    `nro_tarjeta`   int             not null, 
    `vencimiento`   datetime        not null,
    
    Constraint      PK_Tarjeta      primary key (id_user, nro_tarjeta),

    Constraint      FK_Tarjeta      foreign key (id_user) 
                                    references Usuario(id_user)
) engine = InnoDB;


-- Depende de Usuario y Teléfono


CREATE TABLE `linea-aerea`.`Atiende`
(
    `id_user`   int                 not null, 
    `nro_tel`   int                 not null, 
    
    Constraint  PK_Atiende          primary key (id_user, nro_tel),

    Constraint  FK_Atiende_User     foreign key (id_user) 
                                    references Usuario(id_user),
    Constraint  FK_Atiende_Tel      foreign key (nro_tel) 
                                    references Telefono(nro_tel)
) engine = InnoDB;


-- Dependen de Usuario y Dirección


CREATE TABLE `linea-aerea`.`Vive`
(
    `id_user`   int             not null, 
    `calle`     varchar(255)    not null, 
    `nro`       int             not null, 

    Constraint PK_Vive          primary key (id_user, calle, nro),

    Constraint FK_Vive_User     foreign key (id_user) 
                                references Usuario(id_user),
    Constraint FK_Vive_Calle    foreign key (calle, nro) 
                                references Direccion(calle, nro)
) engine = InnoDB;


CREATE TABLE `linea-aerea`.`Factura`
(
    `id_user`   int                 not null, 
    `calle`     varchar(255)        not null, 
    `nro`       int                 not null, 

    Constraint  PK_Factura          primary key (id_user, calle, nro),

    Constraint  FK_Factura_User     foreign key (id_user)
                                    references Usuario(id_user),
    Constraint  FK_Factura_Calle    foreign key (calle, nro) 
                                    references Direccion(calle, nro)
) engine = InnoDB;


-- Depende de Avión y Teléfono  CAMBIO AVION POR AEROPUERTO


CREATE TABLE `linea-aerea`.`Responde`
(
    `id_a`     	int                 not null, 
    `nro_tel`   int                 not null, 
    
    Constraint  PK_Responde        primary key (id_a, nro_tel),

    Constraint  FK_Responde_Aer   	foreign key (id_a) 
                                    references Aeropuerto(id_a),
    Constraint  FK_Responde_Tel   	foreign key (nro_tel) 
                                    references Telefono(nro_tel)
) engine = InnoDB;


-- Depende de Avión y Dirección


CREATE TABLE `linea-aerea`.`Esta`
(
    `id_a`     	int                 not null, 
    `calle`     varchar(255)        not null, 
    `nro`       int                 not null, 

    Constraint  PK_Esta             primary key (id_av, calle, nro),

    Constraint  FK_Esta_Aer        foreign key (id_a)
                                     references Aeropuerto(id_a),
    Constraint  FK_Esta_Calle       foreign key (calle, nro) 
                                    references Direccion(calle, nro)
) engine = InnoDB;


-- Depende de Ciudad


CREATE TABLE `linea-aerea`.`Aeropuerto`
(
    `id_a`          int                 not null,     
    `tasa`          float               not null, 
    `transporte`    varchar(255)        not null, 
    `nombre`        varchar(255)        not null, 
    `id_ciudad`     int                 not null,     

    Constraint      PK_Aeropuerto       primary key (id_a),

    Constraint      FK_Aeropuerto       foreign key (id_ciudad)
                                        references Ciudad(id_ciudad)    
) engine = InnoDB;


-- Depende de Aeropuerto


CREATE TABLE `linea-aerea`.`Vuelo`
(
    `id_vuelo`      int             not null,         
    `a_salida`      int             not null,     
    `a_llegada`     int             not null,     

    Constraint      PK_Vuelo        primary key (id_vuelo),

    Constraint      FK_Vuelo_Salida foreign key (a_salida)
                                    references Aeropuerto(id_a),
    Constraint      FK_Vuelo_Llega  foreign key (a_llegada)
                                    references Aeropuerto(id_a)
) engine = InnoDB;


-- Depende de Tripulante y Avión


CREATE TABLE `linea-aerea`.`Tripulado`
(
    `id_trip`   int                 not null,
    `id_av`     int                 not null,
         

    Constraint  PK_Tripulado        primary key (id_trip, id_av),

    Constraint  FK_TripuladoTrip    foreign key (id_trip)
                                    references Tripulante(id_trip),
    Constraint  FK_TripuladoAvion   foreign key (id_av)
                                    references Avion(id_avion)
) engine = InnoDB;


-- Depende de Estado


CREATE TABLE `linea-aerea`.`Reserva`
(
    `id_reserva`    int         not null,         
    `caducidad`     datetime    not null,     
    `id_estado`     int         not null,     

    Constraint  PK_Reserva      primary key (id_reserva),

    Constraint  FK_Reserva      foreign key (id_estado)
                                references Estado(id_estado)
) engine = InnoDB;


-- Depende de Reserva y Usuario


CREATE TABLE `linea-aerea`.`Hace`
(
    `id_reserva`    int         not null,        
    `id_user`       int         not null,     

    Constraint      PK_Hace         primary key (id_reserva, id_user),

    Constraint      FK_Hace_Reserva foreign key (id_reserva)
                                    references Reserva(id_reserva),
    Constraint      FK_Hace_User    foreign key (id_user)
                                    references Usuario(id_user)
) engine = InnoDB;



-- Depende de Avión y Clase


CREATE TABLE `linea-aerea`.`Distribuido`
(
    `id_av`     int                     not null,         
    `id_clase`  int                     not null,     
    `asientos`  int                     not null,     

    Constraint  PK_Distribuido          primary key (id_av, id_clase),

    Constraint  FK_Distribuido_Avion    foreign key (id_av)
                                        references Avion(id_avion),
    Constraint  FK_Distribuido_Clase    foreign key (id_clase)
                                        references Clase(id_clase)
) engine = InnoDB;



-- Depende de Avión y Vuelo


-- VER COMO HACER CON LAS FECHAS

CREATE TABLE `linea-aerea`.`Servicio`
(
    `id_servicio`   int                 not null,         
    `salida`        datetime            not null,     
    `llegada`       datetime            not null,     
    `id_vuelo`      int                 not null,     
    `id_av`         int                 not null,     

    Constraint      PK_Servicio         primary key (id_servicio),

    Constraint      FK_Servicio_Vuelo   foreign key (id_vuelo)
                                        references Vuelo(id_vuelo),
    Constraint      FK_Servicio_Avion   foreign key (id_av)
                                        references Avion(id_avion)                                        
) engine = InnoDB;


-- Depende de Servicio y Clase


CREATE TABLE `linea-aerea`.`Brinda`
(
    `id_serv`   int                 not null, 
    `id_clase`  int                 not null,     
    `precio`    float               not null,     

    Constraint  PK_Brinda           primary key (id_serv, id_clase),

    Constraint  FK_Brinda_Serv      foreign key (id_serv)
                                    references Servicio(id_servicio),
    Constraint  FK_Brinda_Clase     foreign key (id_clase)
                                    references Clase(id_clase)                                   
) engine = InnoDB;


-- Depende de Reserva, Servicio y Clase


CREATE TABLE `linea-aerea`.`Tiene`
(
    `id_res`    int                     not null,         
    `id_serv`   int                     not null,     
    `id_clase`  int                     not null,     
    

    Constraint  PK_Tiene        primary key (id_res, id_serv, id_clase),

    Constraint  FK_Tiene_Res    foreign key (id_res)
                                references Reserva(id_reserva),
    Constraint  FK_Tiene_Serv   foreign key (id_serv)
                                references Servicio(id_servicio),
    Constraint  FK_Tiene_Clase  foreign key (id_clase)
                                references Clase(id_clase)
) engine = InnoDB;
