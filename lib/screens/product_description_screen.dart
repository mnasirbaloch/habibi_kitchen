// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:habibi_kitchen/provider/cart_provider/cart_provider.dart';
import 'package:habibi_kitchen/provider/menu_provider/menu_provider.dart';
import 'package:habibi_kitchen/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../common_methods/build_drawer.dart';
import '../provider/user_auth/user_auth_provider.dart';
import 'tab_view_home_screen.dart';

// Screen for displaying product description
class ProductDescriptionScreen extends StatefulWidget {
  const ProductDescriptionScreen({Key? key, int initialQuantity = 1})
      : super(key: key);
  static const double leftPadding = 10;

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  int quantity = 1;
  late MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    // Accessing the menu provider using Provider.of
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final categoryIndex = arguments['categoryIndex'] as int;
    final menuItemIndex = arguments['menuItemIndex'] as int;
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    menuItem = menuProvider.categories[categoryIndex].items[menuItemIndex];

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      drawer:
          buildDrawer(context, Provider.of<MyFirebaseAuthProvider>(context)),
      appBar: AppBar(
        title: const Text(
          'Product Description',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff212435),
            size: 24,
          ),
        ),
        actions: const [
          CartIcon(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Hero(
            tag: menuItem.id,
            child: Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.30,
              // padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: const Color(0xffEAEAEA), boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  spreadRadius: 5,
                  blurRadius: 7,
                )
              ]),
              child: Material(
                elevation: 5,
                shadowColor: const Color(0xffc24a01),
                clipBehavior: Clip.antiAlias,
                // shape: const CircleBorder(),
                child: Image.network(
                  menuItem.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                ProductDescriptionScreen.leftPadding, 5, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    0,
                    ProductDescriptionScreen.leftPadding,
                    0,
                  ),
                  child: Align(
                    alignment: const Alignment(-0.9, 0.0),
                    child: Hero(
                      tag: menuItem.hashCode,
                      child: Text(
                        menuItem.name,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontSize: 17,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ProductDescriptionScreen.leftPadding, vertical: 5),
            child: Row(
              children: [
                Text(
                  menuItem.price,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ProductDescriptionScreen.leftPadding / 2,
                    vertical: 2,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffc24a01),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            if (quantity != 1) {
                              quantity = quantity - 1;
                              setState(() {});
                            }
                          },
                          child: getPaddedText(text: '-')),
                      getPaddedText(text: quantity.toString()),
                      InkWell(
                        onTap: () {
                          quantity = quantity + 1;
                          setState(() {});
                        },
                        child: getPaddedText(text: '+'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
                left: ProductDescriptionScreen.leftPadding,
                top: ProductDescriptionScreen.leftPadding + 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Description",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: ProductDescriptionScreen.leftPadding,
                top: ProductDescriptionScreen.leftPadding + 5,
                right: ProductDescriptionScreen.leftPadding),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                menuItem.description,
                textAlign: TextAlign.justify,
                maxLines: 4,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: ProductDescriptionScreen.leftPadding,
                  top: ProductDescriptionScreen.leftPadding + 5),
              child: Text(
                "Recommended Items",
                textAlign: TextAlign.left,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ProductDescriptionScreen.leftPadding),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                itemCount: menuProvider.categories[categoryIndex].items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                        context,
                        '/productDescription',
                        arguments: {
                          'categoryIndex': categoryIndex,
                          'menuItemIndex': index,
                        },
                      );
                    },
                    child: getMenuItemViewContainer(
                      menuItem:
                          menuProvider.categories[categoryIndex].items[index],
                      context: context,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _buildAddToCartButton(
            context: context,
            onPressed: () {
              cartProvider.addToCart(
                createCartItem(
                  buildContext: context,
                  categoryIndex: categoryIndex,
                  imagePath: menuItem.imageUrl,
                  menuItemIndex: menuItemIndex,
                  quantity: quantity,
                ),
              );
              // showSnackBar(
              //     context: context, content: 'Item added to cart successfully');
              SnackBar snackBar = SnackBar(
                content: const Text(
                  'Item Added to Cart Successfully',
                ),
                backgroundColor: Colors.black.withOpacity(0.9),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cartProvider.removeFromCart(
                      cartProvider.cartItems[cartProvider.cartItems.length - 1],
                    );
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                snackBar,
              );
            },
          ),
        ],
      ),
    );
  }

  // Builds the "Add to Cart" button row
  Widget _buildAddToCartButton(
      {required BuildContext context, required Function() onPressed}) {
    return Expanded(
      child: Material(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: ProductDescriptionScreen.leftPadding,
              horizontal: ProductDescriptionScreen.leftPadding + 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: buildTotalRow(
              totalPrice: double.parse(menuItem.price) * quantity,
              onPressed: onPressed),
        ),
      ),
    );
  }
}

// Utility method to get a padded text widget
Widget getPaddedText({required String text, Color color = Colors.white}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
    child: Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
    ),
  );
}

// Builds the row with total price and "Add to Cart" button
Widget buildTotalRow({
  required double totalPrice,
  required Function() onPressed,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Total: Rs. ${totalPrice.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 16),
      ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => const Color(0xffC44C0B),
          ),
        ),
        onPressed: onPressed,
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        label: const Text(
          'Add to Cart',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

CartItem createCartItem({
  required BuildContext buildContext,
  required categoryIndex,
  required int menuItemIndex,
  required int quantity,
  required String imagePath,
}) {
  // Retrieve the necessary data based on categoryIndex and menuItemIndex
  final menuProvider = Provider.of<MenuProvider>(buildContext, listen: false);
  final categoryList = menuProvider.categories;

  final category = categoryList[categoryIndex];
  final menuItem = category.items[menuItemIndex];

  // Create and return the CartItem object
  return CartItem(
    id: menuItem.id,
    categoryName: category.name,
    name: menuItem.name,
    imagePath: imagePath,
    price: double.parse(menuItem.price),
    quantity: quantity,
  );
}
