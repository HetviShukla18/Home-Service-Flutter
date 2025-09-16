# Supabase Storage Setup Guide

This guide will help you set up Supabase Storage buckets for your Kaarigar home services app.

## Storage Buckets Configuration

### 1. Create Storage Buckets

In your Supabase dashboard, navigate to **Storage** and create the following buckets:

#### Required Buckets:
- `booking-documents` - For storing booking-related files
- `service-images` - For service provider images and portfolios
- `user-profiles` - For user profile pictures

### 2. Bucket Policies

For each bucket, set up the following policies:

#### booking-documents Bucket Policies:

```sql
-- Allow authenticated users to upload files
CREATE POLICY "Allow authenticated users to upload booking documents" ON storage.objects
FOR INSERT WITH CHECK (
  auth.role() = 'authenticated' AND
  bucket_id = 'booking-documents'
);

-- Allow users to view their own booking documents
CREATE POLICY "Allow users to view their booking documents" ON storage.objects
FOR SELECT USING (
  auth.role() = 'authenticated' AND
  bucket_id = 'booking-documents'
);

-- Allow users to delete their own booking documents
CREATE POLICY "Allow users to delete their booking documents" ON storage.objects
FOR DELETE USING (
  auth.role() = 'authenticated' AND
  bucket_id = 'booking-documents'
);
```

#### service-images Bucket Policies:

```sql
-- Allow public read access to service images
CREATE POLICY "Allow public read access to service images" ON storage.objects
FOR SELECT USING (bucket_id = 'service-images');

-- Allow authenticated users to upload service images
CREATE POLICY "Allow authenticated users to upload service images" ON storage.objects
FOR INSERT WITH CHECK (
  auth.role() = 'authenticated' AND
  bucket_id = 'service-images'
);
```

#### user-profiles Bucket Policies:

```sql
-- Allow users to upload their own profile pictures
CREATE POLICY "Allow users to upload profile pictures" ON storage.objects
FOR INSERT WITH CHECK (
  auth.role() = 'authenticated' AND
  bucket_id = 'user-profiles'
);

-- Allow users to view profile pictures
CREATE POLICY "Allow users to view profile pictures" ON storage.objects
FOR SELECT USING (
  auth.role() = 'authenticated' AND
  bucket_id = 'user-profiles'
);

-- Allow users to update their own profile pictures
CREATE POLICY "Allow users to update their profile pictures" ON storage.objects
FOR UPDATE USING (
  auth.role() = 'authenticated' AND
  bucket_id = 'user-profiles'
);
```

### 3. Database Schema Updates

Add the following column to your existing `bookings` table to store file references:

```sql
-- Add attached_files column to bookings table
ALTER TABLE bookings ADD COLUMN attached_files TEXT[];
```

### 4. File Upload Limits

Configure the following limits in your Supabase project settings:

- **Maximum file size**: 50MB per file
- **Allowed file types**: 
  - Images: jpg, jpeg, png, gif, webp
  - Documents: pdf, doc, docx, txt
- **Maximum files per booking**: 5 files

### 5. Security Considerations

1. **File Validation**: The app validates file types and sizes before upload
2. **Virus Scanning**: Consider implementing virus scanning for uploaded files
3. **Storage Quotas**: Monitor storage usage and implement quotas if needed
4. **Access Control**: Files are organized by booking ID to ensure proper access control

## Usage in the App

### File Upload Features:
- **Booking Documents**: Users can attach supporting documents when creating bookings
- **Service Images**: Service providers can upload portfolio images
- **Profile Pictures**: Users can upload profile pictures

### File Management:
- **View Files**: Users can view their uploaded files
- **Download Files**: Users can download their booking documents
- **Delete Files**: Users can remove unwanted files

## Storage Structure

```
booking-documents/
├── booking-attachments/
│   ├── {booking_id}/
│   │   ├── document1.pdf
│   │   └── image1.jpg
├── invoices/
│   ├── {booking_id}/
│   │   └── invoice.pdf
└── receipts/
    ├── {booking_id}/
        └── receipt.pdf

service-images/
├── {service_type}/
│   ├── image1.jpg
│   └── image2.png

user-profiles/
├── {user_id}/
│   └── profile.jpg
```

## Testing the Setup

1. Create a test booking with file attachments
2. Verify files are uploaded to the correct bucket and folder
3. Check that file URLs are stored in the database
4. Test file download and viewing functionality

## Troubleshooting

### Common Issues:
1. **Upload Failures**: Check bucket policies and authentication
2. **File Not Found**: Verify file paths and bucket configuration
3. **Permission Denied**: Review RLS policies and user authentication

### Debug Steps:
1. Check Supabase logs for error details
2. Verify bucket names match configuration
3. Test with smaller file sizes
4. Check network connectivity

## Next Steps

After setting up storage:
1. Test file upload functionality in the app
2. Implement file viewing and download features
3. Add file management UI for users
4. Set up automated backups for important documents
