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
    _firestore.collection('clothes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      clothes.assignAll(snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList());
      updateFilteredClothes();
    });
  }

  Future<void> addClothingItem(String name, String imageUrl, String category,
      {bool isLongTop = false}) async {
    final newItem = {
      'name': name,
      'image': imageUrl,
      'category': category,
      'isLongTop': isLongTop,
      'createdAt': FieldValue.serverTimestamp(),
    };
    final docRef = await _firestore.collection('clothes').add(newItem);
    // No need to add to clothes manually, stream listener will handle it!
  }

  Future<void> removeClothingItem(int index) async {
    final item = clothes[index];
    if (item['id'] != null) {
      await _firestore.collection('clothes').doc(item['id']).delete();
    }
    // No need to remove from clothes manually, stream listener will handle it!
  }

  Future<void> updateClothingItem(int index, String name, String category) async {
    final item = clothes[index];
    if (item['id'] != null) {
      await _firestore.collection('clothes').doc(item['id']).update({
        'name': name,
        'category': category,
      });
      // No need to update clothes manually, stream listener will handle it!
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
