// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:habibi_kitchen/provider/user_auth/pass_visibility.dart';
import 'package:provider/provider.dart';

import '../../common_methods/email_validator.dart';
import '../../common_methods/snackbar_.dart';
import '../../dialogs/coommon_dialog.dart';
import '../../provider/user_auth/user_auth_provider.dart';
import '../../reuseable_widget/resueable_widget.dart';
import 'authentication_screen.dart';

class LoginTabView extends StatefulWidget {
  const LoginTabView({super.key});

  @override
  State<LoginTabView> createState() => _LoginTabViewState();
}

class _LoginTabViewState extends State<LoginTabView> {
  //email field controller
  late TextEditingController emailController;
  //password field controller
  late TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //initializing variable declared late
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    MyFirebaseAuthProvider myFirebaseAuthProvider =
        Provider.of<MyFirebaseAuthProvider>(context);
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Icon(
              Icons.lock_outline,
              size: 80,
              color: secondaryColor,
            ),

            //textfield for email
            decoratedReusableTextField(
              text: "Email",
              icon: Icons.email_outlined,
              isPasswordType: false,
              labelText: 'Email',
              controller: emailController,
              borderColor: Colors.transparent,
              borderWidth: 0,
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

            //align widget to align forgot password button
            Align(
              alignment: Alignment.centerLeft,
              heightFactor: 1,
              child: TextButton(
                onPressed: () {
                  showEmailInputDialog(
                    context,
                    (userEmail) async {
                      String message = await myFirebaseAuthProvider
                          .resetPassword(email: userEmail);
                      showSnackBar(
                        context: context,
                        content: message,
                      );
                    },
                  );
                },
                child: getPaddedText(
                  text: "Forgot Password?",
                ),
              ),
            ),

            //Login button which will be replaced with progress indicator when user press login button
            Selector<MyFirebaseAuthProvider, bool>(
              selector: (context, myFirebaseAuthProvider) =>
                  myFirebaseAuthProvider.isLoginInProgress,
              builder: (context, isLoginInProcess, child) {
                return Container(
                  child: myFirebaseAuthProvider.isLoginInProgress
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blue,
                            ),
                          ),
                          onPressed: () async {
                            //validate email
                            if (!emailVelidator(
                                buildContext: context,
                                emailEditingController: emailController)) {
                              return;
                            }
                            //validate password
                            if (!passwordValidator(
                                buildContext: context,
                                passwordEditingController:
                                    passwordController)) {
                              return;
                            }
                            try {
                              myFirebaseAuthProvider.toggleLoginInProgress();
                              await myFirebaseAuthProvider
                                  .loginUserWithEmailPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                              showSnackBar(
                                  context: context,
                                  content: "Login Successfull");
                            } catch (e) {
                              myFirebaseAuthProvider.toggleLoginInProgress();
                              showSnackBar(
                                context: context,
                                content: e.toString(),
                              );
                            }
                          },
                          child: const Text(
                            "Login",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
