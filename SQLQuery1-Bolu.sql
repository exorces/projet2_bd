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