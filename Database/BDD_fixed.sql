-- George Georgiev --
-- Bolu Ali-Balogun --
-- Ken-Li Roux --

USE BDB56P2BKG;
GO

DROP TABLE IF EXISTS Depenses;
DROP TABLE IF EXISTS PartiesJouees;
DROP TABLE IF EXISTS Reabonnements;
DROP TABLE IF EXISTS Dependants;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS Abonnements;
DROP TABLE IF EXISTS Employes;
DROP TABLE IF EXISTS PrixDepensesAbonnements;
DROP TABLE IF EXISTS Terrains;
DROP TABLE IF EXISTS TypesAbonnement;
DROP TABLE IF EXISTS TypesEmploye;
DROP TABLE IF EXISTS Provinces;
GO

-- ============================================================
-- 1. TABLES
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
-- 2. TABLES ENFANTS
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
    NoCivique        INT           NOT NULL,
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
-- DONNÉES
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

INSERT INTO TypesAbonnement (No, Description, Remarque) VALUES
(1, N'Personne seule',                        NULL),
(2, N'Âge d''or',                             N'60 ans et plus'),
(3, N'Couple',                                NULL),
(4, N'Famille (couple + 1 enfant)',           NULL),
(5, N'Famille (couple + 2 enfants)',          NULL),
(6, N'Famille (couple + 3 enfants ou plus)',  N'3 à 9 enfants');
GO

INSERT INTO PrixDepensesAbonnements (NoTypeAbonnement, Annee, Prix, DepensesObligatoires, Remarque) VALUES
(1, 2025,  850.00, 400.00, N'Tarif 2025'),
(2, 2025,  500.00, 400.00, N'Tarif 2025'),
(3, 2025, 1250.00, 700.00, N'Tarif 2025'),
(4, 2025, 1750.00, 700.00, N'Tarif 2025'),
(5, 2025, 1950.00, 700.00, N'Tarif 2025'),
(6, 2025, 2150.00, 700.00, N'Tarif 2025'),
(1, 2026,  900.00, 450.00, NULL),
(2, 2026,  550.00, 450.00, NULL),
(3, 2026, 1300.00, 750.00, NULL),
(4, 2026, 1800.00, 750.00, NULL),
(5, 2026, 2000.00, 750.00, NULL),
(6, 2026, 2200.00, 750.00, NULL);
GO

INSERT INTO Terrains (No, Nom, NombreTrous, Description, Remarque) VALUES
(1, N'Golf Les Érables',      18, N'Parcours 18 trous, normale 72',           NULL),
(2, N'Golf Le Faucon',        18, N'Parcours 18 trous boisé, normale 71',     NULL),
(3, N'Golf Rivière-du-Nord',  18, N'Parcours 18 trous en bord de rivière',    NULL),
(4, N'Golf Le Petit Bois',     9, N'Parcours exécutif 9 trous, normale 33',   NULL),
(5, N'Golf Les Cèdres',        9, N'Parcours 9 trous pour débutants',         NULL),
(6, N'Golf du Ruisseau',       9, N'Parcours 9 trous vallonné, normale 35',   NULL);
GO

INSERT INTO Employes (No, MotDePasse, Nom, Prenom, Sexe, Age, NoCivique, Rue, Ville, IdProvince, CodePostal, Telephone, Cellulaire, Courriel, SalaireHoraire, NoTypeEmploye, Remarque) VALUES
(1, N'Admin123!',   N'Admin',     N'Système',   'H', 38, 100, N'Rue Principale',    N'Sainte-Geneviève', 'QC', 'H9H1A1', '5145550101', '5145559101', N'admin@clubgolf.ca',     65.00, 1, N'Administrateur unique'),
(2, N'Direct123!',  N'Bélanger',  N'Sophie',    'F', 44, 215, N'Boul. Gouin Ouest', N'Pierrefonds',      'QC', 'H8Z1W2', '5145550102', '5145559102', N'sbelanger@clubgolf.ca', 55.00, 2, NULL),
(3, N'Proprio123!', N'Lafontaine',N'Marc',      'H', 52, 45,  N'Chemin du Golf',    N'Île-Bizard',       'QC', 'H9E1A5', '5145550103', NULL,         N'mlafontaine@clubgolf.ca',75.00, 3, N'Propriétaire Golf Les Érables'),
(4, N'Club123!',    N'Côté',      N'Julie',     'F', 24, 88,  N'Rue Saint-Jean',    N'Dollard',          'QC', 'H9G2J1', '5145550104', '5145559104', N'jcote@clubgolf.ca',     21.50, 4, NULL),
(5, N'Proshop123!', N'Mercier',   N'Lucas',     'H', 29, 310, N'Boul. Saint-Charles',N'Kirkland',        'QC', 'H9J2M4', '5145550105', NULL,         N'lmercier@clubgolf.ca',  24.00, 5, N'Responsable Pro-Shop'),
(6, N'Resto123!',   N'Gagnon',    N'Chloé',     'F', 27, 12,  N'Avenue Cartier',    N'Pointe-Claire',    'QC', 'H9S4L8', '5145550106', '5145559106', N'cgagnon@clubgolf.ca',   22.00, 6, N'Serveuse restaurant'),
(7, N'Prof123!',    N'Roy',       N'Alexandre', 'H', 34, 502, N'Rue Bord-du-Lac',   N'Dorval',           'QC', 'H9S2A9', '5145550107', '5145559107', N'aroy@clubgolf.ca',      48.00, 7, N'Professionnel CPGA');
GO

INSERT INTO Abonnements (Id, DateAbonnement, Nom, Prenom, Sexe, DateNaissance, NoCivique, Rue, Ville, IdProvince, CodePostal, Telephone, Cellulaire, Courriel, NoTypeAbonnement, Remarque) VALUES
(N'Gervais1P',   '2025-05-01', N'Gervais',   N'Martin',    'H', '1982-04-15', 120, N'Rue des Pins',      N'Pierrefonds',      'QC', 'H8Y2C3', '5146201111', '5148881111', N'mgervais@courriel.ca',   5, N'Famille complète'),
(N'Tremblay2P',  '2026-04-10', N'Tremblay',  N'Éric',      'H', '1990-08-22', 45,  N'Boul. des Sources', N'Dollard',          'QC', 'H9B2K7', '5146202222', NULL,         N'etremblay@courriel.ca',  1, NULL),
(N'Lavoie3P',    '2025-05-12', N'Lavoie',    N'Hélène',    'F', '1958-11-03', 78,  N'Rue Notre-Dame',    N'Sainte-Geneviève', 'QC', 'H9H1C4', '5146203333', '5148883333', N'hlavoie@courriel.ca',    2, N'Membre âge d''or'),
(N'Bouchard4P',  '2026-05-02', N'Bouchard',  N'Daniel',    'H', '1975-02-19', 312, N'Chemin Sainte-Marie',N'Kirkland',        'QC', 'H9J1V6', '5146204444', NULL,         N'dbouchard@courriel.ca',  3, NULL),
(N'Morin5P',     '2026-05-15', N'Morin',     N'Catherine', 'F', '1986-07-09', 19,  N'Rue des Érables',   N'Île-Bizard',       'QC', 'H9C2P1', '5146205555', '5148885555', N'cmorin@courriel.ca',     4, NULL),
(N'Pelletier6P', '2026-06-01', N'Pelletier', N'Patrick',   'H', '1980-09-30', 410, N'Avenue Donegani',   N'Pointe-Claire',    'QC', 'H9R2V8', '5146206666', '5148886666', N'ppelletier@courriel.ca',6, N'Famille 3 enfants'),
(N'Fortin7P',    '2025-04-20', N'Fortin',    N'Stéphane',  'H', '1988-12-11', 95,  N'Rue Beaurepaire',   N'Beaconsfield',     'QC', 'H9W3E5', '5146207777', NULL,         N'sfortin@courriel.ca',    1, N'En attente de renouvellement 2026');
GO

INSERT INTO Dependants (Id, Nom, Prenom, Sexe, DateNaissance, IdAbonnement, Remarque) VALUES
(N'Gervais1F0',   N'Gervais',   N'Isabelle',  'F', '1984-06-20', N'Gervais1P',   N'Conjointe'),
(N'Gervais1E1',   N'Gervais',   N'Léo',       'H', '2012-03-14', N'Gervais1P',   NULL),
(N'Gervais1E2',   N'Gervais',   N'Emma',      'F', '2015-09-25', N'Gervais1P',   NULL),
(N'Bouchard4F0',  N'Simard',    N'Nathalie',  'F', '1977-05-18', N'Bouchard4P',  N'Conjointe'),
(N'Morin5H0',     N'Dufour',    N'Sébastien', 'H', '1985-01-27', N'Morin5P',     N'Conjoint'),
(N'Morin5E1',     N'Morin',     N'Camille',   'F', '2016-10-08', N'Morin5P',     NULL),
(N'Pelletier6F0', N'Pelletier', N'Mélanie',   'F', '1982-11-12', N'Pelletier6P', N'Conjointe'),
(N'Pelletier6E1', N'Pelletier', N'Noah',      'H', '2011-02-04', N'Pelletier6P', NULL),
(N'Pelletier6E2', N'Pelletier', N'Chloé',     'F', '2013-07-19', N'Pelletier6P', NULL),
(N'Pelletier6E3', N'Pelletier', N'Olivier',   'H', '2017-05-29', N'Pelletier6P', NULL);
GO

INSERT INTO Reabonnements (IdAbonnement, DateRenouvellement, Remarque) VALUES
(N'Gervais1P', '2026-05-01', N'Renouvellement annuel 2026'),
(N'Lavoie3P',  '2026-05-12', N'Renouvellement âge d''or 2026');
GO

INSERT INTO PartiesJouees (IdAbonnement, NoTerrain, DatePartie, Pointage, Remarque) VALUES
(N'Gervais1P',   1, '2025-06-15', 84, N'Très belle journée'),
(N'Gervais1P',   1, '2026-05-20', 81, NULL),
(N'Gervais1P',   4, '2026-06-10', 38, N'Partie 9 trous en famille'),
(N'Tremblay2P',  2, '2026-05-18', 79, NULL),
(N'Tremblay2P',  3, '2026-06-22', 82, NULL),
(N'Lavoie3P',    5, '2025-07-04', 42, NULL),
(N'Lavoie3P',    5, '2026-06-05', 40, NULL),
(N'Bouchard4P',  3, '2026-06-14', 88, NULL),
(N'Morin5P',     6, '2026-06-25', 44, NULL),
(N'Pelletier6P', 2, '2026-07-02', 85, NULL);
GO

INSERT INTO Services (No, TypeService, NoEmploye, Remarque) VALUES
(1, N'Magasin Pro Shop', 5, N'Vente d''équipement et balles'),
(2, N'Restaurant',       6, N'Restauration et terrasse'),
(3, N'Leçon de golf',    7, N'Cours privé et clinique'),
(4, N'Location voiturette', 2, N'Service ajouté par la direction');
GO

INSERT INTO Depenses (No, IdAbonnement, DateDepense, Montant, NoService, Remarque) VALUES
-- Dépenses 2025
(1,  N'Gervais1P',   '2025-06-15', 250.00, 1, N'Achat bâtons junior'),
(2,  N'Gervais1P',   '2025-07-20', 480.00, 2, N'Soupers au restaurant'),
(3,  N'Lavoie3P',    '2025-07-04', 410.00, 2, N'Dîners terrasse'),
-- Dépenses 2026
(4,  N'Gervais1P',   '2026-05-20', 320.00, 1, N'Chaussures et balles Pro-Shop'),
(5,  N'Gervais1P',   '2026-06-10', 185.50, 2, N'Dîner familial'),
(6,  N'Tremblay2P',  '2026-05-18', 150.00, 3, N'Leçon de golf 1h'),
(7,  N'Tremblay2P',  '2026-06-22', 210.00, 1, N'Vêtements golf'),
(8,  N'Lavoie3P',    '2026-06-05', 125.00, 2, N'Lunch au club'),
(9,  N'Bouchard4P',  '2026-06-14', 340.00, 2, N'Souper couple'),
(10, N'Morin5P',     '2026-06-25', 275.00, 3, N'Cours initiation'),
(11, N'Pelletier6P', '2026-07-02', 420.00, 1, N'Équipement enfants'),
(12, N'Pelletier6P', '2026-07-15', 195.00, 4, N'Location 2 voiturettes');
GO
