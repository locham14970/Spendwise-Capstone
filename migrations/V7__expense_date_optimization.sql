-- V7__expense_date_optimization.sql
-- Optimize user expense queries filtered by date

CREATE INDEX idx_expenses_user_date
    ON expenses(user_id, expense_date);
