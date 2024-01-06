// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habibi_kitchen/common_methods/snackbar_.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../dialogs/coommon_dialog.dart';
import '../provider/cart_provider/cart_provider.dart';
import 'my_cart_screen.dart';

class ConfirmOrderScreen extends StatelessWidget {
  ConfirmOrderScreen({Key? key}) : super(key: key);

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController receiverMobileNumberEditingController =
      TextEditingController();
  final TextEditingController locationEditingController =
      TextEditingController();
  final TextEditingController extraInstructionEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 236, 236),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Confirm Order",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            // color: Color(0xfff85d01),
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff212435),
            size: 24,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Image(
            image: AssetImage('assets/images/order_now_official.png'),
            height: 130,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 5,
              bottom: 5,
            ),
            child: Text(
              "Please fill in the detail below to confirm your order",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
          ),
          Expanded(
            // height: MediaQuery.of(context).size.height * 0.32,
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildTextField(
                        controller: nameEditingController,
                        hintText: "Enter your full name",
                        labelText: "Receiver Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid name';
                          }
                          return null;
                        },
                      ),
                      buildTextField(
                        controller: receiverMobileNumberEditingController,
                        hintText: "Enter receiver mobile number",
                        labelText: "Receiver Mobile Number",
                        textInputType: TextInputType.number,
                        maxLength: 11,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid receiver mobile number';
                          } else if (value.length != 11) {
                            return 'Please enter complete mobile number';
                          }
                          return null;
                        },
                      ),
                      buildTextField(
                        controller: locationEditingController,
                        hintText: "Enter your location",
                        labelText: "Delivery Address",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Location of receiver cannot be empty';
                          }
                          return null;
                        },
                      ),
                      buildTextField(
                        controller: extraInstructionEditingController,
                        hintText: "Additional Instruction",
                        labelText: "Additional Instruction",
                        validator: null,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(92, 255, 94, 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            alignment: Alignment.center,
                            child: const Text("Order Items"),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Table(
                          border: TableBorder.all(
                            width: 1.0,
                            color: const Color(0xffFE5F00),
                          ),
                          children: const [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Text(
                                    "Name",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "Quantity",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "Item Price",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "Total Price",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 5,
                          ),
                          child: Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                              return ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: cartProvider.itemCount,
                                itemBuilder: (context, index) {
                                  return Table(
                                    border: TableBorder.all(
                                      width: 1.0,
                                      color: const Color(0xffFE5F00),
                                    ),
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              child: Text(
                                                cartProvider
                                                    .cartItems[index].name,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              cartProvider
                                                  .cartItems[index].quantity
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              cartProvider
                                                  .cartItems[index].price
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              (cartProvider.cartItems[index]
                                                          .quantity *
                                                      cartProvider
                                                          .cartItems[index]
                                                          .price)
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              elevation: 10,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 15,
                  bottom: 0,
                ),
                margin: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    buildTotalRow(
                      label: "Item Total",
                      value: cartProvider.totalAmount.toString(),
                    ),
                    buildTotalRow(
                      label: "Extra Charges",
                      value:
                          (getTotalBill(itemTotal: cartProvider.totalAmount) -
                                  cartProvider.totalAmount)
                              .toString(),
                    ),
                    buildTotalRow(
                      label: "Total Price",
                      value: getTotalBill(itemTotal: cartProvider.totalAmount)
                          .toString(),
                    ),
                    MaterialButton(
                      // height: 35,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          showUserDetailsDialog(
                            context: context,
                            userName: nameEditingController.text,
                            userMobile:
                                receiverMobileNumberEditingController.text,
                            location: locationEditingController.text,
                            onPlaceOrder: () async {
                              Navigator.of(context).pop();
                              String? result = await saveOrder(
                                fullName: nameEditingController.text,
                                mobileNumber:
                                    receiverMobileNumberEditingController.text,
                                location: locationEditingController.text,
                                extraInfo:
                                    extraInstructionEditingController.text,
                                cartProvider: cartProvider,
                              );
                              if (result == null) {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                cartProvider.clearCart();
                                showSnackBar(
                                  context: context,
                                  content: "Your Order Placed Successfully",
                                  textAlign: TextAlign.center,
                                  duration: const Duration(
                                    seconds: 3,
                                  ),
                                );
                              } else {
                                showSnackBar(
                                    context: context,
                                    content: 'Error: $result');
                              }
                            },
                          );
                        }
                      },
                      color: const Color(0xffff5f00),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        side: BorderSide(color: Color(0xffff5f00), width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 3),
                      textColor: const Color(0xffffffff),
                      minWidth: 140,
                      child: const Text(
                        "Confirm Order",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? labelText,
    FormFieldValidator<String>? validator,
    TextInputType? textInputType,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      child: TextFormField(
        controller: controller,
        obscureText: false,
        textAlign: TextAlign.start,
        maxLength: maxLength,
        maxLines: 1,
        keyboardType: textInputType,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xff000000),
        ),
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Color(0xffff5f00), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Color(0xffff5f00), width: 1),
          ),
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
          filled: true,
          fillColor: const Color(0xfff2f2f3),
          isDense: false,
          contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        ),
      ),
    );
  }

  Widget buildTotalRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ... (other parts of your code)

  Future<String?> saveOrder({
    required String fullName,
    required String mobileNumber,
    required String location,
    required String extraInfo,
    required CartProvider cartProvider,
  }) async {
    try {
      final orderData = {
        'orderId': const Uuid().v4(),
        'userName': fullName,
        'phone': mobileNumber,
        'location': location,
        'orderItems': getOrderItemFromCarItems(cartProvider),
        'extraPrice': getTotalBill(itemTotal: cartProvider.totalAmount) -
            cartProvider.totalAmount,
        'orderStatus': 'Pending',
        'totalPrice': getTotalBill(itemTotal: cartProvider.totalAmount),
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'timeStamp': Timestamp.now(),
      };

      await FirebaseFirestore.instance
          .collection('orders')
          .add(orderData); //if this completed successfully no exception
      // will be thrown means the order record is stored in database, now we have to empty cart and move to home

      // cartProvider.clearCart();
      return null;

      // print('Order saved successfully!');
    } catch (e) {
      return e.toString();
    }
  }

  // ... (other parts of your code)
}

EdgeInsetsGeometry getPaddingForTextFields() {
  return const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15);
}

List<Map<String, dynamic>> getOrderItemFromCarItems(CartProvider cartProvider) {
  List<Map<String, dynamic>> orderItems = [];
  for (CartItem item in cartProvider.cartItems) {
    Map<String, dynamic> orderItemData = {
      'item': item.name,
      'perItemPrice': item.price,
      'quantity': item.quantity,
      'totalPrice': item.quantity * item.price,
    };
    orderItems.add(orderItemData);
  }
  return orderItems;
}
