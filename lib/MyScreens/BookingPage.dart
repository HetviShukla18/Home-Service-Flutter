import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mad_mini_project/MyScreens/Homepage.dart';
import 'package:mad_mini_project/config.dart';
import 'package:mad_mini_project/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class NextPage4 extends StatefulWidget {
  @override
  _NextPage4State createState() => _NextPage4State();
}

class _NextPage4State extends State<NextPage4> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCity;
  String? _serviceType;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  
  // File upload related variables
  List<PlatformFile> _selectedFiles = [];
  bool _isUploading = false;

  Future<void> _submitData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUploading = true;
      });
      
      try {
        // Insert booking data first
        final response = await Supabase.instance.client
            .from(SupabaseConfig.bookingsTable)
            .insert({
          'full_name': fullNameController.text.trim(),
          'city': _selectedCity,
          'address': addressController.text.trim(),
          'phone_number': phoneNumberController.text.trim(),
          'email': emailController.text.trim(),
          'service_type': _serviceType,
          'created_at': DateTime.now().toIso8601String(),
        }).select();
        
        // Get the booking ID from the response
        final bookingId = response.first['id'].toString();
        
        // Upload files if any are selected
        List<String> uploadedFileUrls = [];
        if (_selectedFiles.isNotEmpty) {
          for (PlatformFile platformFile in _selectedFiles) {
            if (platformFile.path != null) {
              File file = File(platformFile.path!);
              String? uploadPath = await StorageService.uploadBookingDocument(
                fileName: platformFile.name,
                file: file,
                bookingId: bookingId,
              );
              if (uploadPath != null) {
                uploadedFileUrls.add(uploadPath);
              }
            }
          }
          
          // Update booking record with file URLs
          if (uploadedFileUrls.isNotEmpty) {
            await Supabase.instance.client
                .from(SupabaseConfig.bookingsTable)
                .update({
              'attached_files': uploadedFileUrls,
            }).eq('id', bookingId);
          }
        }

        // Clear fields after submission
        fullNameController.clear();
        addressController.clear();
        phoneNumberController.clear();
        emailController.clear();
        setState(() {
          _selectedCity = null;
          _serviceType = null;
          _selectedFiles.clear();
          _isUploading = false;
        });

        // Success Alert
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Booking Successful',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text(
              'Your booking has been registered successfully!',
              style: TextStyle(fontSize: 16),
            ),
            actions: <Widget>[
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => NextPage1()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          );
        },
        );
      } catch (e) {
        setState(() {
          _isUploading = false;
        });
        
        // Error Alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Booking Failed',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Text(
                'There was an error submitting your booking. Please try again.',
                style: TextStyle(fontSize: 16),
              ),
              actions: <Widget>[
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _selectedFiles.addAll(result.files);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking files: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeFile(PlatformFile file) {
    setState(() {
      _selectedFiles.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF4A90E2);
    final Color secondaryAccentColor = Color(0xFF9B51E0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 4,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryColor, Color(0xFF357ABD)],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xfff8fbff), Color(0xffe8f4fd)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Color(0xfff8fbff)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.edit_calendar, color: primaryColor, size: 28),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Book Your Service",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Fill in your details to confirm booking",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Full Name
                _buildFormField(
                  label: "Enter Full Name",
                  icon: Icons.person_outline,
                  child: TextFormField(
                    controller: fullNameController,
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? "Full name is required"
                                : null,
                    decoration: _buildInputDecoration(
                      "Full Name",
                      Icons.person,
                    ),
                  ),
                ),

                // City
                _buildFormField(
                  label: "Select City",
                  icon: Icons.location_city_outlined,
                  child: DropdownButtonFormField<String>(
                    value: _selectedCity,
                    validator:
                        (value) =>
                            value == null ? "Please select a city" : null,
                    decoration: _buildInputDecoration(
                      "City",
                      Icons.location_city,
                    ),
                    items:
                        [
                              'Surat',
                              'Vadodra',
                              'Ahemdabad',
                              'Anand',
                              'Surendranagar',
                              'Rajkot',
                              'Bhavnagar',
                              'Jamnagar',
                              'Gandhinagar',
                              'Navsari',
                              'Morbi',
                              'Bhuj',
                            ]
                            .map(
                              (city) => DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => _selectedCity = value),
                  ),
                ),

                // Address
                _buildFormField(
                  label: "Enter Address",
                  icon: Icons.home_outlined,
                  child: TextFormField(
                    controller: addressController,
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? "Address is required"
                                : null,
                    decoration: _buildInputDecoration("Address", Icons.home),
                  ),
                ),

                // Phone
                _buildFormField(
                  label: "Enter Phone Number",
                  icon: Icons.phone_outlined,
                  child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Phone number is required";
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return "Enter a valid 10-digit phone number";
                      }
                      return null;
                    },
                    decoration: _buildInputDecoration(
                      "Phone Number",
                      Icons.phone,
                    ),
                  ),
                ),

                // Email
                _buildFormField(
                  label: "Enter Email",
                  icon: Icons.email_outlined,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Email is required";
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    decoration: _buildInputDecoration("Email", Icons.email),
                  ),
                ),

                // Service Type
                _buildFormField(
                  label: "Select Service",
                  icon: Icons.build_outlined,
                  child: DropdownButtonFormField<String>(
                    value: _serviceType,
                    validator:
                        (value) =>
                            value == null ? "Please select a service" : null,
                    decoration: _buildInputDecoration(
                      "Service Type",
                      Icons.build,
                    ),
                    items:
                        [
                              'Plumber',
                              'Carpenter',
                              'Electrician',
                              'Chef',
                              'Gardener',
                              'Gutterman',
                              'Salon',
                              'Event ',
                              'Driver',
                              'Tutor',
                              'Technician',
                              'Painter',
                              'Cleaner',
                              'Babysitter',
                              'Laundary',
                              'Sevurity Guard',
                            ]
                            .map(
                              (service) => DropdownMenuItem(
                                value: service,
                                child: Text(service),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => _serviceType = value),
                  ),
                ),

                // File Upload Section
                _buildFormField(
                  label: "Attach Documents (Optional)",
                  icon: Icons.attach_file_outlined,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF4A90E2).withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: Color(0xFF4A90E2),
                              size: 32,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Upload supporting documents",
                              style: TextStyle(
                                color: Color(0xFF4A90E2),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Images, PDFs, or other relevant files",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: _pickFiles,
                              icon: Icon(Icons.add),
                              label: Text("Choose Files"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4A90E2),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedFiles.isNotEmpty) ...[
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selected Files:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4A90E2),
                                ),
                              ),
                              SizedBox(height: 8),
                              ..._selectedFiles.map((file) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.description,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        file.name,
                                        style: TextStyle(fontSize: 13),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      StorageService.formatFileSize(file.size),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => _removeFile(file),
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              )).toList(),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: 32),

                // Submit Button
                Container(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isUploading ? null : () => _submitData(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isUploading ? Colors.grey : secondaryAccentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isUploading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Uploading...",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline, size: 24),
                              SizedBox(width: 12),
                              Text(
                                "Submit Booking",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Color(0xFF4A90E2), size: 20),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Color(0xFF4A90E2),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    final Color primaryColor = Color(0xFF4A90E2);

    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
