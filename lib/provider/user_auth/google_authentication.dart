import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habibi_kitchen/provider/user_auth/user_auth_provider.dart';
import 'package:provider/provider.dart';

import '../../common_methods/snackbar_.dart';

class GoogleAuthenticationProvider with ChangeNotifier {
  bool isGoogleSignInProgress = false;
  User? user;
  late MyFirebaseAuthProvider myFirebaseAuthProvider;
  GoogleAuthenticationProvider(BuildContext context) {
    myFirebaseAuthProvider =
        Provider.of<MyFirebaseAuthProvider>(context, listen: false);
  }

  void toggleGoogleSignInProgress() {
    isGoogleSignInProgress = !isGoogleSignInProgress;
    notifyListeners();
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    toggleGoogleSignInProgress();
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential = await myFirebaseAuthProvider
            .signInWithUserCredential(authCredential: credential);
        user = userCredential.user;
        notifyListeners();
        toggleGoogleSignInProgress();
      } on FirebaseAuthException catch (e) {
        toggleGoogleSignInProgress();
        if (e.code == 'account-exists-with-different-credential') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            GoogleAuthenticationProvider.customSnackBar(
              content: 'The account already exists with a different credential',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            GoogleAuthenticationProvider.customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        toggleGoogleSignInProgress();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          GoogleAuthenticationProvider.customSnackBar(
            content: 'Error occurred using Google Sign In. Try again.',
          ),
        );
      }
    } else {
      toggleGoogleSignInProgress();
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context,
          content: "Please Select Google Account To Continue,");
    }
    return;
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await myFirebaseAuthProvider.logoutUser();
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: "Logged out successfully");
      user = myFirebaseAuthProvider.getCurrentUser;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        GoogleAuthenticationProvider.customSnackBar(
          content: 'Error signing out. Try again.${e.toString()}',
        ),
      );
    }
    return;
  }
}
