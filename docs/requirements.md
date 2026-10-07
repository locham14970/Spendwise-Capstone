# SpendWise – Requirements Summary

## 1. Project Overview

SpendWise is a budget and expense management system designed to help users manage their personal finances. The system allows users to create budgets, organize expenses into categories, record expenses, and monitor their spending.

PostgreSQL will be used as the primary relational database because the system requires structured relationships, transactions, constraints, security controls, and analytical queries. Redis will be integrated as a caching layer for frequently requested dashboard summaries.

## 2. Functional Requirements

The system shall allow users to:

1. Register and maintain their user profile.
2. Create one or more budgets.
3. Create expense categories.
4. Record expenses against a selected budget and category.
5. View expenses belonging to their account.
6. Calculate total spending and remaining budget.
7. View spending summaries by category and date.
8. Update or delete permitted records.
9. Maintain an audit history of important database changes.

## 3. Security Requirements

The system shall:

* Use separate database roles for application access.
* Prevent users from accessing unauthorized data.
* Use Row-Level Security (RLS) for user-owned data.
* Protect sensitive user information.
* Record important INSERT, UPDATE, and DELETE operations in an audit log.
* Use parameterized queries to prevent SQL injection.
* Avoid using a PostgreSQL superuser for normal application operations.

## 4. Performance Requirements

The system shall support efficient queries for:

* Monthly expense summaries.
* Expenses belonging to a specific user.
* Expenses filtered by category.
* Budget spending calculations.

Indexes will be added where appropriate. Query performance will be measured using EXPLAIN ANALYZE before and after optimization.

## 5. Backup and Recovery Requirements

The database shall be backed up using PostgreSQL pg_dump. A test restore shall be performed to verify that the backup can successfully recover the database.

## 6. NoSQL Requirement

Redis will be used for caching frequently requested dashboard information, such as total spending and remaining budget.

PostgreSQL will remain the source of truth for financial records. Redis is appropriate for cached dashboard results because frequently requested information can be retrieved quickly without repeatedly performing the same aggregation queries against PostgreSQL.

## 7. Main Entities

The main database entities are:

* Users
* Budgets
* Categories
* Expenses
* Audit Logs

## 8. Expected Outcome

The completed system should provide a secure, maintainable, and performance-tested database architecture that demonstrates database design, versioned migrations, NoSQL integration, query optimization, security, backup, recovery, and professional documentation.
