-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create ENUM types
CREATE TYPE user_role AS ENUM ('user', 'admin', 'vendor');
CREATE TYPE event_status AS ENUM ('draft', 'confirmed', 'completed', 'cancelled');
CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

-- 1. Users Table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role user_role NOT NULL DEFAULT 'user',
    full_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Locations Table
CREATE TABLE locations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0)
);

-- 3. Services Table
CREATE TABLE services (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    vendor_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    category VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- 4. Predefined Events Table
CREATE TABLE predefined_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL CHECK (base_price >= 0)
);

-- 5. Events Table
CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    event_date TIMESTAMP WITH TIME ZONE NOT NULL,
    location_id UUID REFERENCES locations(id) ON DELETE SET NULL,
    predefined_event_id UUID REFERENCES predefined_events(id) ON DELETE SET NULL,
    status event_status NOT NULL DEFAULT 'draft',
    guest_count INT CHECK (guest_count >= 0)
);

-- 6. Event Services Mapping Table
CREATE TABLE event_services (
    event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    service_id UUID NOT NULL REFERENCES services(id) ON DELETE CASCADE,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    price_at_booking DECIMAL(10, 2) NOT NULL CHECK (price_at_booking >= 0),
    PRIMARY KEY (event_id, service_id)
);

-- 7. Bookings Table
CREATE TABLE bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    booking_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    payment_status payment_status NOT NULL DEFAULT 'pending'
);

-- Indexes for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_events_user_id ON events(user_id);
CREATE INDEX idx_events_date ON events(event_date);
CREATE INDEX idx_services_vendor_id ON services(vendor_id);
CREATE INDEX idx_bookings_event_id ON bookings(event_id);

-- Sample Data Insertion

-- Users
INSERT INTO users (id, email, password_hash, role, full_name) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'admin@example.com', 'hashed_secret', 'admin', 'System Admin'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'vendor1@example.com', 'hashed_secret', 'vendor', 'Best Catering Co.'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'vendor2@example.com', 'hashed_secret', 'vendor', 'DJ Beats'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'user1@example.com', 'hashed_secret', 'user', 'Alice Smith'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a55', 'user2@example.com', 'hashed_secret', 'user', 'Bob Jones');

-- Locations
INSERT INTO locations (id, name, address, city, state, zip_code, capacity) VALUES
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a66', 'Grand Ballroom', '123 Main St', 'Metropolis', 'NY', '10001', 500),
('g0eebc99-9c0b-4ef8-bb6d-6bb9bd380a77', 'Sunset Garden', '456 Park Ave', 'Metropolis', 'NY', '10002', 200);

-- Services
INSERT INTO services (id, vendor_id, name, description, price, category) VALUES
('h0eebc99-9c0b-4ef8-bb6d-6bb9bd380a88', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Premium Buffet', 'All you can eat premium selection', 50.00, 'Catering'),
('i0eebc99-9c0b-4ef8-bb6d-6bb9bd380a99', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Standard Buffet', 'Standard selection', 30.00, 'Catering'),
('j0eebc99-9c0b-4ef8-bb6d-6bb9bd380b00', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'Wedding DJ Package', '4 hours of music + lighting', 800.00, 'DJ'),
('k0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'Party DJ', '2 hours of music', 400.00, 'DJ');

-- Predefined Events
INSERT INTO predefined_events (id, name, description, base_price) VALUES
('l0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'Wedding Package', 'Full wedding planning service', 5000.00),
('m0eebc99-9c0b-4ef8-bb6d-6bb9bd380b33', 'Birthday Bash', 'Standard birthday party package', 1000.00);

-- Events
INSERT INTO events (id, user_id, name, event_date, location_id, predefined_event_id, status, guest_count) VALUES
('n0eebc99-9c0b-4ef8-bb6d-6bb9bd380b44', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'Alice''s Wedding', '2024-06-15 14:00:00+00', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a66', 'l0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'confirmed', 150);

-- Event Services
INSERT INTO event_services (event_id, service_id, quantity, price_at_booking) VALUES
('n0eebc99-9c0b-4ef8-bb6d-6bb9bd380b44', 'h0eebc99-9c0b-4ef8-bb6d-6bb9bd380a88', 150, 50.00), -- 150 guests * $50
('n0eebc99-9c0b-4ef8-bb6d-6bb9bd380b44', 'j0eebc99-9c0b-4ef8-bb6d-6bb9bd380b00', 1, 800.00);

-- Bookings
INSERT INTO bookings (id, event_id, user_id, total_amount, payment_status) VALUES
('o0eebc99-9c0b-4ef8-bb6d-6bb9bd380b55', 'n0eebc99-9c0b-4ef8-bb6d-6bb9bd380b44', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 8300.00, 'paid');
