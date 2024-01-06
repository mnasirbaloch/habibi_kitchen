import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habibi_kitchen/reuseable_widget/resueable_widget.dart';
import 'package:habibi_kitchen/screens/uesr_authentication/authentication_tab.dart';
import 'package:habibi_kitchen/provider/user_auth/google_authentication.dart';
import 'package:provider/provider.dart';

//A screen which will be handling login and signup processes.
class UserAuthenticationScreen extends StatefulWidget {
  const UserAuthenticationScreen({super.key});

  @override
  State<UserAuthenticationScreen> createState() =>
      _UserAuthenticationScreenState();
}

class _UserAuthenticationScreenState extends State<UserAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<GoogleAuthenticationProvider>(context);
    GoogleAuthenticationProvider googleAuthenticationProvider =
        Provider.of<GoogleAuthenticationProvider>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      color: primaryColor,
      child: Scaffold(
        // drawer: buildDrawer(context, myFirebaseAuthProvider),
        resizeToAvoidBottomInset: false,

        body: SafeArea(
          child: Container(
            color: primaryColor,
            width: mediaQueryData.size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  getPaddedText(
                    top: 0,
                    text: "Welcome To,",
                    textColor: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  getPaddedText(
                    text: "Habibi Kitchen",
                    textColor: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    top: 5,
                    bottom: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 2,
                          ),
                          child: getPaddedText(
                            text: "Login With",
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Selector<GoogleAuthenticationProvider, bool>(
                          selector: (p0, p1) => p1.isGoogleSignInProgress,
                          builder: (context, value, child) {
                            return value == true
                                ? const CircularProgressIndicator()
                                : InkWell(
                                    child: const SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircleAvatar(
                                        backgroundColor: secondaryColor,
                                        child: Image(
                                          image: AssetImage(
                                            'assets/logos/google_logo.png',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      googleAuthenticationProvider
                                          .signInWithGoogle(context: context);
                                    },
                                  );
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AuthenticationTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const Color primaryColor = Colors.white;
// const Color secondaryColor = Color.fromARGB(255, 224, 6, 108);
const Color secondaryColor = Color(0xff483d8b);
