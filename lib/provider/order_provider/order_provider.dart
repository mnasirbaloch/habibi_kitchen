import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  final String userId;
  List<UserOrder> inProgressOrders = [];
  List<UserOrder> completedOrders = [];

  OrderProvider(this.userId) {
    loadOrders();
  }

  // Sorting comparator based on the timestamp field
  int _orderByTimestamp(UserOrder a, UserOrder b) {
    return b.timestamp.compareTo(a.timestamp);
  }

  Future<void> loadOrders() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      inProgressOrders.clear();
      completedOrders.clear();

      for (final doc in snapshot.docs) {
        final order = UserOrder.fromMap(doc.data());

        if (order.orderStatus == 'Pending' ||
            order.orderStatus == 'In Progress' ||
            order.orderStatus == 'On The Way') {
          inProgressOrders.add(order);
        } else if (order.orderStatus == 'Completed') {
          completedOrders.add(order);
        }
      }

      // Sort the lists based on timestamp
      inProgressOrders.sort(_orderByTimestamp);
      completedOrders.sort(_orderByTimestamp);
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Error Occur during loading orders: $error');
    }
  }
}

class UserOrder {
  final String userName;
  final String phone;
  final String location;
  final List<OrderItem> orderItems;
  final double extraPrice;
  final String orderStatus;
  final String userId;
  final double totalPrice;
  final Timestamp timestamp;
  final String orderId;

  UserOrder({
    required this.userName,
    required this.phone,
    required this.location,
    required this.orderItems,
    required this.extraPrice,
    required this.totalPrice,
    required this.orderStatus,
    required this.userId,
    required this.timestamp,
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userName': userName,
      'phone': phone,
      'location': location,
      'orderItems': orderItems.map((item) => item.toMap()).toList(),
      'extraPrice': extraPrice,
      'orderStatus': orderStatus,
      'userId': userId,
      'totalPrice': totalPrice,
      'timeStamp': timestamp,
    };
  }

  factory UserOrder.fromMap(Map<String, dynamic> map) {
    return UserOrder(
      orderId: map['orderId'],
      userName: map['userName'],
      phone: map['phone'],
      userId: map['userId'],
      location: map['location'],
      orderItems: List<OrderItem>.from(
          map['orderItems'].map((item) => OrderItem.fromMap(item))),
      extraPrice: map['extraPrice'],
      totalPrice: map['totalPrice'],
      orderStatus: map['orderStatus'],
      timestamp: map['timeStamp'],
    );
  }
}

class OrderItem {
  String item;
  int quantity;
  double perItemPrice;
  double totalPrice;

  OrderItem({
    required this.item,
    required this.quantity,
    required this.perItemPrice,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'quantity': quantity,
      'perItemPrice': perItemPrice,
      'totalPrice': totalPrice,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      item: map['item'],
      quantity: map['quantity'],
      perItemPrice: map['perItemPrice'],
      totalPrice: map['totalPrice'],
    );
  }
}
