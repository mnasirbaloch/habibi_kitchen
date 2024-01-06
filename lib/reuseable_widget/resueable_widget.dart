import 'package:flutter/material.dart';

import '../screens/uesr_authentication/authentication_screen.dart';

// a method which return text with given paddings
Padding getPaddedText({
  required String text,
  Color textColor = Colors.black,
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.normal,
  double left = 0,
  double right = 0,
  double top = 0,
  double bottom = 0,
  TextStyle? textStyle,
  double? textScaleFactor,
  TextAlign textAlignment = TextAlign.center,
}) {
  return Padding(
    padding:
        EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
    child: Text(
      text,
      textScaleFactor: textScaleFactor,
      textAlign: textAlignment,
      style: textStyle ??
          TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: 1,
            wordSpacing: 1.1,
            letterSpacing: 1.1,
          ),
    ),
  );
}

//non-decorated resueable text field
TextFormField reusableTextField({
  required String text,
  required IconData icon,
  required bool isPasswordType,
  required TextEditingController controller,
  required String? Function(String?) validator,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: secondaryColor,
    style: const TextStyle(
      color: secondaryColor,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: secondaryColor,
      ), // Icon
      labelText: text,
      labelStyle: const TextStyle(color: secondaryColor),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

//decorated reuseable text field
Container decoratedReusableTextField({
  required String text,
  required IconData icon,
  required bool isPasswordType,
  String? labelText,
  required TextEditingController controller,
  required Color borderColor,
  required double borderWidth,
  double marginFromAllSide = 5,
  TextInputType? textInputType,
  required String? Function(String?) validator,
}) {
  return Container(
    height: 60,
    margin: EdgeInsets.all(marginFromAllSide),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: secondaryColor.withOpacity(
            0.3,
          ),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      validator: validator,
      autocorrect: !isPasswordType,
      cursorColor: secondaryColor,
      style: const TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ), // Icon
        labelText: text,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,

        fillColor: Colors.white.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      keyboardType: textInputType ??
          (isPasswordType
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress),
    ),
  );
}

//decorated reuseable text field
Container decoratedReusablePasswordField({
  required String text,
  required IconData icon,
  required bool isPasswordType,
  required TextEditingController controller,
  required Color borderColor,
  required double borderWidth,
  double marginFromAllSide = 5,
  required String? Function(String?) validator,
  isPasswordVisible = false,
  required void Function()? togglePasswordVisibility,
}) {
  return Container(
    height: 60,
    margin: EdgeInsets.all(marginFromAllSide),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: secondaryColor.withOpacity(
            0.3,
          ),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      validator: validator,
      autocorrect: !isPasswordType,
      cursorColor: secondaryColor,
      style: const TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: togglePasswordVisibility,
          child: !isPasswordType
              ? const Icon(
                  Icons.visibility,
                  color: Colors.grey,
                )
              : const Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                ),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ), // Icon
        labelText: text,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,

        fillColor: Colors.white.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    ),
  );
}

RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
