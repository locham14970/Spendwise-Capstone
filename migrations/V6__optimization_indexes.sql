-- V6__optimization_indexes.sql
-- Optimize user-specific expense queries

CREATE INDEX idx_expenses_user_id
    ON expenses(user_id);