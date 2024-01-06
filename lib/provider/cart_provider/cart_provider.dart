import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  double get totalAmount {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void addToCart(CartItem item) {
    _cartItems.add(item);
    print('item added to cart');
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void removeFromCartByIndex(int index) {
    print("method remove at index invoked");
    if (index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  CartItem? getCartItemWithIndex(int index) {
    if (index < cartItems.length) {
      return cartItems[index];
    } else {
      return null;
    }
  }

  void incrementQuantityByOne({required int index}) {
    cartItems[index].quantity++;
    notifyListeners();
  }

  void decrementQuantityByOne({required int index}) {
    if (cartItems[index].quantity == 1) {
      return;
    } else {
      cartItems[index].quantity--;
      notifyListeners();
    }
  }
}

class CartItem {
  String categoryName;
  final String id;
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.categoryName,
    required this.quantity,
  });
}
