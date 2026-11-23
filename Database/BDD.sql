-- George Georgiev -- 
-- Bolu --
-- Ken --

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

-- ============================================================
-- 5. INSERTIONS INITIALES (DONNÉES DE BASE)
-- ============================================================

INSERT INTO Provinces (Id, Nom, Remarque) VALUES
('AB', N'Alberta',                    NULL),
('BC', N'Colombie-Britannique',       NULL),
('MB', N'Manitoba',                   NULL),
('NB', N'Nouveau-Brunswick',          NULL),
('NL', N'Terre-Neuve et Labrador',    NULL),
('NT', N'Territoires du Nord-Ouest',  NULL),
('NS', N'Nouvelle-Écosse',            NULL),
('NU', N'Nunavut',                    NULL),
('ON', N'Ontario',                    NULL),
('PE', N'Île-du-Prince-Édouard',      NULL),
('QC', N'Québec',                     NULL),
('SK', N'Saskatchewan',               NULL),
('YT', N'Territoire du Yukon',        NULL);
GO

INSERT INTO TypesEmploye (No, Description, Remarque) VALUES
(1, N'Administrateur',            N'Il n''y en a qu''un et son numéro est 1'),
(2, N'Direction',                 NULL),
(3, N'Propriétaire d''un club',   NULL),
(4, N'Employé d''un club',        NULL),
(5, N'Employé Pro-Shop',          NULL),
(6, N'Employé d''un restaurant',  NULL),
(7, N'Professeur de golf',        NULL);
GO

-- Administrateur initial (obligatoire selon l'énoncé : employé #1)
INSERT INTO Employes (No, MotDePasse, Nom, Prenom, Sexe, Age, NoCivique, Rue, Ville, IdProvince, CodePostal, Telephone, Cellulaire, Courriel, SalaireHoraire, NoTypeEmploye, Remarque) VALUES
(1, N'Admin123!', N'Admin', N'Système', 'H', 35, 100, N'Rue Principale', N'Montréal', 'QC', 'H1A1A1', '5145550101', NULL, N'admin@clubgolf.ca', 50.00, 1, N'Administrateur principal');
GO

-- 6 terrains distincts : 3 de 18 trous et 3 de 9 trous
INSERT INTO Terrains (No, Nom, NombreTrous, Description, Remarque) VALUES
(1, N'Golf Les Érables',      18, N'Parcours 18 trous, normale 72',           NULL),
(2, N'Golf Le Faucon',        18, N'Parcours 18 trous boisé, normale 71',     NULL),
(3, N'Golf Rivière-du-Nord',  18, N'Parcours 18 trous en bord de rivière',    NULL),
(4, N'Golf Le Petit Bois',     9, N'Parcours exécutif 9 trous, normale 33',   NULL),
(5, N'Golf Les Cèdres',        9, N'Parcours 9 trous pour débutants',         NULL),
(6, N'Golf du Ruisseau',       9, N'Parcours 9 trous vallonné, normale 35',   NULL);
GO

INSERT INTO TypesAbonnement (No, Description, Remarque) VALUES
(1, N'Personne seule',                        NULL),
(2, N'Âge d''or',                             N'60 ans et plus'),
(3, N'Couple',                                NULL),
(4, N'Famille (couple + 1 enfant)',           NULL),
(5, N'Famille (couple + 2 enfants)',          NULL),
(6, N'Famille (couple + 3 enfants ou plus)',  N'3 à 9 enfants');
GO

INSERT INTO PrixDepensesAbonnements (NoTypeAbonnement, Annee, Prix, DepensesObligatoires, Remarque) VALUES
(1, 2026,  900.00, 450.00, NULL),
(2, 2026,  550.00, 450.00, NULL),
(3, 2026, 1300.00, 750.00, NULL),
(4, 2026, 1800.00, 750.00, NULL),
(5, 2026, 2000.00, 750.00, NULL),
(6, 2026, 2200.00, 750.00, NULL);
GO