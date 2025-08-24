import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/clothes_controller.dart';
import 'image_posting.dart';

class TryOnScreen extends StatefulWidget {
  final String? userImagePath; // optional; passed when coming from ImagePosting
  final bool pickerMode;       // determines behavior on tap

  const TryOnScreen({
    super.key,
    this.userImagePath,
    this.pickerMode = false, // default: normal “browse outfits” mode
  });

  @override
  State<TryOnScreen> createState() => _TryOnScreenState();
}

class _TryOnScreenState extends State<TryOnScreen> {
  final ClothesController clothesController = Get.find();

  @override
  void initState() {
    super.initState();
    _refreshScreen();
  }

  Future<void> _refreshScreen() async {
    clothesController.selectedCategory.value = 'All';
    await Future.delayed(const Duration(milliseconds: 350));
    clothesController.updateFilteredClothes();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Outfits',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
          ),
        ),
        automaticallyImplyLeading: !widget.pickerMode,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: widget.pickerMode
            ? IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Avoid Get.back() to dodge GetX SnackbarController race
            Navigator.of(context).maybePop();
          },
        )
            : null,
      ),
      body: Obx(() {
        final clothes = clothesController.filteredClothes;

        return Column(
          children: [
            // Categories
            SizedBox(
              height: 64.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                itemCount: clothesController.categories.length,
                itemBuilder: (context, index) {
                  final category = clothesController.categories[index];
                  return GestureDetector(
                    onTap: () {
                      clothesController.selectedCategory.value = category;
                      clothesController.updateFilteredClothes();
                    },
                    child: Obx(() {
                      final isSelected =
                          clothesController.selectedCategory.value == category;
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            // Grid (pull-to-refresh)
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshScreen,
                child: clothes.isEmpty
                    ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 120.h),
                    const _EmptyState(
                      title: 'No items here yet',
                      subtitle:
                      'Pull to refresh or add some clothes to this category.',
                    ),
                  ],
                )
                    : GridView.builder(
                  padding: EdgeInsets.all(16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                    ScreenUtil().screenWidth > 600 ? 3 : 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: clothes.length,
                  itemBuilder: (context, index) {
                    final outfitName =
                        clothes[index]['name'] as String? ?? 'Outfit';
                    final outfitCategory =
                        clothes[index]['category'] as String? ?? 'General';
                    final outfitImage =
                        clothes[index]['image'] as String? ?? '';

                    return GestureDetector(
                      onTap: () {
                        if (widget.pickerMode) {
                          // Return BOTH image and category to ImagePosting
                          Future.microtask(() => Navigator.of(context).pop({
                            'image': outfitImage,
                            'category': outfitCategory,
                          }));
                        } else {
                          // Normal browse → go to ImagePosting with ONLY outfit prefilled.
                          // (Do NOT pass userImagePath, so user must pick their photo there.)
                          Get.to(() => ImagePosting(
                            initialClothingImagePath: outfitImage,
                            initialClothingCategory: outfitCategory,
                            // intentionally NOT passing initialUserImagePath
                          ));
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Outfit Image
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12.r),
                                ),
                                child: _buildImageWidget(outfitImage),
                              ),
                            ),
                            // Name + Category
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 8.h,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    outfitName,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Category: $outfitCategory",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget _buildImageWidget(String imagePath) {
  if (imagePath.startsWith('http')) {
    return Image.network(
      imagePath,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(Icons.broken_image, size: 38, color: Colors.grey),
      ),
      loadingBuilder: (ctx, child, progress) =>
      progress == null ? child : const Center(child: CircularProgressIndicator()),
    );
  } else {
    final file = File(imagePath);
    if (file.existsSync()) {
      return Image.file(
        file,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
        const Center(child: Icon(Icons.error, size: 38, color: Colors.red)),
      );
    }
    return const Center(
        child: Icon(Icons.broken_image, size: 38, color: Colors.grey));
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  const _EmptyState({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        children: [
          Icon(Icons.checkroom_outlined, size: 64.sp, color: Colors.black45),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.sp, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
