import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/clothes_controller.dart';
import 'outfit.dart';
import 'try_on_screen.dart';

class ImagePosting extends StatefulWidget {
  final String? initialUserImagePath;        // optional seed (coming from outfits first)
  final String? initialClothingImagePath;    // optional seed
  final String? initialClothingCategory;     // << NEW: pass from TryOnScreen

  const ImagePosting({
    super.key,
    this.initialUserImagePath,
    this.initialClothingImagePath,
    this.initialClothingCategory,
  });

  @override
  _ImagePostingState createState() => _ImagePostingState();
}

class _ImagePostingState extends State<ImagePosting> {
  final ClothesController clothesController = Get.find();

  String? userImagePath;
  String? clothingImagePath;
  String? clothingCategory;  // << NEW

  bool _navigatedToResult = false;

  @override
  void initState() {
    super.initState();
    userImagePath = widget.initialUserImagePath;
    clothingImagePath = widget.initialClothingImagePath;
    clothingCategory = widget.initialClothingCategory;

    // Let first frame render then maybe navigate
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeStartGeneration());
  }

  /// Pick user image from gallery
  Future<void> _pickUserImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (!mounted) return;
    if (pickedFile != null) {
      setState(() => userImagePath = pickedFile.path);
      _maybeStartGeneration();
    }
  }

  /// Open outfit picker; returns a map with {'image': ..., 'category': ...}
  Future<void> _selectClothing() async {
    final result = await Get.to(() => TryOnScreen(
      userImagePath: userImagePath,
      pickerMode: true, // IMPORTANT: use Navigator.pop(context, {...}) inside TryOnScreen
    ));

    if (!mounted) return;

    if (result is Map) {
      final img = result['image'];
      final cat = result['category'];
      if (img is String && img.isNotEmpty) {
        setState(() {
          clothingImagePath = img;
          clothingCategory = (cat is String && cat.isNotEmpty) ? cat : null;
        });
        _maybeStartGeneration();
      }
    } else if (result is String) {
      // Fallback if you accidentally return just the image string
      setState(() {
        clothingImagePath = result;
        // clothingCategory stays whatever it was (or null)
      });
      _maybeStartGeneration();
    }
  }

  /// Navigate to result screen when both are ready (once)
  Future<void> _maybeStartGeneration() async {
    if (_navigatedToResult) return;
    if (userImagePath != null && clothingImagePath != null) {
      _navigatedToResult = true;

      // Give any prior pop() a tick to settle
      await Future.delayed(const Duration(milliseconds: 50));
      if (!mounted) return;

      await Get.to(() => TryOnResultScreen(
        userImagePath: userImagePath!,
        clothingImagePath: clothingImagePath!,
        category: clothingCategory ?? 'Unknown', // << comes from Outfit screen
      ));

      // Allow another run if user comes back and changes selection
      _navigatedToResult = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = Get.locale?.languageCode ?? 'en';

    final userImagePlaceholder = currentLang == 'el'
        ? 'assets/images/choose_photo_greek.png'
        : 'assets/images/choose_photo.png';

    final clothingImagePlaceholder = currentLang == 'el'
        ? 'assets/images/second_card_greek.png'
        : 'assets/images/second_card.png';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "virtual_try_on".tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /// User image card
            GestureDetector(
              onTap: _pickUserImage,
              child: _buildImageCard(userImagePath ?? userImagePlaceholder),
            ),

            SizedBox(height: 30.h),

            /// Clothing image card
            GestureDetector(
              onTap: _selectClothing,
              child: Stack(
                children: [
                  _buildImageCard(clothingImagePath ?? clothingImagePlaceholder),
                  if (clothingCategory != null && clothingImagePath != null)
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          clothingCategory!,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Minimal status hint
            if (userImagePath == null || clothingImagePath == null)
              Text(
                'Select ${userImagePath == null ? "your photo" : ""}'
                    '${(userImagePath == null && clothingImagePath == null) ? " and " : ""}'
                    '${clothingImagePath == null ? "an outfit" : ""} to start.',
                style: TextStyle(fontSize: 13.sp, color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    final isAsset = imagePath.contains('assets/');
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: isAsset
            ? Image.asset(
          imagePath,
          width: double.infinity,
          height: 300.h,
          fit: BoxFit.cover,
        )
            : Image.file(
          File(imagePath),
          width: double.infinity,
          height: 300.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
