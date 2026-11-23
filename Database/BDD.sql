-- George Georgiev -- 
-- Bolu Ali-Balogun --
-- Ken-Li Roux --

USE BDB56P2BKG;
GO

-- ============================================================
-- 1. TABLES PARENTES INDÉPENDANTES
-- ============================================================

CREATE TABLE Provinces (
    Id       CHAR(2)       NOT NULL,
    Nom      NVARCHAR(50)  NOT NULL,
    Remarque NVARCHAR(255) NULL,
    CONSTRAINT PK_Provinces PRIMARY KEY (Id)
);
GO

CREATE TABLE TypesEmploye (
    No          INT           NOT NULL,
    Description NVARCHAR(50)  NOT NULL,
    Remarque    NVARCHAR(255) NULL,
    CONSTRAINT PK_TypesEmploye PRIMARY KEY (No)
);
GO

CREATE TABLE TypesAbonnement (
    No          INT           NOT NULL,
    Description NVARCHAR(50)  NOT NULL,
    Remarque    NVARCHAR(255) NULL,
    CONSTRAINT PK_TypesAbonnement PRIMARY KEY (No)
);
GO

CREATE TABLE Terrains (
    No          INT           NOT NULL,
    Nom         NVARCHAR(50)  NOT NULL,
    NombreTrous INT           NOT NULL,
    Description NVARCHAR(255) NOT NULL,
    Remarque    NVARCHAR(255) NULL,
    CONSTRAINT PK_Terrains PRIMARY KEY (No)
);
GO

-- ============================================================
-- 2. TABLES ENFANTS DE NIVEAU 1
-- ============================================================

CREATE TABLE PrixDepensesAbonnements (
    NoTypeAbonnement     INT           NOT NULL,
    Annee                INT           NOT NULL,
    Prix                 MONEY         NOT NULL,
    DepensesObligatoires MONEY         NOT NULL,
    Remarque             NVARCHAR(255) NULL,
    CONSTRAINT PK_PrixDepensesAbonnements PRIMARY KEY (NoTypeAbonnement, Annee),
    CONSTRAINT FK_PrixDepensesAbonnements_TypesAbonnement
        FOREIGN KEY (NoTypeAbonnement) REFERENCES TypesAbonnement(No)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

CREATE TABLE Employes (
    No             INT           NOT NULL,
    MotDePasse     NVARCHAR(50)  NOT NULL,
    Nom            NVARCHAR(50)  NOT NULL,
    Prenom         NVARCHAR(50)  NOT NULL,
    Sexe           CHAR(1)       NOT NULL,
    Age            INT           NOT NULL,
    NoCivique      INT           NOT NULL,
    Rue            NVARCHAR(100) NOT NULL,
    Ville          NVARCHAR(50)  NOT NULL,
    IdProvince     CHAR(2)       NOT NULL,
    CodePostal     CHAR(6)       NOT NULL,
    Telephone      CHAR(10)      NOT NULL,
    Cellulaire     CHAR(10)      NULL,
    Courriel       NVARCHAR(100) NOT NULL,
    SalaireHoraire MONEY         NOT NULL,
    NoTypeEmploye  INT           NOT NULL,
    Remarque       NVARCHAR(255) NULL,
    CONSTRAINT PK_Employes PRIMARY KEY (No),
    CONSTRAINT FK_Employes_Provinces
        FOREIGN KEY (IdProvince) REFERENCES Provinces(Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Employes_TypesEmploye
        FOREIGN KEY (NoTypeEmploye) REFERENCES TypesEmploye(No)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

CREATE TABLE Abonnements (
    Id               NVARCHAR(50)  NOT NULL,
    DateAbonnement   DATE          NOT NULL,
    Nom              NVARCHAR(50)  NOT NULL,
    Prenom           NVARCHAR(50)  NOT NULL,
    Sexe             CHAR(1)       NOT NULL,
    DateNaissance    DATE          NOT NULL,
    NoCivique        NVARCHAR(20)  NOT NULL,
    Rue              NVARCHAR(100) NOT NULL,
    Ville            NVARCHAR(50)  NOT NULL,
    IdProvince       CHAR(2)       NOT NULL,
    CodePostal       CHAR(6)       NOT NULL,
    Telephone        CHAR(10)      NOT NULL,
    Cellulaire       CHAR(10)      NULL,
    Courriel         NVARCHAR(100) NOT NULL,
    NoTypeAbonnement INT           NOT NULL,
    Remarque         NVARCHAR(255) NULL,
    CONSTRAINT PK_Abonnements PRIMARY KEY (Id),
    CONSTRAINT FK_Abonnements_Provinces
        FOREIGN KEY (IdProvince) REFERENCES Provinces(Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Abonnements_TypesAbonnement
        FOREIGN KEY (NoTypeAbonnement) REFERENCES TypesAbonnement(No)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- ============================================================
-- 3. TABLES ENFANTS DE NIVEAU 2
-- ============================================================

CREATE TABLE Services (
    No          INT           NOT NULL,
    TypeService NVARCHAR(50)  NOT NULL,
    NoEmploye   INT           NOT NULL,
    Remarque    NVARCHAR(255) NULL,
    CONSTRAINT PK_Services PRIMARY KEY (No),
    CONSTRAINT FK_Services_Employes
        FOREIGN KEY (NoEmploye) REFERENCES Employes(No)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

CREATE TABLE Dependants (
    Id            NVARCHAR(50)  NOT NULL,
    Nom           NVARCHAR(50)  NOT NULL,
    Prenom        NVARCHAR(50)  NOT NULL,
    Sexe          CHAR(1)       NOT NULL,
    DateNaissance DATE          NOT NULL,
    IdAbonnement  NVARCHAR(50)  NOT NULL,
    Remarque      NVARCHAR(255) NULL,
    CONSTRAINT PK_Dependants PRIMARY KEY (Id),
    CONSTRAINT FK_Dependants_Abonnements
        FOREIGN KEY (IdAbonnement) REFERENCES Abonnements(Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

CREATE TABLE Reabonnements (
    IdAbonnement       NVARCHAR(50)  NOT NULL,
    DateRenouvellement DATE          NOT NULL,
    Remarque           NVARCHAR(255) NULL,
    CONSTRAINT PK_Reabonnements PRIMARY KEY (IdAbonnement, DateRenouvellement),
    CONSTRAINT FK_Reabonnements_Abonnements
        FOREIGN KEY (IdAbonnement) REFERENCES Abonnements(Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

CREATE TABLE PartiesJouees (
    IdAbonnement NVARCHAR(50)  NOT NULL,
    NoTerrain    INT           NOT NULL,
    DatePartie   DATE          NOT NULL,
    Pointage     INT           NOT NULL,
    Remarque     NVARCHAR(255) NULL,
    CONSTRAINT PK_PartiesJouees PRIMARY KEY (IdAbonnement, NoTerrain, DatePartie),
    CONSTRAINT FK_PartiesJouees_Abonnements
        FOREIGN KEY (IdAbonnement) REFERENCES Abonnements(Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_PartiesJouees_Terrains
        FOREIGN KEY (NoTerrain) REFERENCES Terrains(No)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- ============================================================
-- 4. TABLE ENFANT DE NIVEAU 3
-- ============================================================

CREATE TABLE Depenses (
    No           INT           NOT NULL,
    IdAbonnement NVARCHAR(50)  NOT NULL,
    DateDepense  DATE          NOT NULL,
    Montant      MONEY         NOT NULL,
    NoService    INT           NOT NULL,
    Remarque     NVARCHAR(255) NULL,
    CONSTRAINT PK_Depenses PRIMARY KEY (No),
    CONSTRAINT FK_Depenses_Abonnements
        FOREIGN KEY (IdAbonnement) REFERENCES Abonnements(Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Depenses_Services
        FOREIGN KEY (NoService) REFERENCES Services(No)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO
