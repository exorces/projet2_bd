-- George Georgiev -- 
-- Bolu --
-- Ken --

USE BDB56P2BKG

CREATE TABLE Provinces (
    Id       char(2)       NOT NULL,
    Nom      nvarchar(50)  NOT NULL,
    Remarque nvarchar(255) NULL,
    CONSTRAINT PK_Provinces PRIMARY KEY (Id)
);
GO

CREATE TABLE TypesEmployes (
    No INT NOT NULL,
    Description VARCHAR(50),
    Remarque VARCHAR(50)
)

CREATE TABLE Terrains (
    No          int           NOT NULL,
    Nom         nvarchar(50)  NOT NULL,
    NombreTrous int           NOT NULL,
    Description nvarchar(255) NOT NULL,
    Remarque    nvarchar(255) NULL,
    CONSTRAINT PK_Terrains PRIMARY KEY (No),
    CONSTRAINT UQ_Terrains_Nom UNIQUE (Nom),
    CONSTRAINT CK_Terrains_NombreTrous CHECK (NombreTrous IN (9, 18))
);
GO

CREATE TABLE TypesAbonnement (
    No          int           NOT NULL,
    Description nvarchar(50)  NOT NULL,
    Remarque    nvarchar(255) NULL,
    CONSTRAINT PK_TypesAbonnement PRIMARY KEY (No)
);
GO

CREATE TABLE PrixDepensesAbonnements (
    NoTypeAbonnement     int           NOT NULL,
    Annee                int           NOT NULL,
    Prix                 money         NOT NULL,
    DepensesObligatoires money         NOT NULL,
    Remarque             nvarchar(255) NULL,
    CONSTRAINT PK_PrixDepensesAbonnements PRIMARY KEY (NoTypeAbonnement, Annee),
    CONSTRAINT FK_PrixDepensesAbonnements_TypesAbonnement
        FOREIGN KEY (NoTypeAbonnement) REFERENCES TypesAbonnement(No)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT CK_PrixDepensesAbonnements_Prix CHECK (Prix >= 0),
    CONSTRAINT CK_PrixDepensesAbonnements_Depenses CHECK (DepensesObligatoires >= 0)
);
GO

CREATE TABLE Employes (
	No INT NOT NULL,
    MotDePasse VARCHAR(50) NOT NULL,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Sexe CHAR(1) NOT NULL,
    Age INT NOT NULL,
    NoCivique INT NOT NULL,
    Rue VARCHAR(100) NOT NULL,
    Ville VARCHAR(50) NOT NULL,
    IdProvince CHAR(2) NOT NULL,
    CodePostal CHAR(6) NOT NULL,
    Telephone CHAR(10) NOT NULL,
    Cellulaire CHAR(10) NULL,
    Courriel VARCHAR(100) NOT NULL,
    SalaireHoraire MONEY NOT NULL,
    NoTypeEmploye INT NOT NULL,
    Remarque VARCHAR(255) NULL
)

Create table Abonnements(
Id nvarchar(10) primary key not null,
DateAbonnement date not null,
Nom nvarchar(20) not null,
Prenom nvarchar(20) not null,
Sexe nvarchar(1) not null,
DateNaissance date not null,
NoCivique nvarchar(20) not null,
Rue nvarchar(20) not null,
Ville nvarchar(20) not null,
IdProvince nvarchar(2) foreign key References Provinces(Id) not null,
CodePostal nvarchar(6) not null,
Telephone nvarchar(10) not null,
Cellulaire nvarchar(10),
NoTypeAbonnement int foreign Key References TypesAbonnement(No) not null,
Remarque nvarchar(50)
)

CREATE TABLE Services (
    No INT NOT NULL,
    TypeService VARCHAR(50) NOT NULL,
    NoEmploye INT NOT NULL,
    Remarque VARCHAR(50) NOT NULL
)

Create Table Dependants(
Id nvarchar(10) primary key not null,
Nom nvarchar(20) not null,
Prenom nvarchar(20) not null,
Sexe nvarchar(1) not null,
DateNaissance date not null,
IdAbonnement int foreign key references Abonnements(Id) not null,
Remarque nvarchar(50)
)

create table ReAbonnements(
IdAbonnement nvarchar(10) foreign key references Abonnements(Id) not null,
DateRenouvellement date not null,
Remarque nvarchar(50),
primary key (IdAbonnement, DateRenouvellement)
)

CREATE TABLE PartiesJouees (
    IdAbonnement nvarchar(50)  NOT NULL,
    NoTerrain    int           NOT NULL,
    DatePartie   date          NOT NULL,
    Pointage     int           NOT NULL,
    Remarque     nvarchar(255) NULL,
    CONSTRAINT PK_PartiesJouees PRIMARY KEY (IdAbonnement, NoTerrain, DatePartie),
    CONSTRAINT FK