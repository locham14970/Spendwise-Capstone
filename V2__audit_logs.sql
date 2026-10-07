-- V2__audit_logs.sql
-- Add indexes to the existing audit_logs table

CREATE INDEX idx_audit_logs_user_id
    ON audit_logs(user_id);

CREATE INDEX idx_audit_logs_table_record
    ON audit_logs(table_name, record_id);

CREATE INDEX idx_audit_logs_changed_at
    ON audit_logs(changed_at);