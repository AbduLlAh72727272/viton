import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClothesController extends GetxController {
  var clothes = <Map<String, dynamic>>[].obs;
  final List<String> categories = ['All', 'tops', 'bottoms', 'one-piece'];
  var selectedCategory = 'All'.obs;
  var filteredClothes = <Map<String, dynamic>>[].obs;

  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _initializeFirestore();
  }

  /// Initialize Firestore with error handling
  void _initializeFirestore() {
    try {
      _firestore.collection('clothes')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
        (snapshot) {
          try {
            clothes.assignAll(snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return data;
            }).toList());
            updateFilteredClothes();
          } catch (e) {
            print('Error processing Firestore data: $e');
            // Continue with empty list
            clothes.assignAll([]);
            updateFilteredClothes();
          }
        },
        onError: (error) {
          print('Firestore error: $error');
          // Continue with empty list
          clothes.assignAll([]);
          updateFilteredClothes();
        },
      );
    } catch (e) {
      print('Error initializing Firestore: $e');
      // Initialize with empty list
      clothes.assignAll([]);
      updateFilteredClothes();
    }
  }

  Future<void> addClothingItem(String name, String imageUrl, String category,
      {bool isLongTop = false}) async {
    try {
      final newItem = {
        'name': name,
        'image': imageUrl,
        'category': category,
        'isLongTop': isLongTop,
        'createdAt': FieldValue.serverTimestamp(),
      };
      final docRef = await _firestore.collection('clothes').add(newItem);
      print('Clothing item added successfully');
    } catch (e) {
      print('Error adding clothing item: $e');
      // Continue without throwing error
    }
  }

  Future<void> removeClothingItem(int index) async {
    try {
      if (index >= 0 && index < clothes.length) {
        final item = clothes[index];
        if (item['id'] != null) {
          await _firestore.collection('clothes').doc(item['id']).delete();
          print('Clothing item removed successfully');
        }
      }
    } catch (e) {
      print('Error removing clothing item: $e');
      // Continue without throwing error
    }
  }

  Future<void> updateClothingItem(int index, String name, String category) async {
    try {
      if (index >= 0 && index < clothes.length) {
        final item = clothes[index];
        if (item['id'] != null) {
          await _firestore.collection('clothes').doc(item['id']).update({
            'name': name,
            'category': category,
          });
          print('Clothing item updated successfully');
        }
      }
    } catch (e) {
      print('Error updating clothing item: $e');
      // Continue without throwing error
    }
  }

  void updateFilteredClothes() {
    if (selectedCategory.value == 'All') {
      filteredClothes.assignAll(clothes);
    } else {
      filteredClothes.assignAll(
        clothes.where((item) =>
        item['category'].toString().toLowerCase() ==
            selectedCategory.value.toLowerCase()).toList(),
      );
    }
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
    updateFilteredClothes();
  }

  String mapToApiCategory(String category) {
    switch (category.toLowerCase()) {
      case 'tops':
        return 'Top';
      case 'bottoms':
        return 'Bottom';
      case 'one-piece':
        return 'Full body';
      default:
        return category;
    }
  }
}
