# Supabase Migration Setup Guide

## Overview
This project has been migrated from Firebase to Supabase. Follow these steps to complete the setup.

## 1. Supabase Project Setup

### Get Your Credentials
1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Create a new project or select your existing project
3. Go to Settings > API
4. Copy your:
   - Project URL (already added: `https://lpgtsoknwpmzqrvhihke.supabase.co`)
   - Anon/Public Key (needs to be added to `lib/config.dart`)

### Update Configuration
Update `lib/config.dart` with your actual Supabase anon key:
```dart
static const String supabaseAnonKey = 'your_actual_anon_key_here';
```

## 2. Database Schema Setup

### Create Required Tables

#### Bookings Table
Run this SQL in your Supabase SQL Editor:

```sql
-- Create bookings table
CREATE TABLE bookings (
  id BIGSERIAL PRIMARY KEY,
  full_name TEXT NOT NULL,
  city TEXT NOT NULL,
  address TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  email TEXT NOT NULL,
  service_type TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

-- Create policy to allow authenticated users to insert bookings
CREATE POLICY "Users can insert bookings" ON bookings
  FOR INSERT WITH CHECK (auth.role() = 'authenticated' OR auth.role() = 'anon');

-- Create policy to allow users to view their own bookings
CREATE POLICY "Users can view bookings" ON bookings
  FOR SELECT USING (true);
```

#### Users Table (Optional - for additional user data)
```sql
-- Create users table for additional user information
CREATE TABLE users (
  id UUID REFERENCES auth.users PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE USING (auth.uid() = id);
```

## 3. Authentication Setup

### Email Authentication
1. Go to Authentication > Settings in your Supabase dashboard
2. Enable Email authentication
3. Configure email templates if needed
4. Set up redirect URLs for your app

### Row Level Security
The tables are configured with RLS policies to ensure data security.

## 4. Testing the Migration

### Install Dependencies
```bash
flutter pub get
```

### Test Authentication
1. Run the app
2. Try registering a new user
3. Try logging in with existing credentials

### Test Database Operations
1. Navigate to the booking page
2. Fill out the form and submit
3. Check your Supabase dashboard to see if the data was inserted

## 5. Migration Changes Made

### Files Modified:
- `pubspec.yaml` - Replaced Firebase dependencies with Supabase
- `lib/main.dart` - Initialize Supabase instead of Firebase
- `lib/config.dart` - New configuration file for Supabase credentials
- `lib/MyScreens/LoginPage.dart` - Updated to use Supabase auth
- `lib/MyScreens/RegistrationPage.dart` - Updated to use Supabase auth
- `lib/MyScreens/BookingPage.dart` - Updated to use Supabase database
- `lib/firebase_options.dart` - Replaced with Supabase reference

### Key Changes:
- Firebase Auth → Supabase Auth
- Firestore → Supabase Database
- Real-time subscriptions available with Supabase
- Better TypeScript support
- Built-in Row Level Security

## 6. Additional Features Available

With Supabase, you now have access to:
- Real-time subscriptions
- Built-in authentication with multiple providers
- Automatic API generation
- Built-in file storage
- Edge functions
- Better performance and scaling

## Troubleshooting

### Common Issues:
1. **Authentication errors**: Check if your anon key is correct
2. **Database errors**: Ensure tables are created and RLS policies are set
3. **Connection errors**: Verify your Supabase URL is correct

### Debug Mode:
Add this to see detailed logs:
```dart
// In main.dart
await Supabase.initialize(
  url: SupabaseConfig.supabaseUrl,
  anonKey: SupabaseConfig.supabaseAnonKey,
  debug: true, // Add this for debugging
);
```
