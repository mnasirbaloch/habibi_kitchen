// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:habibi_kitchen/provider/menu_provider/menu_provider.dart';
import 'package:habibi_kitchen/provider/user_auth/user_auth_provider.dart';
import 'package:habibi_kitchen/reuseable_widget/app_bar.dart';
import 'package:habibi_kitchen/reuseable_widget/resueable_widget.dart';
import 'package:habibi_kitchen/screens/uesr_authentication/authentication_screen.dart';
import 'package:provider/provider.dart';
import '../provider/user_auth/google_authentication.dart';

//home screen where user can view different categories and their items
class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    //creating instances of providers
    MyFirebaseAuthProvider myFirebaseAuthProvider =
        Provider.of<MyFirebaseAuthProvider>(context);
    MenuProvider menuPovider = Provider.of<MenuProvider>(context);
    late List<Category> categoryList = menuPovider.categories;
//text to show on appbar either username or anonymous user
    String textToDisplayAtAppBar =
        myFirebaseAuthProvider.getCurrentUser?.displayName ?? 'Habibi Kitchen';
//returning a scaffold object
    return Scaffold(
      //calling getAppBar() function which return an object of AppBar
      appBar: getAppBar(
        iconData: Icons.notes_outlined,
        titleWidget: Text(
          textToDisplayAtAppBar,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.normal,
          ),
        ),
        imageUrl: myFirebaseAuthProvider.getCurrentUser?.photoURL,
        onProfileIconTap: () {
          myFirebaseAuthProvider.logoutHandler(
            Provider.of<GoogleAuthenticationProvider>(context),
            context,
          );
        },
      ),
      //body of scaffoled, here padding is used to give some space in screen
      body: Padding(
        padding: const EdgeInsets.all(20),
        //a column which contains some text and list views which shows user categories and their elements
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //a method which return text with defined padding
            getPaddedText(
              textAlignment: TextAlign.start,
              text: 'Online Food',
              left: 0,
              textScaleFactor: 1.2,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            const SizedBox(
              height: 5,
            ),
            // a row widget which show text and emoji
            Row(
              children: [
                const Text(
                  "Delivery  ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textScaleFactor: 1.2,
                ),
                RichText(
                  text: const TextSpan(
                    text: "👨‍🍳",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //expanded widget which contains two lists, outer vertical which represent
            //categories and inner horizontal which represent element of each category
            Expanded(
              //listview to return categories
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categoryList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, outerIndex) {
                  Category category = categoryList[outerIndex];

// a column which contains category name and a horizontal scrollable list which show element of category
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(category.name),
                      SizedBox(
                        height:
                            200, // Set the desired height for the inner horizontal ListView
                        //listview for showing elements horizontally
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: category.items.map((item) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: getMenuItemViewContainer(menuItem: item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// a method which will return a container which show info about food-item which include,
//pic,name,price and button to go to detail page
Container getMenuItemViewContainer({
  required MenuItem menuItem,
  Function()? onTap,
  BuildContext? context,
}) {
  // main container which holds other elements
  return Container(
    margin: const EdgeInsets.only(top: 5, bottom: 5, right: 15),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    height: MediaQuery.of(context!).size.height * 1,
    width: MediaQuery.of(context).size.width * 0.25,
    decoration: getBoxDecoration(
      borderRadius: 5,
      blurRadius: 1,
      spreadRadius: 1,
      yOffSet: 0,
    ),
    // color: Colors.red,
    // A column which contains an image on top, product title, price and a button to go to the description page
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // container for showing the product image,
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(menuItem.imageUrl),
        ),
        const SizedBox(
          height: 4,
        ),
        // text widget to show the name of the food-item
        Text(
          menuItem.name,
          maxLines: 1,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        // text widget to show the price of the food item
        Text(
          "Rs ${menuItem.price}",
          overflow: TextOverflow.fade,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 10,
        ),
        // an InkWell which contains a button and when the user taps on it, the user moves to the description page
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: getBoxDecoration(
              borderRadius: 3,
              blurRadius: 2,
              yOffSet: 1,
              spreadRadius: 1,
            ),
            child: const Icon(
              Icons.arrow_forward,
              size: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

//A method which will return decoration for container depending on the specified values
Decoration getBoxDecoration({
  double borderRadius = 8,
  String? bgImageUrl,
  ImageType? imageType,
  double spreadRadius = 1,
  double blurRadius = 2,
  double xOffset = 0,
  double yOffSet = 2,
}) {
  return BoxDecoration(
    color: Colors.white,
    image: imageType == null
        ? null
        : imageType == ImageType.AssetImage
            ? DecorationImage(image: AssetImage(bgImageUrl!))
            : DecorationImage(
                image: NetworkImage(bgImageUrl!), fit: BoxFit.cover),
    boxShadow: [
      BoxShadow(
        color: secondaryColor.withOpacity(
          0.2,
        ),
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: Offset(xOffset, yOffSet),
      ),
    ],
    border: Border.all(
      color: Colors.transparent,
      width: 0,
    ),
    borderRadius: BorderRadius.circular(borderRadius),
  );
}

Decoration getBoxDecorationInside({
  double borderRadius = 8,
  String? bgImageUrl,
  ImageType? imageType,
  double spreadRadius = 1,
  double blurRadius = 2,
  double xOffset = 0,
  double yOffSet = 2,
}) {
  return BoxDecoration(
    color: Colors.white,
    image: imageType == null
        ? null
        : imageType == ImageType.AssetImage
            ? DecorationImage(image: AssetImage(bgImageUrl!))
            : DecorationImage(
                image: NetworkImage(bgImageUrl!), fit: BoxFit.cover),
    boxShadow: [
      BoxShadow(
        color: secondaryColor.withOpacity(0.2),
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: Offset(xOffset, yOffSet),
      ),
    ],
    border: Border.all(
      color: Colors.transparent,
      width: 0,
    ),
    borderRadius: BorderRadius.circular(borderRadius),
  );
}

enum ImageType { AssetImage, NetworkImage }

//Product Image
/*
Image(
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            isAntiAlias: true,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const LinearProgressIndicator();
              }
            },
            image: NetworkImage(
              menuItem.imageUrl,
            ),
          ),
          */
