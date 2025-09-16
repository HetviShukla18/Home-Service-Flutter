import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mad_mini_project/config.dart';

class StorageService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  /// Upload a file to the booking documents bucket
  static Future<String?> uploadBookingDocument({
    required String fileName,
    required File file,
    required String bookingId,
  }) async {
    try {
      final String filePath = '${SupabaseConfig.bookingAttachmentsFolder}/$bookingId/$fileName';
      
      final String fullPath = await _supabase.storage
          .from(SupabaseConfig.bookingDocumentsBucket)
          .upload(filePath, file);

      return fullPath;
    } catch (e) {
      print('Error uploading booking document: $e');
      return null;
    }
  }

  /// Upload bytes data to storage
  static Future<String?> uploadBookingDocumentBytes({
    required String fileName,
    required Uint8List bytes,
    required String bookingId,
    String? mimeType,
  }) async {
    try {
      final String filePath = '${SupabaseConfig.bookingAttachmentsFolder}/$bookingId/$fileName';
      
      final String fullPath = await _supabase.storage
          .from(SupabaseConfig.bookingDocumentsBucket)
          .uploadBinary(filePath, bytes, fileOptions: FileOptions(
            contentType: mimeType,
          ));

      return fullPath;
    } catch (e) {
      print('Error uploading booking document bytes: $e');
      return null;
    }
  }

  /// Upload invoice document
  static Future<String?> uploadInvoice({
    required String fileName,
    required File file,
    required String bookingId,
  }) async {
    try {
      final String filePath = '${SupabaseConfig.invoicesFolder}/$bookingId/$fileName';
      
      final String fullPath = await _supabase.storage
          .from(SupabaseConfig.bookingDocumentsBucket)
          .upload(filePath, file);

      return fullPath;
    } catch (e) {
      print('Error uploading invoice: $e');
      return null;
    }
  }

  /// Upload receipt document
  static Future<String?> uploadReceipt({
    required String fileName,
    required File file,
    required String bookingId,
  }) async {
    try {
      final String filePath = '${SupabaseConfig.receiptsFolder}/$bookingId/$fileName';
      
      final String fullPath = await _supabase.storage
          .from(SupabaseConfig.bookingDocumentsBucket)
          .upload(filePath, file);

      return fullPath;
    } catch (e) {
      print('Error uploading receipt: $e');
      return null;
    }
  }

  /// Get public URL for a file
  static String getPublicUrl({
    required String bucket,
    required String filePath,
  }) {
    return _supabase.storage.from(bucket).getPublicUrl(filePath);
  }

  /// Get signed URL for private files (expires in 1 hour by default)
  static Future<String?> getSignedUrl({
    required String bucket,
    required String filePath,
    int expiresInSeconds = 3600,
  }) async {
    try {
      final String signedUrl = await _supabase.storage
          .from(bucket)
          .createSignedUrl(filePath, expiresInSeconds);
      return signedUrl;
    } catch (e) {
      print('Error getting signed URL: $e');
      return null;
    }
  }

  /// Download file as bytes
  static Future<Uint8List?> downloadFile({
    required String bucket,
    required String filePath,
  }) async {
    try {
      final Uint8List bytes = await _supabase.storage
          .from(bucket)
          .download(filePath);
      return bytes;
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }

  /// List files in a booking folder
  static Future<List<FileObject>?> listBookingFiles({
    required String bookingId,
    String? folder,
  }) async {
    try {
      final String path = folder != null 
          ? '$folder/$bookingId'
          : '${SupabaseConfig.bookingAttachmentsFolder}/$bookingId';
      
      final List<FileObject> files = await _supabase.storage
          .from(SupabaseConfig.bookingDocumentsBucket)
          .list(path: path);
      
      return files;
    } catch (e) {
      print('Error listing booking files: $e');
      return null;
    }
  }

  /// Delete a file
  static Future<bool> deleteFile({
    required String bucket,
    required String filePath,
  }) async {
    try {
      await _supabase.storage
          .from(bucket)
          .remove([filePath]);
      return true;
    } catch (e) {
      print('Error deleting file: $e');
      return false;
    }
  }

  /// Upload service image
  static Future<String?> uploadServiceImage({
    required String fileName,
    required File file,
    required String serviceType,
  }) async {
    try {
      final String filePath = '$serviceType/$fileName';
      
      final String fullPath = await _supabase.storage
          .from(SupabaseConfig.serviceImagesBucket)
          .upload(filePath, file);

      return fullPath;
    } catch (e) {
      print('Error uploading service image: $e');
      return null;
    }
  }

  /// Upload user profile image
  static Future<String?> uploadProfileImage({
    required String fileName,
    required File file,
    required String userId,
  }) async {
    try {
      final String filePath = '$userId/$fileName';
      
      final String fullPath = await _supabase.storage
          .from(SupabaseConfig.userProfilesBucket)
          .upload(filePath, file);

      return fullPath;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  /// Get file size in a human-readable format
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Check if file exists
  static Future<bool> fileExists({
    required String bucket,
    required String filePath,
  }) async {
    try {
      await _supabase.storage.from(bucket).download(filePath);
      return true;
    } catch (e) {
      return false;
    }
  }
}
