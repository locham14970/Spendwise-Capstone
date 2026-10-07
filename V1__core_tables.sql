-- V1__core_tables.sql
-- SpendWise Capstone: Core Tables

CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE budgets (
    budget_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    amount NUMERIC(12, 2) NOT NULL CHECK (amount >= 0),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_budgets_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_budget_dates
        CHECK (end_date >= start_date)
);

CREATE TABLE categories (
    category_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_categories_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT uq_category_user_name
        UNIQUE (user_id, name)
);

CREATE TABLE expenses (
    expense_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    budget_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
    description VARCHAR(255),
    expense_date DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_expenses_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_expenses_budget
        FOREIGN KEY (budget_id)
        REFERENCES budgets(budget_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_expenses_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON DELETE RESTRICT
);

CREATE TABLE audit_logs (
    audit_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT,
    table_name VARCHAR(100) NOT NULL,
    record_id BIGINT,
    action VARCHAR(20) NOT NULL,
    old_data TEXT,
    new_data TEXT,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_audit_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE SET NULL,

    CONSTRAINT chk_audit_action
        CHECK (action IN ('INSERT', 'UPDATE', 'DELETE'))
);