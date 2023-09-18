import 'package:ecommerse/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/item_model.dart';

class BookmarkProvider with ChangeNotifier {
  List<String> _bookmarkedItemIds = [];
  List<ItemModel> _bookmarkedItems = [];
  List<ItemModel> get bookmarkedItems => _bookmarkedItems;

  bool isBookmarked(String itemId) {
    return _bookmarkedItemIds.contains(itemId);
  }

  Future<void> toggleBookmark(BuildContext context,ItemModel item, String userId) async {
    final String itemId = item.id;
    if (_bookmarkedItemIds.contains(itemId)) {  
      _bookmarkedItemIds.remove(itemId);
      _bookmarkedItems.removeWhere((item) => item.id == itemId);
      showSnackbar(context, "Removed from BookMark");
    } else {
      _bookmarkedItemIds.add(itemId);
      _bookmarkedItems.add(item);
      showSnackbar(context, "Added to BookMark");
    }
    await updateFirestoreBookmarks(userId);
    notifyListeners();
  }

  Future<void> removeItemFromBookMark(BuildContext context, ItemModel item, String userId) async {
    final String itemId = item.id;
    if (_bookmarkedItemIds.contains(itemId)) {
      _bookmarkedItemIds.remove(itemId);
      _bookmarkedItems.removeWhere((bookmarkItem) => bookmarkItem.id == itemId);
      await updateFirestoreBookmarks(userId);

      showSnackbar(context, "Removed from BookMark");
      notifyListeners();
    }
  }

  Future<void> updateFirestoreBookmarks(String userId) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(userId);
      await docRef.update({'bookmark': _bookmarkedItemIds});
    } catch (e) {
      print('Error updating bookmarks in Firestore: $e');
    }
  }

  Future<void> loadBookmarks(String userId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        final bookmarkedItemIds = List<String>.from(userData['bookmark'] ?? []);
        final bookmarkedItems = await fetchBookmarkedItems(bookmarkedItemIds);
        _bookmarkedItemIds = bookmarkedItemIds;
        _bookmarkedItems = bookmarkedItems;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading bookmarks from Firestore: $e');
    }
  }

  Future<List<ItemModel>> fetchBookmarkedItems(List<String> itemIds) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('items').where(FieldPath.documentId, whereIn: itemIds).get();
      final bookmarkedItems = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ItemModel(
          id: doc.id,
          name: data['name'],
          price: data['price'],
          img: data['img'],
          brand: data['brand'],
          category: data['category'],
          quantity: data['quantity']
        );
      }).toList();
      return bookmarkedItems;
    } catch (e) {
      print('Error fetching bookmarked items from Firestore: $e');
      return [];
    }
  }
}
