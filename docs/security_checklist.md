# SpendWise Capstone Security Checklist

## 1. Least Privilege

- [x] PostgreSQL superuser `postgres` is separated from application roles.
- [x] `app_read` has read-only table privileges.
- [x] `app_write` has controlled SELECT, INSERT, UPDATE, and DELETE privileges.
- [x] `app_write` cannot log in directly.
- [x] `api` has controlled application privileges.

Evidence:
- PostgreSQL roles verified with `\du`.
- Table privileges verified using `information_schema.role_table_grants`.

## 2. Row-Level Security

- [x] RLS enabled on `budgets`.
- [x] RLS enabled on `categories`.
- [x] RLS enabled on `expenses`.
- [x] Policies restrict rows using `app.user_id`.
- [x] Both USING and WITH CHECK conditions are defined.

Policies:
- `budgets_user_isolation`
- `categories_user_isolation`
- `expenses_user_isolation`

## 3. Sensitive Data Protection

- [x] Users table stores `password_hash` instead of a plain `password` field.
- [x] `password_hash` is NOT NULL.
- [ ] Production application must use a strong password hashing algorithm such as Argon2id or bcrypt.
- [x] Demo password values are placeholders and are not real user passwords.

## 4. Audit Logging

- [x] `audit_logs` table created.
- [x] Audit triggers created for users, budgets, categories, and expenses.
- [x] INSERT, UPDATE, and DELETE operations are supported.
- [x] Audit records were verified after migration.
- [x] 8 audit records were generated during demo-data loading.

## 5. Parameterized Queries

- [x] Application design requires parameterized/prepared SQL statements.
- [x] User input should not be concatenated directly into SQL statements.
- [x] Parameterized queries reduce SQL injection risk.

## 6. Backup and Restore

- [x] PostgreSQL custom-format backup created using `pg_dump -Fc`.
- [x] Backup contents verified using `pg_restore -l`.
- [x] Backup restored into `capstone_restore_test`.
- [x] Restored database verified successfully.
- [x] Temporary restore database removed after testing.

Restored row counts:

| Table | Rows |
|---|---:|
| users | 2 |
| budgets | 1 |
| categories | 3 |
| expenses | 2 |
| audit_logs | 8 |

## Security Evidence Summary

The SpendWise database implements role-based privileges, Row-Level Security, audit logging, password-hash storage, parameterized-query requirements, and tested backup/restore procedures.

Production deployment should additionally ensure that real passwords are hashed with a strong password-hashing algorithm and that application credentials are stored securely rather than committed to source control.
