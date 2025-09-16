class SupabaseConfig {
  // Replace these with your actual Supabase project credentials
  static const String supabaseUrl = 'https://lpgtsoknwpmzqrvhihke.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxwZ3Rzb2tud3BtenFydmhpaGtlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU3NjQ0MDIsImV4cCI6MjA3MTM0MDQwMn0.EPXXMwqbmLjRrasTlqvJB6uv-YVpTaR_C5hzJRHJFu8';
  
  // Database table names
  static const String bookingsTable = 'bookings';
  static const String usersTable = 'users';
  
  // Storage bucket names
  static const String bookingDocumentsBucket = 'booking-documents';
  static const String serviceImagesBucket = 'service-images';
  static const String userProfilesBucket = 'user-profiles';
  
  // Storage folder paths
  static const String bookingAttachmentsFolder = 'booking-attachments';
  static const String invoicesFolder = 'invoices';
  static const String receiptsFolder = 'receipts';
}
