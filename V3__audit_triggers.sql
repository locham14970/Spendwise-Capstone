-- V3__audit_triggers.sql
-- Automatically record INSERT, UPDATE, and DELETE operations

CREATE OR REPLACE FUNCTION audit_row_changes()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    current_user_id BIGINT;
BEGIN
    BEGIN
        current_user_id := NULLIF(current_setting('app.user_id', true), '')::BIGINT;
    EXCEPTION
        WHEN OTHERS THEN
            current_user_id := NULL;
    END;

    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_logs (
            user_id,
            table_name,
            record_id,
            action,
            new_data
        )
        VALUES (
            current_user_id,
            TG_TABLE_NAME,
            NEW.user_id,
            'INSERT',
            row_to_json(NEW)::TEXT
        );

        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_logs (
            user_id,
            table_name,
            record_id,
            action,
            old_data,
            new_data
        )
        VALUES (
            current_user_id,
            TG_TABLE_NAME,
            NEW.user_id,
            'UPDATE',
            row_to_json(OLD)::TEXT,
            row_to_json(NEW)::TEXT
        );

        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit_logs (
            user_id,
            table_name,
            record_id,
            action,
            old_data
        )
        VALUES (
            current_user_id,
            TG_TABLE_NAME,
            OLD.user_id,
            'DELETE',
            row_to_json(OLD)::TEXT
        );

        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;


CREATE TRIGGER trg_users_audit
AFTER INSERT OR UPDATE OR DELETE ON users
FOR EACH ROW
EXECUTE FUNCTION audit_row_changes();


CREATE TRIGGER trg_budgets_audit
AFTER INSERT OR UPDATE OR DELETE ON budgets
FOR EACH ROW
EXECUTE FUNCTION audit_row_changes();


CREATE TRIGGER trg_categories_audit
AFTER INSERT OR UPDATE OR DELETE ON categories
FOR EACH ROW
EXECUTE FUNCTION audit_row_changes();


CREATE TRIGGER trg_expenses_audit
AFTER INSERT OR UPDATE OR DELETE ON expenses
FOR EACH ROW
EXECUTE FUNCTION audit_row_changes();