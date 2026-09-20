# Database Optimization and Design for Richard's Hotel Management

A relational database project designed to transition unstructured hotel operational data into a normalized, high-integrity database schema up to the Third Normal Form (3NF).

---

## Project Overview

Richard's Hotel required a centralized relational database to manage core business entities: customer bookings, room inventory, staff operations, and payment transactions. The original dataset suffered from significant redundancy, inconsistent data values, merged records, and operational anomalies (insertion, update, and deletion).

This repository covers the complete end-to-end normalization process, database schema design, entity constraints, and analytical SQL implementations for business reporting.

---

## Database Normalization Process

The data pipeline transitions systematically through three normalization stages:

1. **Unnormalized Form (UNF) to First Normal Form (1NF)**
   - Decomposed multi-valued and composite attributes (e.g., separating concatenated `Customer` fields into atomic columns: `CustomerName`, `CustomerAge`, `CustomerEmail`, `CustomerTelp`).
   - Removed pre-calculated and derived columns (`Total`, `Time Spent`).
   - Resolved merged cell structures by unmerging and populating discrete record values.
   - Enforced row uniqueness using `TransactionID` as the primary key.

2. **First Normal Form (1NF) to Second Normal Form (2NF)**
   - Eliminated partial dependencies by separating distinct functional groups into modular entities: `MsCustomer`, `MsStaff`, `MsRoom`, and `MsTransaction`.
   - Introduced `TransactionHeader` as an associative bridging table linking bookings to customers, staff members, and rooms.

3. **Second Normal Form (2NF) to Third Normal Form (3NF)**
   - Removed transitive dependencies across secondary attributes:
     - Payment details (`PaymentTypeName`, `PaymentFee`) moved to `MsPaymentType`.
     - Room classification and pricing (`RoomType`, `RoomPrice`) decoupled from physical room units into `MsRoomDetail`.

---

## Entity Relationship Diagram (ERD)

The final architecture consists of 7 relational tables designed using Crow's Foot notation:

- **MsCustomer**: Customer master profiles with validation rules and unique email constraints.
- **MsStaff**: Staff employee directory handling operations.
- **MsRoomDetail**: Room tier classification and base pricing (USD).
- **MsRoom**: Physical room inventory and real-time operational status (Available, Occupied, Maintenance).
- **MsPaymentType**: Supported transaction channels and administrative fees.
- **MsTransaction**: Core transaction records detailing stay schedules (Check-in/Check-out timestamps).
- **TransactionHeader**: Central transaction nexus enforcing referential integrity across all entities.

*Referential actions: `ON UPDATE CASCADE` and `ON DELETE RESTRICT` are enforced across foreign keys to protect historical audit trails and prevent orphan records.*

---

## Business Analytical Scenarios (SQL)

The schema includes structured SQL queries addressing critical business use cases:

1. **Revenue Analysis by Payment Channel**
   - Calculates gross revenue per payment method by combining room price, stay duration (`DATEDIFF`), and processing fees.
2. **Staff Productivity Evaluation**
   - Aggregates transaction handling volume per employee across specific billing periods to evaluate operational workload.
3. **Extended Stay Tracking**
   - Identifies guests staying longer than standard thresholds (> 5 days) to streamline housekeeping schedules and guest retention programs.

---

## File Structure

```text
├── database/
│   └── richards_hotel.sql      # DDL table creation scripts, constraints, and sample DML inserts
├── docs/
│   ├── ERD.png                 # Visual schema diagram
│   └── AOL_DB_Report.pdf       # Comprehensive normalization documentation
└── README.md                   # Project documentation
