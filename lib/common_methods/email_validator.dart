import 'package:flutter/material.dart';
import 'package:habibi_kitchen/common_methods/snackbar_.dart';

import '../reuseable_widget/resueable_widget.dart';

void validateEmailAndShowError(TextEditingController emailController) {
  String enteredEmail = emailController.text;

  // Regular expression pattern to validate email format
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  if (enteredEmail.isEmpty) {
    emailController.clear();
    emailController.text = '';
  } else if (!emailRegex.hasMatch(enteredEmail)) {
    emailController.text = ''; // Clear the entered email
    emailController.selection = TextSelection.fromPosition(
        const TextPosition(offset: 0)); // Move the cursor to the start
    emailController.selection = TextSelection.fromPosition(TextPosition(
        offset: enteredEmail.length)); // Move the cursor to the end
  }
}

bool emailVelidator(
    {required BuildContext buildContext, required emailEditingController}) {
  if (emailEditingController.text.isEmpty) {
    showSnackBar(context: buildContext, content: "Email Can't Be Empty");
    return false;
  } else if (!emailRegex.hasMatch(emailEditingController.text)) {
    showSnackBar(context: buildContext, content: "Please Enter Valid Email");
    return false;
  }
  return true;
}

bool passwordValidator(
    {required BuildContext buildContext, required passwordEditingController}) {
  if (passwordEditingController.text.isEmpty) {
    showSnackBar(context: buildContext, content: "Password Can't Be Empty");
    return false;
  }
  if (passwordEditingController.text.length < 8) {
    showSnackBar(
        context: buildContext,
        content: "Password must contains at least 8 characters");
    return false;
  }
  return true;
}

bool fieldValidator(
    {required BuildContext buildContext,
    required editingController,
    required int minLenght,
    required String fieldName}) {
  if (editingController.text.isEmpty) {
    showSnackBar(context: buildContext, content: "$fieldName Can't Be Empty");
    return false;
  }
  if (editingController.text.length < minLenght) {
    showSnackBar(
        context: buildContext,
        content: "$fieldName must contains at least 8 characters");
    return false;
  }
  return true;
}
