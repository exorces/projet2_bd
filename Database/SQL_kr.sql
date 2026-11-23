CREATE TABLE Provinces (
    Id       char(2)       NOT NULL,
    Nom      nvarchar(50)  NOT NULL,
    Remarque nvarchar(255) NULL,
    CONSTRAINT PK_Provinces PRIMARY KEY (Id)
);
GO

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

CREATE TABLE PartiesJouees (
    IdAbonnement nvarchar(50)  NOT NULL,
    NoTerrain    int           NOT NULL,
    DatePartie   date          NOT NULL,
    Pointage     int           NOT NULL,
    Remarque     nvarchar(255) NULL,
    CONSTRAINT PK_PartiesJouees PRIMARY KEY (IdAbonnement, NoTerrain, DatePartie),
    CONSTRAINT FK_PartiesJouees_Terrains
        FOREIGN KEY (NoTerrain) REFERENCES Terrains(No)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT CK_PartiesJouees_Pointage CHECK (Pointage > 0)
);
GO

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

-- 6 distinct names: 3 x 18 holes, 3 x 9 holes
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

ALTER TABLE PartiesJouees
    ADD CONSTRAINT FK_PartiesJouees_Abonnements
        FOREIGN KEY (IdAbonnement) REFERENCES Abonnements(Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
