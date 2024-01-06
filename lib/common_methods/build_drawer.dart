import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../provider/user_auth/user_auth_provider.dart';

Widget buildDrawer(
    BuildContext context, MyFirebaseAuthProvider myFirebaseAuthProvider) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          margin: const EdgeInsets.all(0),
          accountName: Text(
            FirebaseAuth.instance.currentUser!.displayName ?? 'Anonymous User',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(FirebaseAuth.instance.currentUser!.email!),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
              FirebaseAuth.instance.currentUser?.photoURL ??
                  'https://img.freepik.com/free-icon/user_318-563613.jpg',
            ),
          ),
        ),
        Builder(builder: (context) {
          return ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            // tileColor: Colors.blue.withOpacity(0.2),
            onTap: () {
              // Check current route
              if (ModalRoute.of(context)!.settings.name == '/home') {
                // User is on the home route, perform specific action
                Scaffold.of(context).closeDrawer();
              } else {
                Scaffold.of(context).closeDrawer();
                // User is not on the home route, navigate back to the first route
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
          );
        }),
        Builder(builder: (context) {
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            // tileColor: Colors.blue.withOpacity(0.2),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name == '/mycart') {
                // User is already on the cart route, do nothing
              } else {
                // Check if cart route exists in the stack
                bool cartRouteExists = false;
                Navigator.of(context).popUntil((route) {
                  if (route.settings.name == '/mycart') {
                    cartRouteExists = true;
                  }
                  return route.isFirst;
                });

                if (cartRouteExists) {
                  // Remove all routes above cart route and move back to the cart
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/mycart',
                    ModalRoute.withName(
                        '/home'), // Replace '/home' with the starting route of your app
                  );
                } else {
                  // Move to the cart route
                  Navigator.pushNamed(context, '/mycart');
                }
              }
              Scaffold.of(context).closeDrawer();
            },
          );
        }),
        Builder(
          builder: (context) {
            return ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Track Order'),
              // tileColor: Colors.blue.withOpacity(0.2),
              onTap: () {
                if (ModalRoute.of(context)!.settings.name == '/orderTracking') {
                  // User is already on the cart route, do nothing
                } else {
                  // Check if cart route exists in the stack
                  bool cartRouteExists = false;
                  Navigator.of(context).popUntil((route) {
                    if (route.settings.name == '/orderTracking') {
                      cartRouteExists = true;
                    }
                    return route.isFirst;
                  });

                  if (cartRouteExists) {
                    // Remove all routes above cart route and move back to the cart
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/orderTracking',
                      ModalRoute.withName(
                          '/home'), // Replace '/home' with the starting route of your app
                    );
                  } else {
                    // Move to the cart route
                    Navigator.pushNamed(context, '/orderTracking');
                  }
                }
                Scaffold.of(context).closeDrawer();
              },
            );
          },
        ),
        Builder(
          builder: (context) {
            return ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              // tileColor: Colors.blue.withOpacity(0.2),
              onTap: () {
                myFirebaseAuthProvider.logoutUser();
                Scaffold.of(context).closeDrawer();
              },
            );
          },
        ),
      ],
    ),
  );
}
