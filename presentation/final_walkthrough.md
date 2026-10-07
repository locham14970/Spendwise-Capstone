# SpendWise Capstone Final Walkthrough

## 1. Project Overview

SpendWise is a multi-tenant budget and expense management system designed to help users manage budgets, categories, and expenses securely.

## 2. Requirements

The system supports:

- User accounts
- Personal budgets
- Expense categories
- Expense recording
- Budget utilization analysis
- Audit logging
- User-level data isolation
- Backup and restore

## 3. Database Design

Core PostgreSQL tables:

- users
- budgets
- categories
- expenses
- audit_logs

The ER diagram defines the relationships and cardinalities between these entities.

## 4. Versioned Database Migrations

Flyway was used to manage repeatable database changes.

Migration sequence:

- V1 - Core tables
- V2 - Audit log indexes
- V3 - Audit triggers
- V4 - Row-Level Security
- V5 - Demo seed data
- V6 - Expense user index
- V7 - Expense user/date index

A clean database successfully migrated through all seven versions.

## 5. Redis Integration

PostgreSQL remains the source of truth for financial and relational data.

Redis was introduced as a cache for frequently requested dashboard summaries.

Example cached dashboard:

- Budget: 50,000
- Expenses: 2,000
- Remaining: 48,000

## 6. Analytical Queries

The system supports analytical queries for:

- Spending by category
- Budget utilization
- Daily spending trends

These queries demonstrate how the database can support financial reporting.

## 7. Query Optimization

The expense query was tested using EXPLAIN ANALYZE.

Before optimization:

- Sequential scan
- 1.249 ms execution time
- 322 matching rows
- 9,680 rows removed by filter

After adding the composite index:

`idx_expenses_user_date`

- Bitmap Index Scan
- 0.778 ms execution time
- 322 matching rows
- Index condition applied to user_id and expense_date

The controlled comparison showed approximately 37.7% lower execution time.

## 8. Security

Security controls include:

- Least-privilege database roles
- Read-only application role
- Controlled write role
- Row-Level Security
- User isolation using app.user_id
- Audit logging
- Password-hash field
- Parameterized-query requirement

## 9. Backup and Restore

A PostgreSQL custom-format backup was created using pg_dump.

The backup was verified using pg_restore.

A separate `capstone_restore_test` database was created and successfully restored.

Restored data:

- Users: 2
- Budgets: 1
- Categories: 3
- Expenses: 2
- Audit logs: 8

The temporary restore database was then removed.

## 10. GitHub

The project is version controlled with Git and hosted on GitHub.

Repository:

https://github.com/locham14970/Spendwise-Capstone

The repository contains:

- Documentation
- Flyway migrations
- ER diagram
- Security checklist
- Project evidence

The PostgreSQL backup is excluded from Git using `.gitignore`.

## 11. Conclusion

SpendWise demonstrates a secure and scalable database foundation for a multi-tenant budget and expense management application.

The project combines:

- PostgreSQL for relational financial data
- Flyway for controlled migrations
- Redis for dashboard caching
- RLS for tenant isolation
- Audit logging for accountability
- Indexing for query optimization
- Backup and restore for disaster recovery
- GitHub for version control
