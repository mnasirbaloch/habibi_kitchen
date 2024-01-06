// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:habibi_kitchen/reuseable_widget/resueable_widget.dart';
import 'package:provider/provider.dart';

import '../../common_methods/email_validator.dart';
import '../../common_methods/snackbar_.dart';
import '../../provider/user_auth/pass_visibility.dart';
import '../../provider/user_auth/user_auth_provider.dart';

class SignUpTab extends StatefulWidget {
  const SignUpTab({super.key});

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
  //fullname field controller
  late TextEditingController fullNameController;

  //email field controller
  late TextEditingController emailController;
  //mobile field controller
  late TextEditingController mobileFieldController;
  //password field controller
  late TextEditingController passwordController;
  //initializing variable declared late
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    fullNameController = TextEditingController();
    mobileFieldController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    MyFirebaseAuthProvider myFirebaseAuthProvider =
        Provider.of<MyFirebaseAuthProvider>(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: getPaddedText(
              text: "Fill in the detail below,",
              textAlignment: TextAlign.start,
              left: 10,
              fontSize: 14,
            ),
          ),
          //textfield for full name
          decoratedReusableTextField(
            text: "Full Name",
            icon: Icons.person,
            isPasswordType: false,
            controller: fullNameController,
            borderColor: Colors.transparent,
            borderWidth: 0,
            marginFromAllSide: 10,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name can not be empty';
              }

              return null;
            },
          ),
          //textfield for email
          decoratedReusableTextField(
            text: "Email",
            icon: Icons.email_outlined,
            isPasswordType: false,
            controller: emailController,
            borderColor: Colors.transparent,
            borderWidth: 0,
            textInputType: TextInputType.emailAddress,
            marginFromAllSide: 10,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email can not be empty';
              }
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter valid email';
              }
              return null;
            },
          ),

          //text field for password
          Consumer<PassVisibilityProvider>(
            builder: (context, value, child) {
              return decoratedReusablePasswordField(
                text: "Password",
                icon: Icons.key_outlined,
                isPasswordType: value.getPassVisibilityStatus,
                controller: passwordController,
                borderColor: Colors.transparent,
                borderWidth: 0,
                marginFromAllSide: 10,
                togglePasswordVisibility: () {
                  value.togglePasswordVisibility();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password can not be empty';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 character';
                  }
                  return null;
                },
              );
            },
          ),

          ElevatedButton(
            onPressed: () async {
              if (!fieldValidator(
                  buildContext: context,
                  editingController: fullNameController,
                  minLenght: 5,
                  fieldName: "Full Name")) {
                return;
              }
              if (!emailVelidator(
                  buildContext: context,
                  emailEditingController: emailController)) return;
              //validate password
              if (!passwordValidator(
                  buildContext: context,
                  passwordEditingController: passwordController)) {
                return;
              }
              try {
                await myFirebaseAuthProvider.registerUserWithEmailPass(
                    email: emailController.text,
                    password: passwordController.text);

                showSnackBar(
                    context: context,
                    content:
                        "Account created successfully. Check your email to verify your account.",
                    duration: const Duration(seconds: 3));
              } catch (e) {
                showSnackBar(
                    context: context,
                    content: "Exception Occur ${e.toString()}",
                    duration: const Duration(seconds: 2));
              }
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) =>
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.blue,
              ),
            ),
            child: const Text(
              "Create Account",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
