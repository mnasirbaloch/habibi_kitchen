// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  final List<Category> _categories = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  List<Category> get categories => _categories;

  MenuProvider() {
    fetchMenu();
  }
  //a method which fetch categories and there items from firebase
  Future<void> fetchMenu() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection("menu").get();
      print("Successfully completed");
      _categories.clear();

      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();
        final category = Category(
          id: docSnapshot.id,
          name: data['name'],
          items: [], // Initialize items as an empty list
        );

        final subCollectionRef = docSnapshot.reference.collection('items');

        try {
          final subCollectionSnapshot = await subCollectionRef.get();
          for (var subDocSnapshot in subCollectionSnapshot.docs) {
            final subData = subDocSnapshot.data();
            final menuItem = MenuItem(
              id: subDocSnapshot.id,
              name: subData['name'],
              price: subData['price'],
              imageUrl: subData['imageUrl'],
              description: subData['description'],
            );
            if (menuItem.name != 'dummy01') {
              category.items.add(menuItem);
            }
          }
          _categories.add(category);
        } catch (e) {
          print("Error retrieving subcollection: $e");
        }
      }
      print("length:${_categories.length}");
      try {
        int fastFoodIndex = _categories
            .lastIndexWhere((element) => element.name == "Fast Food");
        _categories.insert(0, _categories[fastFoodIndex]);
        _categories.removeAt(fastFoodIndex + 1);
      } catch (e) {
        print(e.toString());
      }
      notifyListeners();
    } catch (e) {
      print("Error completing: $e");
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

class Category {
  final String id;
  final String name;
  final List<MenuItem> items;

  Category({required this.id, required this.name, required this.items});

  factory Category.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemData = json['items'] ?? [];
    final List<MenuItem> items =
        itemData.map((item) => MenuItem.fromJson(item)).toList();

    return Category(
      id: json['id'],
      name: json['name'],
      items: items,
    );
  }
}

class MenuItem {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String description;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['decsription'],
    );
  }
  @override
  String toString() {
    return '''
Id: $id
Name: $name
Price: $price
ImageUlr: $imageUrl
''';
  }
}
