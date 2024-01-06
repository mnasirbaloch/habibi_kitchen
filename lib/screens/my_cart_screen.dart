import 'package:flutter/material.dart';
import 'package:habibi_kitchen/provider/cart_provider/cart_provider.dart';
import 'package:habibi_kitchen/screens/product_description_screen.dart';
import 'package:provider/provider.dart';

import '../common_methods/build_drawer.dart';
import '../provider/user_auth/user_auth_provider.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider myCarProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      drawer:
          buildDrawer(context, Provider.of<MyFirebaseAuthProvider>(context)),
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text("My Cart",
            style: getTextStyle(
              // color: const Color(0xffc24a01),
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff212435),
            size: 24,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(5),
              height: double.maxFinite,
              child: myCarProvider.cartItems.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Item Found",
                            style: getTextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                            child: Text(
                              "Go Home",
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: myCarProvider.itemCount,
                      itemBuilder: (context, index) {
                        return Consumer<CartProvider>(
                          builder: (context, value, child) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                              ),
                              child: generateImageColumnRow(
                                imagePath: myCarProvider
                                        .getCartItemWithIndex(
                                          index,
                                        )
                                        ?.imagePath ??
                                    'https://cdn-icons-png.flaticon.com/128/45/45332.png',
                                text1: myCarProvider
                                    .getCartItemWithIndex(index)!
                                    .name,
                                itemPrice: myCarProvider
                                    .getCartItemWithIndex(index)!
                                    .price
                                    .toString(),
                                totalPrice:
                                    "${myCarProvider.getCartItemWithIndex(index)!.price * myCarProvider.getCartItemWithIndex(index)!.quantity}",
                                cartItem: myCarProvider.cartItems[index],
                                itemIndex: index,
                                cartProvider: myCarProvider,
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
          myCarProvider.itemCount == 0
              ? Container()
              : Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Item Total",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: getTextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            myCarProvider.totalAmount.toString(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: getTextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Other Charges",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: getTextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (myCarProvider.totalAmount * 0.02).toString(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: getTextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Delivery Charges",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: getTextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            myCarProvider.cartItems.isEmpty
                                ? "00"
                                : myCarProvider.totalAmount <= 500
                                    ? "0.0"
                                    : "50.00",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: getTextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Total",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: getTextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            getTotalBill(itemTotal: myCarProvider.totalAmount)
                                .toString(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: getTextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/confirmOrder");
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      20,
                                    )),
                            elevation: MaterialStateProperty.resolveWith(
                              (states) => 1,
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => const Color(0xffc24a01),
                            ),
                          ),
                          child: Text(
                            'Place Order',
                            style: getTextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 1,
      //   items: [
      //     const BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "Home",
      //     ),
      //     const BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart_checkout_outlined),
      //       label: "Cart",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: InkWell(
      //         child: const Icon(
      //           Icons.shopping_bag,
      //         ),
      //         onTap: () {},
      //       ),
      //       label: "Orders",
      //     ),
      //   ],
      // ),
    );
  }
}

//method which return a row which return widget which contain info about menu-item which is in cart
Widget generateImageColumnRow({
  required String imagePath,
  required String text1,
  required String totalPrice,
  required String itemPrice, // Added parameter for item price

  required int itemIndex,
  required CartItem cartItem,
  required CartProvider cartProvider,
}) {
  return Material(
    elevation: 2,
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
    color: Colors.white.withOpacity(1),
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white.withOpacity(0.1),
          ),
          //parent row which contains image on left and two rows on right
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      imagePath,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Image.network(
              //   imagePath,
              //   width: 80,
              //   height: 80,
              //   fit: BoxFit.cover,

              // ),
              const SizedBox(width: 16),
              Flexible(
                fit: FlexFit.tight,
                //a column which contains two rows
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //first-child row of column which display name and price of an item
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Align text1 and itemPrice at the ends
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          //A text widget which show name of item
                          child: Text(
                            text1,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // // Display the item price
                        Text(
                          itemPrice,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    //a row which display two button to increment / decrement quantity and total price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: ProductDescriptionScreen.leftPadding,
                            right: ProductDescriptionScreen.leftPadding,
                            top: 10,
                          ),
                          child: Wrap(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      ProductDescriptionScreen.leftPadding / 2,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffc24a01),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cartProvider.decrementQuantityByOne(
                                            index: itemIndex);
                                      },
                                      child: getPaddedText(
                                        text: '-',
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      cartItem.quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        cartProvider.incrementQuantityByOne(
                                            index: itemIndex);
                                      },
                                      child: getPaddedText(
                                        text: '+',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          totalPrice,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
              ),
              color: Color(
                0xffFE5F00,
              ),
            ),
            child: IconButton(
              iconSize: 15,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
              onPressed: () {
                cartProvider.removeFromCartByIndex(itemIndex);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

TextStyle getTextStyle({
  Color color = Colors.black,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

double getTotalBill({required double itemTotal}) {
  return itemTotal == 0
      ? 0
      : itemTotal <= 500
          ? itemTotal + itemTotal * 0.02
          : itemTotal <= 1000
              ? (itemTotal + itemTotal * 0.02 + 50).toInt().toDouble()
              : (itemTotal + itemTotal * 0.02 + 50).toInt().toDouble();
}
