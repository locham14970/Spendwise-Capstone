-- V4__row_level_security.sql
-- Enable Row-Level Security for tenant/user data isolation

ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

CREATE POLICY budgets_user_isolation
ON budgets
USING (user_id = NULLIF(current_setting('app.user_id', true), '')::BIGINT)
WITH CHECK (user_id = NULLIF(current_setting('app.user_id', true), '')::BIGINT);

CREATE POLICY categories_user_isolation
ON categories
USING (user_id = NULLIF(current_setting('app.user_id', true), '')::BIGINT)
WITH CHECK (user_id = NULLIF(current_setting('app.user_id', true), '')::BIGINT);

CREATE POLICY expenses_user_isolation
ON expenses
USING (user_id = NULLIF(current_setting('app.user_id', true), '')::BIGINT)
WITH CHECK (user_id = NULLIF(current_setting('app.user_id', true), '')::BIGINT);