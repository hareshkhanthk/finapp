CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id),
    name TEXT NOT NULL,
    type TEXT CHECK (type IN ('savings', 'cash', 'wallet', 'credit')),
    masked_number TEXT,
    is_internal BOOLEAN DEFAULT FALSE,
    is_personal BOOLEAN DEFAULT TRUE
);

CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    parent_category_id UUID REFERENCES categories(id)
);

CREATE TABLE tags (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    color TEXT,
    user_id UUID REFERENCES users(id)
);

CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id),
    account_id UUID REFERENCES accounts(id),
    date DATE NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    type TEXT CHECK (type IN ('credit', 'debit', 'internal', 'cash')),
    description TEXT,
    is_internal BOOLEAN DEFAULT FALSE,
    category_id UUID REFERENCES categories(id),
    tag_ids UUID[]
);

CREATE TABLE uploads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id),
    file_path TEXT NOT NULL,
    parsed BOOLEAN DEFAULT FALSE,
    uploaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id),
    action_type TEXT,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);
