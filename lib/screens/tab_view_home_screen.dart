// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:habibi_kitchen/common_methods/snackbar_.dart';
import 'package:provider/provider.dart';

import '../common_methods/build_drawer.dart';
import '../provider/cart_provider/cart_provider.dart';
import '../provider/menu_provider/menu_provider.dart';
import '../provider/user_auth/user_auth_provider.dart';

class HomeScreenTabView extends StatelessWidget {
  const HomeScreenTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final categoryList = menuProvider.categories;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return DefaultTabController(
      length: categoryList.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        drawer: buildDrawer(
          context,
          Provider.of<MyFirebaseAuthProvider>(context),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Habibi\'s Kitchen',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            );
          }),
          backgroundColor: Colors.white,
          elevation: 2,
          actions: const [
            CartIcon(),
            SizedBox(width: 10),
          ],
          bottom: TabBar(
            isScrollable: true,
            padding: EdgeInsets.zero,
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: categoryList.map((category) {
              return Tab(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign: TextAlign.left,
                    category.name,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            indicatorColor: Colors.red,
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: TabBarView(
            children: categoryList.map((category) {
              // Container which shows food items
              return Container(
                color: const Color(0xfff6f6f6),
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(15),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 14),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: category.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/productDescription',
                          arguments: {
                            'categoryIndex': categoryList.indexOf(category),
                            'menuItemIndex': index,
                          },
                        );
                      },
                      child: MenuItemWidget(
                        menuItem: category.items[index],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// A widget which returns the cart icon used to handle cart operations
class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return InkWell(
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: -4,
            left: -2,
            child: Container(
              margin: const EdgeInsets.only(left: 10, bottom: 20),
              height: 35,
              alignment: Alignment.topRight,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: FittedBox(
                  child: Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                      value.cartItems.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      onTap: () {
        if (cartProvider.itemCount == 0) {
          showSnackBar(
            context: context,
            content: "Please add some items to cart first",
          );
        } else {
          Navigator.of(context).pushNamed('/mycart');
        }
      },
    );
  }
}

// A widget to represent the tab bar
class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    Key? key,
    required this.categoryList,
  }) : super(key: key);

  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        color: Colors.white,
        child: TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          controller: DefaultTabController.of(context),
          tabs: categoryList.map((category) {
            return Tab(
              child: Text(
                category.name,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}

// A widget that represents an item for each tab (menu category)
class MyTabBarViewWidget extends StatelessWidget {
  const MyTabBarViewWidget({
    Key? key,
    required this.categoryList,
  }) : super(key: key);

  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: DefaultTabController.of(context),
      children: categoryList.map((category) {
        return Container(
          color: const Color(0xfff6f6f6),
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(15),
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 14),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: category.items.length,
            itemBuilder: (BuildContext context, int index) {
              return MenuItemWidget(
                menuItem: category.items[index],
              );
            },
          ),
        );
      }).toList(),
    );
  }
}

// A widget that contains the product image, name, and price
class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        margin: const EdgeInsets.only(
          left: 6,
          right: 6,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Hero(
                flightShuttleBuilder: (
                  flightContext,
                  animation,
                  flightDirection,
                  fromHeroContext,
                  toHeroContext,
                ) {
                  switch (flightDirection) {
                    case HeroFlightDirection.push:
                      return Material(
                        color: Colors.transparent,
                        child: ScaleTransition(
                          scale: animation.drive(
                            Tween<double>(
                              begin: 0.0,
                              end: 1.0,
                            ).chain(
                              CurveTween(
                                curve: Curves.slowMiddle,
                              ),
                            ),
                          ),
                          child: toHeroContext.widget,
                        ),
                      );
                    case HeroFlightDirection.pop:
                      return Material(
                        color: Colors.transparent,
                        child: fromHeroContext.widget,
                      );
                  }
                },
                tag: menuItem.id,
                child: Container(
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        menuItem.imageUrl,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            FittedBox(
              child: Hero(
                tag: menuItem.hashCode,
                child: Text(
                  menuItem.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Rs ${menuItem.price.formatAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String formatAsFixed(int fractionDigits) {
    final value = double.tryParse(this);
    if (value != null) {
      return value.toStringAsFixed(fractionDigits);
    } else {
      return this;
    }
  }
}
