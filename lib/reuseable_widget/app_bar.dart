import 'package:flutter/material.dart';

// AppBar getAppBar(
//     {required IconData iconData,
//     required Widget titleWidget,
//     required String? imageUrl,
//     bool centerTitle = true,
//     Function()? onProfileIconTap}) {
//   return AppBar(
//     backgroundColor: Colors.transparent,
//     leading: Icon(
//       iconData,
//       color: Colors.black.withOpacity(0.5),
//     ),
//     title: titleWidget,
//     elevation: 0,
//     centerTitle: true,
//     actions: [
//       InkWell(
//         onTap: onProfileIconTap,
//         child: CircleAvatar(
//           child: imageUrl == null
//               ? const Image(
//                   image: AssetImage('assets/images/default_profile_pic.png'))
//               : Image(
//                   image: NetworkImage(imageUrl),
//                 ),
//         ),
//       ),
//       const SizedBox(
//         width: 10,
//       ),
//     ],
//   );
AppBar getAppBar(
    {required IconData iconData,
    required Widget titleWidget,
    required String? imageUrl,
    bool centerTitle = true,
    Function()? onProfileIconTap}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: Icon(
      iconData,
      color: Colors.black.withOpacity(0.5),
    ),
    title: titleWidget,
    elevation: 0,
    centerTitle: true,
    actions: [
      InkWell(
        onTap: onProfileIconTap,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shop,color: Colors.black,),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
