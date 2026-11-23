USE BDB56P2BKG;
GO

-- ============================================================
-- 1. PROVINCES (13 provinces et territoires du Canada)
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

-- ============================================================
-- 2. TYPES D'EMPLOYÉ (7 types)
-- ============================================================
INSERT INTO TypesEmploye (No, Description, Remarque) VALUES
(1, N'Administrateur',            N'Il n''y en a qu''un et son numéro est 1'),
(2, N'Direction',                 NULL),
(3, N'Propriétaire d''un club',   NULL),
(4, N'Employé d''un club',        NULL),
(5, N'Employé Pro-Shop',          NULL),
(6, N'Employé d''un restaurant',  NULL),
(7, N'Professeur de golf',        NULL);
GO

-- ============================================================
-- 3. TYPES D'ABONNEMENT (6 types)
-- ============================================================
INSERT INTO TypesAbonnement (No, Description, Remarque) VALUES
(1, N'Personne seule',                        NULL),
(2, N'Âge d''or',                             N'60 ans et plus'),
(3, N'Couple',                                NULL),
(4, N'Famille (couple + 1 enfant)',           NULL),
(5, N'Famille (couple + 2 enfants)',          NULL),
(6, N'Famille (couple + 3 enfants ou plus)',  N'3 à 9 enfants');
GO

-- ============================================================
-- 4. PRIX ET DÉPENSES OBLIGATOIRES (2025 et 2026)
-- ============================================================
INSERT INTO PrixDepensesAbonnements (NoTypeAbonnement, Annee, Prix, DepensesObligatoires, Remarque) VALUES
-- Année 2025 (utile pour tester les statistiques multi-années et réabonnements)
(1, 2025,  850.00, 400.00, N'Tarif 2025'),
(2, 2025,  500.00, 400.00, N'Tarif 2025'),
(3, 2025, 1250.00, 700.00, N'Tarif 2025'),
(4, 2025, 1750.00, 700.00, N'Tarif 2025'),
(5, 2025, 1950.00, 700.00, N'Tarif 2025'),
(6, 2025, 2150.00, 700.00, N'Tarif 2025'),
-- Année 2026 (tarifs officiels de l'énoncé)
(1, 2026,  900.00, 450.00, NULL),
(2, 2026,  550.00, 450.00, NULL),
(3, 2026, 1300.00, 750.00, NULL),
(4, 2026, 1800.00, 750.00, NULL),
(5, 2026, 2000.00, 750.00, NULL),
(6, 2026, 2200.00, 750.00, NULL);
GO

-- ============================================================
-- 5. TERRAINS (6 terrains distincts : trois 18 trous, trois 9 trous)
-- ============================================================
INSERT INTO Terrains (No, Nom, NombreTrous, Description, Remarque) VALUES
(1, N'Golf Les Érables',      18, N'Parcours 18 trous, normale 72',           NULL),
(2, N'Golf Le Faucon',        18, N'Parcours 18 trous boisé, normale 71',     NULL),
(3, N'Golf Rivière-du-Nord',  18, N'Parcours 18 trous en bord de rivière',    NULL),
(4, N'Golf Le Petit Bois',     9, N'Parcours exécutif 9 trous, normale 33',   NULL),
(5, N'Golf Les Cèdres',        9, N'Parcours 9 trous pour débutants',         NULL),
(6, N'Golf du Ruisseau',       9, N'Parcours 9 trous vallonné, normale 35',   NULL);
GO

-- ============================================================
-- 6. EMPLOYÉS (1 par rôle : 1 à 7, mots de passe valides >= 8 car.)
-- ============================================================
INSERT INTO Employes (No, MotDePasse, Nom, Prenom, Sexe, Age, NoCivique, Rue, Ville, IdProvince, CodePostal, Telephone, Cellulaire, Courriel, SalaireHoraire, NoTypeEmploye, Remarque) VALUES
(1, N'Admin123!',   N'Admin',     N'Système',   'H', 38, 100, N'Rue Principale',    N'Sainte-Geneviève', 'QC', 'H9H1A1', '5145550101', '5145559101', N'admin@clubgolf.ca',     65.00, 1, N'Administrateur unique'),
(2, N'Direct123!',  N'Bélanger',  N'Sophie',    'F', 44, 215, N'Boul. Gouin Ouest', N'Pierrefonds',      'QC', 'H8Z1W2', '5145550102', '5145559102', N'sbelanger@clubgolf.ca', 55.00, 2, NULL),
(3, N'Proprio123!', N'Lafontaine',N'Marc',      'H', 52, 45,  N'Chemin du Golf',    N'Île-Bizard',       'QC', 'H9E1A5', '5145550103', NULL,         N'mlafontaine@clubgolf.ca',75.00, 3, N'Propriétaire Golf Les Érables'),
(4, N'Club123!',    N'Côté',      N'Julie',     'F', 24, 88,  N'Rue Saint-Jean',    N'Dollard',          'QC', 'H9G2J1', '5145550104', '5145559104', N'jcote@clubgolf.ca',     21.50, 4, NULL),
(5, N'Proshop123!', N'Mercier',   N'Lucas',     'H', 29, 310, N'Boul. Saint-Charles',N'Kirkland',        'QC', 'H9J2M4', '5145550105', NULL,         N'lmercier@clubgolf.ca',  24.00, 5, N'Responsable Pro-Shop'),
(6, N'Resto123!',   N'Gagnon',    N'Chloé',     'F', 27, 12,  N'Avenue Cartier',    N'Pointe-Claire',    'QC', 'H9S4L8', '5145550106', '5145559106', N'cgagnon@clubgolf.ca',   22.00, 6, N'Serveuse restaurant'),
(7, N'Prof123!',    N'Roy',       N'Alexandre', 'H', 34, 502, N'Rue Bord-du-Lac',   N'Dorval',           'QC', 'H9S2A9', '5145550107', '5145559107', N'aroy@clubgolf.ca',      48.00, 7, N'Professionnel CPGA');
GO

-- ============================================================
-- 7. ABONNEMENTS (Couvre tous les types 1 à 6 + cas de réabonnement)
-- ============================================================
INSERT INTO Abonnements (Id, DateAbonnement, Nom, Prenom, Sexe, DateNaissance, NoCivique, Rue, Ville, IdProvince, CodePostal, Telephone, Cellulaire, Courriel, NoTypeAbonnement, Remarque) VALUES
-- Type 5 (Famille + 2 enfants) - Exemple de l'énoncé (abonné en 2025, renouvelé en 2026)
(N'Gervais1P',   '2025-05-01', N'Gervais',   N'Martin',    'H', '1982-04-15', N'120', N'Rue des Pins',      N'Pierrefonds',      'QC', 'H8Y2C3', '5146201111', '5148881111', N'mgervais@courriel.ca',   5, N'Famille complète'),
-- Type 1 (Personne seule) - Abonné en 2026
(N'Tremblay2P',  '2026-04-10', N'Tremblay',  N'Éric',      'H', '1990-08-22', N'45',  N'Boul. des Sources', N'Dollard',          'QC', 'H9B2K7', '5146202222', NULL,         N'etremblay@courriel.ca',  1, NULL),
-- Type 2 (Âge d'or, >= 60 ans) - Abonné en 2025, renouvelé en 2026
(N'Lavoie3P',    '2025-05-12', N'Lavoie',    N'Hélène',    'F', '1958-11-03', N'78',  N'Rue Notre-Dame',    N'Sainte-Geneviève', 'QC', 'H9H1C4', '5146203333', '5148883333', N'hlavoie@courriel.ca',    2, N'Membre âge d''or'),
-- Type 3 (Couple) - Abonné en 2026
(N'Bouchard4P',  '2026-05-02', N'Bouchard',  N'Daniel',    'H', '1975-02-19', N'312', N'Chemin Sainte-Marie',N'Kirkland',        'QC', 'H9J1V6', '5146204444', NULL,         N'dbouchard@courriel.ca',  3, NULL),
-- Type 4 (Famille + 1 enfant) - Abonné en 2026
(N'Morin5P',     '2026-05-15', N'Morin',     N'Catherine', 'F', '1986-07-09', N'19',  N'Rue des Érables',   N'Île-Bizard',       'QC', 'H9C2P1', '5146205555', '5148885555', N'cmorin@courriel.ca',     4, NULL),
-- Type 6 (Famille + 3 enfants) - Abonné en 2026
(N'Pelletier6P', '2026-06-01', N'Pelletier', N'Patrick',   'H', '1980-09-30', N'410', N'Avenue Donegani',   N'Pointe-Claire',    'QC', 'H9R2V8', '5146206666', '5148886666', N'ppelletier@courriel.ca',6, N'Famille 3 enfants'),
-- Type 1 (Personne seule) - Abonné en 2025 MAIS NON RENOUVELÉ EN 2026 (utile pour tester le blocage des parties et le réabonnement !)
(N'Fortin7P',    '2025-04-20', N'Fortin',    N'Stéphane',  'H', '1988-12-11', N'95',  N'Rue Beaurepaire',   N'Beaconsfield',     'QC', 'H9W3E5', '5146207777', NULL,         N'sfortin@courriel.ca',    1, N'En attente de renouvellement 2026');
GO

-- ============================================================
-- 8. DÉPENDANTS (Conjoints [H|F]0 et Enfants E1, E2, E3)
-- ============================================================
INSERT INTO Dependants (Id, Nom, Prenom, Sexe, DateNaissance, IdAbonnement, Remarque) VALUES
-- Dépendants de Gervais1P (Type 5 : conjointe + 2 enfants)
(N'Gervais1F0',   N'Gervais',   N'Isabelle',  'F', '1984-06-20', N'Gervais1P',   N'Conjointe'),
(N'Gervais1E1',   N'Gervais',   N'Léo',       'H', '2012-03-14', N'Gervais1P',   NULL),
(N'Gervais1E2',   N'Gervais',   N'Emma',      'F', '2015-09-25', N'Gervais1P',   NULL),
-- Dépendant de Bouchard4P (Type 3 : conjointe)
(N'Bouchard4F0',  N'Simard',    N'Nathalie',  'F', '1977-05-18', N'Bouchard4P',  N'Conjointe'),
-- Dépendants de Morin5P (Type 4 : conjoint + 1 enfant)
(N'Morin5H0',     N'Dufour',    N'Sébastien', 'H', '1985-01-27', N'Morin5P',     N'Conjoint'),
(N'Morin5E1',     N'Morin',     N'Camille',   'F', '2016-10-08', N'Morin5P',     NULL),
-- Dépendants de Pelletier6P (Type 6 : conjointe + 3 enfants)
(N'Pelletier6F0', N'Pelletier', N'Mélanie',   'F', '1982-11-12', N'Pelletier6P', N'Conjointe'),
(N'Pelletier6E1', N'Pelletier', N'Noah',      'H', '2011-02-04', N'Pelletier6P', NULL),
(N'Pelletier6E2', N'Pelletier', N'Chloé',     'F', '2013-07-19', N'Pelletier6P', NULL),
(N'Pelletier6E3', N'Pelletier', N'Olivier',   'H', '2017-05-29', N'Pelletier6P', NULL);
GO

-- ============================================================
-- 9. RÉABONNEMENTS
-- ============================================================
INSERT INTO Reabonnements (IdAbonnement, DateRenouvellement, Remarque) VALUES
(N'Gervais1P', '2026-05-01', N'Renouvellement annuel 2026'),
(N'Lavoie3P',  '2026-05-12', N'Renouvellement âge d''or 2026');
GO

-- ============================================================
-- 10. PARTIES JOUÉES (Sur les 6 terrains en 2025 et 2026)
-- ============================================================
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

-- ============================================================
-- 11. SERVICES (Liés aux employés autorisés : 5, 6, 7 et direction 2)
-- ============================================================
INSERT INTO Services (No, TypeService, NoEmploye, Remarque) VALUES
(1, N'Magasin Pro Shop', 5, N'Vente d''équipement et balles'),
(2, N'Restaurant',       6, N'Restauration et terrasse'),
(3, N'Leçon de golf',    7, N'Cours privé et clinique'),
(4, N'Location voiturette', 2, N'Service ajouté par la direction');
GO

-- ============================================================
-- 12. DÉPENSES (2025 et 2026 pour tester les rapports et soldes obligatoires)
-- ============================================================
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