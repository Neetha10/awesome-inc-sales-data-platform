# Awesome Inc. – Universal Sales & Returns Data Platform

This repository contains the **implementation artifacts** for my capstone project
completed as part of **ECE-GY-9941: Advanced Projects** at **NYU Tandon School of Engineering**.

The project implements an **enterprise dual-database architecture** consisting of:
- A **MySQL OLTP system** for transactional workloads
- An **Oracle Autonomous Data Warehouse** for analytics
- A **batch ETL pipeline** with Change Data Capture (CDC)
- Business intelligence and machine learning analysis

---

## System Architecture

**OLTP Layer (MySQL)**
- Fully normalized schema (3NF)
- Enforced PK/FK constraints
- Handles orders, customers, products, and returns

**Data Warehouse Layer (Oracle Autonomous DB)**
- Star schema design
- Dimension tables: Date, Customer, Product
- Fact tables: Order Detail, Returns

**ETL Layer**
- Oracle external tables for CSV extraction
- Staging tables for cleansing and transformation
- PL/SQL `MERGE` procedures for incremental loads
- CDC using `TBL_LAST_DT` timestamps

---

## Repository Structure

```text
oltp/
 ├── ddl/               # MySQL OLTP table definitions
 ├── constraints/       # Primary & foreign key constraints
 └── queries/           # Validation and sample queries

dw/
 ├── ddl/               # Dimension & fact table DDL
 ├── etl/               # External tables, staging, MERGE procedures
 └── analytics/         # Analytical SQL queries

ml/
 └── weka/              # Model configuration and experiment notes

docs/
 ├── architecture.md    # Design decisions & assumptions
 └── screenshots/       # Optional diagrams (no datasets)
