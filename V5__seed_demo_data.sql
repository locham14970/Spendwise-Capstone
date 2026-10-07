-- V5__seed_demo_data.sql
-- Demo data for SpendWise testing and presentation

INSERT INTO users (full_name, email, password_hash)
VALUES
    ('Simon Demo', 'simon.demo@spendwise.test', 'DEMO_HASH_001'),
    ('Amina Demo', 'amina.demo@spendwise.test', 'DEMO_HASH_002');

INSERT INTO categories (user_id, name)
SELECT user_id, 'Food'
FROM users
WHERE email = 'simon.demo@spendwise.test';

INSERT INTO categories (user_id, name)
SELECT user_id, 'Transport'
FROM users
WHERE email = 'simon.demo@spendwise.test';

INSERT INTO categories (user_id, name)
SELECT user_id, 'Education'
FROM users
WHERE email = 'simon.demo@spendwise.test';

INSERT INTO budgets (
    user_id,
    name,
    amount,
    start_date,
    end_date
)
SELECT
    user_id,
    'October 2026 Budget',
    50000.00,
    '2026-10-01',
    '2026-10-31'
FROM users
WHERE email = 'simon.demo@spendwise.test';

INSERT INTO expenses (
    user_id,
    budget_id,
    category_id,
    amount,
    description,
    expense_date
)
SELECT
    u.user_id,
    b.budget_id,
    c.category_id,
    1200.00,
    'Groceries',
    '2026-10-03'
FROM users u
JOIN budgets b ON b.user_id = u.user_id
JOIN categories c ON c.user_id = u.user_id
WHERE u.email = 'simon.demo@spendwise.test'
  AND b.name = 'October 2026 Budget'
  AND c.name = 'Food';

INSERT INTO expenses (
    user_id,
    budget_id,
    category_id,
    amount,
    description,
    expense_date
)
SELECT
    u.user_id,
    b.budget_id,
    c.category_id,
    800.00,
    'Bus fare',
    '2026-10-04'
FROM users u
JOIN budgets b ON b.user_id = u.user_id
JOIN categories c ON c.user_id = u.user_id
WHERE u.email = 'simon.demo@spendwise.test'
  AND b.name = 'October 2026 Budget'
  AND c.name = 'Transport';