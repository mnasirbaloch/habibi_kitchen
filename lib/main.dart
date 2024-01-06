import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habibi_kitchen/provider/cart_provider/cart_provider.dart';
import 'package:habibi_kitchen/provider/menu_provider/menu_provider.dart';
import 'package:habibi_kitchen/provider/order_provider/order_provider.dart';
import 'package:habibi_kitchen/provider/time_provider.dart';
import 'package:habibi_kitchen/provider/user_auth/google_authentication.dart';
import 'package:habibi_kitchen/provider/user_auth/pass_visibility.dart';
import 'package:habibi_kitchen/provider/user_auth/user_auth_provider.dart';
import 'package:habibi_kitchen/screens/confirm_order.dart';
import 'package:habibi_kitchen/screens/my_cart_screen.dart';
import 'package:habibi_kitchen/screens/tab_view_home_screen.dart';
import 'package:habibi_kitchen/screens/order_description_screen.dart';
import 'package:habibi_kitchen/screens/track_order_screen.dart';
import 'package:habibi_kitchen/screens/uesr_authentication/authentication_screen.dart';
import 'package:habibi_kitchen/screens/product_description_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyFirebaseAuthProvider>(
          create: (context) => MyFirebaseAuthProvider(),
        ),
        ChangeNotifierProvider<GoogleAuthenticationProvider>(
          create: (context) => GoogleAuthenticationProvider(context),
        ),
        ChangeNotifierProvider<MenuProvider>(
          create: (context) => MenuProvider(),
        ),
        ChangeNotifierProvider<PassVisibilityProvider>(
          create: (context) => PassVisibilityProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) {
            if (kDebugMode) {
              print("userId${FirebaseAuth.instance.currentUser?.uid}");
            }
            return OrderProvider(
                FirebaseAuth.instance.currentUser?.uid ?? 'null');
          },
        ),
        ChangeNotifierProvider<MyTimeProvider>(
          create: (context) => MyTimeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MyAppWrapper(),
          '/authentication': (context) => const UserAuthenticationScreen(),
          '/home': (context) => const HomeScreenTabView(),
          '/productDescription': (context) => const ProductDescriptionScreen(),
          '/mycart': (context) => const MyCartScreen(),
          '/confirmOrder': (context) => ConfirmOrderScreen(),
          '/orderTracking': (context) => const OrderTrackingWidget(),
          '/orderDescriptionScreen': (context) =>
              const OrderDescriptionScreen(),
        },
      ),
    );
  }
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final myFirebaseAuthProvider =
          Provider.of<MyFirebaseAuthProvider>(context);

      return myFirebaseAuthProvider.getCurrentUser == null
          ? const UserAuthenticationScreen()
          : const HomeScreenTabView();
    });
  }
}
