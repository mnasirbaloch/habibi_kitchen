//A dialog which ask user to check gamil inbox for verification purpose
import 'package:flutter/material.dart';

Future<void> showVerificationEmailSendSuccessfullyDialog(
    {required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Habibi Kitchen'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Congratulations, Your account created successfully'),
              Text(
                  'Please check your gmail spam folder and verify your email address'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showEmailInputDialog(
    BuildContext context, void Function(String) callback) {
  TextEditingController emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Email'),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: 'Enter your email to reset password',
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              String enteredEmail = emailController.text;
              callback(
                  enteredEmail); // Call the callback function with the entered email
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

// a method which show a dialogue for verifying data before placement of order
void showUserDetailsDialog({
  required BuildContext context,
  required String userName,
  required String userMobile,
  required String location,
  required void Function()? onPlaceOrder
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('User Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $userName',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Mobile: $userMobile',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Location: $location',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: onPlaceOrder,
            child: const Text('Place Order'),
          ),
        ],
      );
    },
  );
}
