import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/clothes_controller.dart';
import 'signin_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final ClothesController clothesController = Get.find();
  final TextEditingController _newClothController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> categories = ["tops", "bottoms", "one-Piece"];
  String selectedCategory = "one-Piece";

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _addCloth() {
    if (_newClothController.text.isNotEmpty && _selectedImage != null) {
      clothesController.addClothingItem(
        _newClothController.text,
        _selectedImage!.path,
        selectedCategory,
      );
      _newClothController.clear();
      setState(() {
        _selectedImage = null;
      });
      Get.snackbar('Success', 'Clothing item added!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.85),
          colorText: Colors.white);
    } else {
      Get.snackbar('Missing info', 'Please add a name and pick an image.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withOpacity(0.85),
          colorText: Colors.white);
    }
  }

  Future<void> _logoutAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_uid');
    Get.offAll(() => SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    final Color glassColor = Colors.white.withOpacity(0.52);
    final Color accent = Color(0xFFF97316);

    return Scaffold(
      backgroundColor: Colors.transparent, // <-- important for gradient!
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        title: Text('admin_panel'.tr,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.redAccent),
            onPressed: _showLogoutConfirmation,
            tooltip: "Logout",
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FAFC), Color(0xFFE0E7EF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GlassCard(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Add New Clothing", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: _newClothController,
                        decoration: InputDecoration(
                          labelText: 'enter_clothing_name'.tr,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          prefixIcon: Icon(Icons.checkroom),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      GestureDetector(
                        onTap: _pickImage,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          height: 130.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: accent, width: 2),
                            image: _selectedImage != null
                                ? DecorationImage(image: FileImage(_selectedImage!), fit: BoxFit.cover)
                                : null,
                            boxShadow: [
                              if (_selectedImage != null)
                                BoxShadow(
                                  color: accent.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: Offset(0, 7),
                                ),
                            ],
                          ),
                          child: _selectedImage == null
                              ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.cloud_upload, size: 45, color: accent),
                                SizedBox(height: 8.h),
                                Text('upload_image'.tr, style: TextStyle(color: accent, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                        ),
                      ),

                      SizedBox(height: 14.h),

                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        icon: Icon(Icons.arrow_drop_down, color: accent),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                        ),
                        items: categories
                            .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat.tr, style: TextStyle(fontWeight: FontWeight.w500)),
                        ))
                            .toList(),
                        onChanged: (value) => setState(() => selectedCategory = value!),
                      ),
                      SizedBox(height: 18.h),
                      ElevatedButton.icon(
                        onPressed: _addCloth,
                        icon: Icon(Icons.add),
                        label: Text('add_clothing_item'.tr),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          elevation: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              Text("Clothing Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: accent)),
              SizedBox(height: 10.h),

              Obx(() {
                final items = clothesController.clothes;
                if (items.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(
                      child: Text(
                        "No clothing items yet. Add your first one!",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    var item = items[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GlassCard(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _buildClothingImage(item['image']),
                          ),
                          title: Text(item['name'], style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text("Category: ${item['category']}"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () {
                              clothesController.removeClothingItem(i);
                              Get.snackbar('Deleted', 'Clothing item removed.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.withOpacity(0.9),
                                  colorText: Colors.white);
                            },
                            tooltip: "Delete",
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClothingImage(String imagePath) {
    // If you are storing Cloudinary URLs, switch to Image.network
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        width: 55.w,
        height: 55.h,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          width: 55.w,
          height: 55.h,
          color: Colors.grey[300],
          child: Icon(Icons.broken_image, color: Colors.orange),
        ),
      );
    } else {
      // Local file fallback
      return Image.file(
        File(imagePath),
        width: 55.w,
        height: 55.h,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          width: 55.w,
          height: 55.h,
          color: Colors.grey[300],
          child: Icon(Icons.broken_image, color: Colors.orange),
        ),
      );
    }
  }

  void _showLogoutConfirmation() {
    Get.defaultDialog(
      title: "log_out".tr,
      middleText: "logout_confirmation".tr,
      textConfirm: "yes".tr,
      textCancel: "no".tr,
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: _logoutAdmin,
    );
  }
}

/// Glass effect card widget (for modern UI)
class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.52),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.23)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.08),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
