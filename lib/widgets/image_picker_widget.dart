import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  final void Function(String) onImagePicked; // Callback function

  ImagePickerWidget({required this.onImagePicked}); // Constructor to accept callback

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
        color: Colors.grey[300],
        child: _selectedImage != null
            ? Image.file(_selectedImage!, fit: BoxFit.cover)
            : Center(child: Text('Tap to Upload Image', style: TextStyle(fontSize: 18))),
      ),
    );
  }
}
