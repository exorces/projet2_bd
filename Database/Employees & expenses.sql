-- George Georgiev -- 

USE BDB56P2BKG

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

CREATE TABLE TypesEmployes (
    No INT NOT NULL,
    Description VARCHAR(50),
    Remarque VARCHAR(50)
)

CREATE TABLE Services (
    No INT NOT NULL,
    TypeService VARCHAR(50) NOT NULL,
    NoEmploye INT NOT NULL,
    Remarque VARCHAR(50) NOT NULL
)

CREATE TABLE Depense (
    No INT NOT NULL,
    IdAbonnement INT NOT NULL,
    DateDepense DATE NOT NULL,
    Montant INT NOT NULL,
    NoService INT NOT NULL,
    Remarque VARCHAR(50) NOT NULL
)