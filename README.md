# Projet 2 – Gestion de clubs de golf

420-B56 Bases de données III – Automne 2026

WinForms app using LINQ to SQL, with the database `BDB56Projet2NomEquipe`.

## Team split

| | George – Employees & expenses | Bolu – Members | Ken – Prices, games, reports |
|---|---|---|---|
| **Use cases** | Login, Gestion des employés, Inscription d'une dépense, Déconnexion / Sortie | Abonnement, Réabonnement, Mise à jour des abonnés | Modification prix/dépenses, Inscription partie jouée, Rapports, Statistiques |
| **Tables owned** | `Employes`, `TypesEmploye`, `Services`, `Depenses` | `Abonnements`, `Dependants`, `Reabonnements` | `PrixDepensesAbonnements`, `PartiesJouees`, `Terrains`, `TypesAbonnement`, `Provinces` |
| **Shared helper** | `Session`, permissions | `EstAbonnementActif()` | `GetPrixCourant()` |

## Rules

- Only one person regenerates the `.dbml`, after telling the group. Nobody edits it alone.
- Work only in your own folder (`Forms/Employes`, `Forms/Abonnes`, `Forms/Rapports`).
- Don't touch `MainForm` (Person A owns it).
- Pull often. Commit the `.csproj` changes separately.

---

## Phase 0 – All together (before splitting)

- [ ] Create Git repo + WinForms project (LINQ to SQL)
- [ ] Agree on folder structure + naming conventions
- [ ] Each person writes `CREATE TABLE` for their own tables
  - A: `Employes`, `TypesEmploye`, `Services`, `Depenses`
  - B: `Abonnements`, `Dependants`, `Reabonnements`
  - C: `PrixDepensesAbonnements`, `PartiesJouees`, `Terrains`, `TypesAbonnement`, `Provinces`
- [ ] Merge into one script and check it against the spec
  - [ ] Exact table/field names
  - [ ] No auto-increment PKs, no cascade delete
  - [ ] `int` / `money` only, dates without time
  - [ ] `Sexe` char(1), `IdProvince` char(2), `CodePostal` char(6), `Telephone`/`Cellulaire` char(10)
  - [ ] Everything `NOT NULL` except `Remarque` + `Cellulaire`
- [ ] Seed data
  - [ ] 13 provinces
  - [ ] 6 courses (3 × 18 holes, 3 × 9 holes, unique names)
  - [ ] 6 subscription types + 2026 prices
  - [ ] 7 employee types
  - [ ] Admin = employee #1
- [ ] Test data: employees of every type, members + dependents, games, expenses, services
- [ ] Generate the `.dbml` **once** and commit it
- [ ] Agree on shared function signatures + stub them
  - [ ] `Session` (current employee no + type)
  - [ ] `EstAbonnementActif(idAbonnement)`, written by B
  - [ ] `GetPrixCourant(noType, annee)`, written by C
- [ ] Submit the DB

## Phase 1 – Shared skeleton (Person A, everyone pulls after)

- [ ] Login form + password rules (8+ chars, letter, digit, symbol)
- [ ] `Session` static class
- [ ] `MainForm` with **all 11 buttons**, shown/hidden by role
- [ ] Validation helper (postal code, phone, age, password)
- [ ] Shared access-conflict pattern (`catch ChangeConflictException` → message → reload)
- [ ] Logout + exit

## Person A – Employees & expenses

- [ ] **Gestion des employés**: DataGridView with all employees
- [ ] Add form
  - [ ] Auto number
  - [ ] Can't add an admin
  - [ ] Age 16–65, hourly wage 17–500 $
  - [ ] Validate everything except `Remarque`
- [ ] Edit form (separate): everything except no + type
- [ ] Delete
  - [ ] Not the admin
  - [ ] Can't delete yourself (admin/direction)
  - [ ] Not if they give services
  - [ ] Ask for confirmation
- [ ] **Inscription d'une dépense**
  - [ ] Pick member, amount max 1000 $, remark
  - [ ] Service type set by employee role (admin/direction/owner pick it)
  - [ ] Insert the `Service` if it doesn't exist, auto expense no
  - [ ] Block if subscription expired
  - [ ] All in one transaction
- [ ] Info form after an expense (member, date, amount, service, employee, total spent, amount left to reach the minimum)

## Person B – Members

- [ ] `EstAbonnementActif()` helper (**others need it, do it first**)
- [ ] **Abonnement**
  - [ ] ID `Nom#P` (sequential), date = today
  - [ ] Age: 60+ for Âge d'or, 18+ for others
  - [ ] Spouse (types 3–6): ID `Nom#H0` / `Nom#F0`, 18+
  - [ ] Children (types 4–6): ID `Nom#E1`, `Nom#E2`…, under 18
  - [ ] Type 6 asks how many children (3–9)
  - [ ] All inserts in **one transaction**, success message
- [ ] **Réabonnement**
  - [ ] List renewable subscriptions (id + full name)
  - [ ] Remark
  - [ ] Can't renew twice in the same year
- [ ] **Mise à jour des abonnés**
  - [ ] 2 linked DataGridViews (selecting a member shows their dependents)
  - [ ] Edit directly in the grid, lock the read-only columns
  - [ ] Save button, one transaction

## Person C – Prices, games, reports, stats

- [ ] `GetPrixCourant()` helper
- [ ] **Inscription d'une partie jouée**
  - [ ] Member + course + score + remark, date = today
  - [ ] Blocked if not renewed this year
- [ ] **Modification prix/dépenses**
  - [ ] Grid of all types, edit in the grid
  - [ ] Once per year only
  - [ ] Insert **all** types (changed or not), one transaction
- [ ] **Rapports** (ReportViewer, tabs)
  - [ ] Expenses by employee
  - [ ] Expenses by subscription
  - [ ] Expenses by year
  - [ ] Games by course
  - [ ] Games by subscription
  - [ ] Games by year
- [ ] **Statistiques** with totals + subtotals (tabs)
  - [ ] Subscriptions by year × type
  - [ ] Subscriptions by month (current year) × type
  - [ ] Games by year × course
  - [ ] Games by month (current year) × course
  - [ ] Expenses by year × subscription
  - [ ] Expenses by month (current year) × subscription

## Partial submission (3+ use cases working)

- [ ] A: Gestion des employés + login
- [ ] B: Abonnement
- [ ] C: Partie jouée (or Prix)
- [ ] Merge, test, submit

## Final – All together

- [ ] Merge everything, test each role's permissions (hidden/disabled buttons)
- [ ] Test access conflicts (run 2 instances at once)
- [ ] UI polish (10% of the grade): DatePicker, NumericUpDown, MaskedTextBox, ComboBox, clean layout
- [ ] Final test pass with a fresh DB script
- [ ] Submit
