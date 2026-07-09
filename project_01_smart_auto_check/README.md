# Project 01: SmartAutoCheck 🚗🔍

**SmartAutoCheck** is an enterprise-grade relational database schema designed for an Automotive Technical Inspection Center. It dynamically manages user roles, client portfolios, vehicle profiles, inspection scheduling, and complex technical diagnostic reporting.

---

## 📋 Business Rules & Operational Workflow

1. **User Authentication & Authorization (`USERS`):** A centralized table handles core identity and credentials across distinct system layers (`admin`, `inspector`, or `client`).
2. **Profile Specialization (`CLIENTS` & `INSPECTORS`):** Implements structural inheritance. A client or inspector corresponds strictly to one unique user account via a managed 1:1 relation with strict referential integrity (`ON DELETE CASCADE`).
3. **Vehicle Fleet Management (`VEHICLES`):** Clients can register and own multiple vehicles. Vehicles track critical identifiers including unique chassis numbers and precise fuel type classifications (`Essence`, `Diesel`, `Hybride`, `Electrique`).
4. **Appointment Workflow (`RENDEZ_VOUS`):** An appointment tracks a vehicle's scheduled inspection with dynamic states (`en_attente`, `confirme`, `annule`, `termine`) alongside a secured confirmation code tracker.
5. **Technical Auditing (`RAPPORT` & `INSPECTIONS`):** * Each appointment yields a single technical outcome report.
   * The system features a modular `TEST_CATALOG` allowing flexible bounds configuration (minimum/maximum thresholds) and mandatory/optional status markers for tests.
   * The core transactional bridge (`INSPECTIONS`) records granular audit findings (exact found values and specific pass/fail outcomes) linked tightly back to a parent report.

---

## 📐 Database Design (Merise Methodology)

### 1. Conceptual Data Model (MCD)
The relational system's conceptual abstraction highlights business rules, cardinalities, and entity definitions:

![MCD Diagram](./MCD.jpeg)

### 2. Logical Data Model (MLD)
The structured relational transformation optimizing keys, dependencies, and entity mappings:

![MLD Diagram](./MLD.jpeg)

---

## ⚙️ Technical Architecture & Database Constraints

This structural implementation models real-world behaviors through native RDBMS controls:
* **Composite Primary Keys:** Utilized inside junction tables (`id_test`, `id_rapport`) to enforce atomic inspection records.
* **Data Integrity Triggers:** Configured with specific foreign key behaviors including cascading logic (`ON DELETE CASCADE`) and nullable defaults (`ON DELETE SET NULL`) for historic vehicle ownership retention.
* **Strict Type Checking:** Leverages native relational constraint types (`ENUM`, `DECIMAL(10, 2)`, `UNIQUE`) ensuring robust, validated input across all data entries.

---

## 🚀 Getting Started

The complete implementation script including table structures, indexing constraints, and comprehensive production-like seeding data can be executed directly from the file:
📂 **[schema.sql](./schema.sql)**
