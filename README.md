PROJET 2 – CLUBS DE GOLF – CHECKLIST

================================================
PHASE 0 – ALL TOGETHER (before splitting)
================================================
[ ] Create Git repo + WinForms project (LINQ to SQL)
[ ] Agree on folder structure (Forms/Employes, Forms/Abonnes,
    Forms/Rapports) + naming conventions
[ ] Each person writes CREATE TABLE for their own tables
      A: Employes, TypesEmploye, Services, Depenses
      B: Abonnements, Dependants, Reabonnements
      C: PrixDepensesAbonnements, PartiesJouees, Terrains,
         TypesAbonnement, Provinces
[ ] Merge into one script and check it against the spec
      - exact table/field names
      - no auto-increment PKs, no cascade delete
      - int / money only, dates without time
      - Sexe char(1), IdProvince char(2), CodePostal char(6),
        Telephone/Cellulaire char(10)
      - everything NOT NULL except Remarque + Cellulaire
[ ] Seed data: 13 provinces, 6 courses (3x18 + 3x9 holes, unique names),
    6 subscription types + 2026 prices, 7 employee types,
    admin = employee #1
[ ] Test data: employees of every type, members + dependents,
    games, expenses, services
[ ] Generate the .dbml ONCE, commit it (nobody edits it alone)
[ ] Agree on shared function signatures + stub them:
      Session (current employee no + type)
      EstAbonnementActif(idAbonnement)       -> B writes it
      GetPrixCourant(noType, annee)          -> C writes it
[ ] Submit the DB (BDB56Projet2NomEquipe)

================================================
PHASE 1 – SHARED SKELETON (Person A, everyone pulls after)
================================================
[ ] Login form + password rules (8+ chars, letter, digit, symbol)
[ ] Session static class
[ ] MainForm with ALL 11 buttons, shown/hidden by role
[ ] Validation helper (postal code, phone, age, password)
[ ] Shared access-conflict pattern
    (catch ChangeConflictException -> message -> reload)
[ ] Logout + exit

================================================
PERSON A – EMPLOYEES & EXPENSES
================================================
[ ] Gestion des employés: DataGridView with all employees
[ ] Add form: auto number, can't add an admin, age 16–65,
    hourly wage 17–500$, validate everything except Remarque
[ ] Edit form (separate): everything except no + type
[ ] Delete: not the admin, can't delete yourself (admin/direction),
    not if they give services, ask for confirmation
[ ] Inscription d'une dépense:
      - pick member, amount max 1000$, remark
      - service type set by employee role (admin/direction/owner pick it)
      - insert the Service if it doesn't exist, auto expense no
      - block if subscription expired
      - all in one transaction
[ ] Info form after an expense (member, date, amount, service,
    employee, total spent, amount left to reach the minimum)

================================================
PERSON B – MEMBERS
================================================
[ ] EstAbonnementActif() helper (others need it!)
[ ] Abonnement:
      - ID NomN P (sequential), date = today
      - age: 60+ for Âge d'or, 18+ for others
      - spouse (types 3–6): ID NomN H/F 0, 18+
      - children (types 4–6): ID NomN E#, under 18,
        type 6 asks how many (3–9)
      - all inserts in ONE transaction, success message
[ ] Réabonnement: list renewable subs, remark,
    can't renew twice in the same year
[ ] Mise à jour des abonnés:
      - 2 linked DataGridViews (selecting a member shows their dependents)
      - edit directly in the grid, lock the read-only columns
      - Save button, one transaction

================================================
PERSON C – PRICES, GAMES, REPORTS, STATS
================================================
[ ] GetPrixCourant() helper
[ ] Inscription d'une partie jouée: member + course + score
    + remark, date = today, blocked if not renewed this year
[ ] Modification prix/dépenses: grid of all types, once per year,
    insert ALL types (changed or not), one transaction
[ ] 6 reports (ReportViewer, tabs)
      - expenses by employee / by subscription / by year
      - games by course / by subscription / by year
[ ] 6 stats with totals + subtotals (tabs)
      - subscriptions by year x type / by month (current year) x type
      - games by year x course / by month x course
      - expenses by year x subscription / by month x subscription

================================================
PARTIAL SUBMISSION
================================================
[ ] A: Gestion des employés + login working
[ ] B: Abonnement working
[ ] C: Partie jouée (or Prix) working
[ ] Merge, test, submit

================================================
FINAL – ALL TOGETHER
================================================
[ ] Merge everything, test each role's permissions
    (hidden/disabled buttons per role)
[ ] Test access conflicts (run 2 instances at once)
[ ] UI polish, 10% of the grade: DatePicker, NumericUpDown,
    MaskedTextBox, ComboBox, clean layout
[ ] Final test pass with fresh DB script
[ ] Submit
