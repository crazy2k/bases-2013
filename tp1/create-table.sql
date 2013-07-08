-- Creo primero todas las tablas que no tienen foreign keys

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Encuesta`
(
    `id_encuesta`               int             not null    auto_increment, 
    `viaja_frecuentemente`      varchar(255)    not null, 
    `preferencias_de_comida`    varchar(255)    not null, 
    `ciudades_elegidas`         varchar(255)    not null,
    `clase_mas_frecuente`       varchar(255)    not null, 
    `epoca_mas_frecuente`       varchar(255)    not null, 
    `acompaniantes`             varchar(255)    not null

    Constraint                  PK_Encuesta     primary key (id_encuesta)
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Telefono`
(
    `nro_tel`   int             not null, 
    
    Constraint  PK_Telefono     primary key (nro_tel)
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Direccion`
(
    `calle`         varchar(255)    not null, 
    `nro`           int             not null, 
    `localidad`     varchar(255)    not null, 
    `codigo_postal` varchar(50)     not null, 
    
    Constraint      PK_Direccion    primary key (calle, nro)
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Usuario`
(
    `id_user`           int             not null    auto_increment,
    `username`          varchar(255)    not null, 
    `clave`             varchar(255)    not null, 
    `nacionalidad`      varchar(255)    not null,

    Constraint          PK_Usuario      primary key (id_user),

    Constraint          FK_Usuario      foreign key (nacionalidad) 
                                        references Pais(id_pais)
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`DatosPersonales`
(
    `id_user`           int            not null, 
    `nombre`            varchar(100)   not null, 
    `apellido`          varchar(100)   not null, 
    `email`             varchar(100)   not null, 
    `profesion`         varchar(100)   not null,
    `fecha_nacimiento`  datetime       not null,

    Constraint          PK_Personales  primary key (id_user, nombre, apellido),

    Constraint          FK_Personales  foreign key (id_user) 
                                       references Usuario(id_user)
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`DatosTarjeta`
(
    `id_user`           int             not null, 
    `nro_tarjeta`       int             not null, 
    `fecha_vencimiento` datetime        not null,
    
    Constraint          PK_Tarjeta      primary key (id_user, nro_tarjeta),

    Constraint          FK_Tarjeta      foreign key (id_user) 
                                        references Usuario(id_user)
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Atiende`
(
    `id_user`   int                 not null, 
    `nro_tel`   int                 not null, 
    
    Constraint  PK_Atiende          primary key (id_user, nro_tel),

    Constraint  FK_Atiende_User     foreign key (id_user) 
                                    references Usuario(id_user),
    Constraint  FK_Atiende_Tel      foreign key (nro_tel) 
                                    references Telefono(nro_tel),
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Responde`
(
    `id_a`      int                 not null, 
    `nro_tel`   int                 not null, 
    
    Constraint  PK_Responde         primary key (id_a, nro_tel),

    Constraint  FK_Responde_Avion   foreign key (id_a) 
                                    references Avion(id_a),
    Constraint  FK_Responde_Tel     foreign key (nro_tel) 
                                    references Telefono(nro_tel),
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Vive`
(
    `id_user`   int             not null, 
    `calle`     varchar(255)    not null, 
    `nro`       int             not null, 

    Constraint PK_Vive          primary key (id_user, calle, nro),

    Constraint FK_Vive_User     foreign key (id_user) 
                                references Usuario(id_user),
    Constraint FK_Vive_Calle    foreign key (calle) 
                                references Direccion(calle),
    Constraint FK_Vive_Nro      foreign key (nro) 
                                references Direccion(nro),
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Factura`
(
    `id_user`   int             not null, 
    `calle`     varchar(255)    not null, 
    `nro`       int             not null, 

    Constraint PK_Factura primary key (id_user, calle, nro),
    Constraint FK_Factura foreign key (id_user) references Usuario(id_user)
) engine = InnoDB;

-------------------------------------------------------------------------------

CREATE TABLE `linea-aerea`.`Esta`
(
    `id_a`      int             not null, 
    `calle`     varchar(255)    not null, 
    `nro`       int             not null, 

    Constraint PK_Vive primary key (id_a, calle, nro),
    Constraint FK_Vive foreign key (id_a) references Avion(id_a)
) engine = InnoDB;