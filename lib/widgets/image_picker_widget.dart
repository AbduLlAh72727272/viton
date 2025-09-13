import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../core/responsive_helper.dart';

class ImagePickerWidget extends StatefulWidget {
  final void Function(String) onImagePicked; // Callback function

  const ImagePickerWidget({
    Key? key,
    required this.onImagePicked,
  }) : super(key: key); // Constructor to accept callback

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Send image path back to HomeScreen
      widget.onImagePicked(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: ResponsiveHelper.getResponsiveCardDecoration().copyWith(
          color: Colors.grey[300],
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: ResponsiveHelper.getResponsiveBorderRadius(),
                child: Image.file(_selectedImage!, fit: BoxFit.cover),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: ResponsiveHelper.getResponsiveIconSize(48),
                      color: Colors.grey[600],
                    ),
                    SizedBox(height: ResponsiveHelper.getResponsiveSpacing(16)),
                    Text(
                      'Tap to Upload Image',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(18),
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
