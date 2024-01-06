import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:habibi_kitchen/provider/user_auth/google_authentication.dart';

class MyFirebaseAuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User? _user;
  bool isLoginInProgress = false;

  MyFirebaseAuthProvider() {
    _user = _firebaseAuth.currentUser; // Initialize the current user
  }

  FirebaseAuth get getFireBaseAuth => _firebaseAuth;
  User? get getCurrentUser => _user; // Getter to retrieve the current user

  void toggleLoginInProgress() {
    isLoginInProgress = !isLoginInProgress; // Toggle the login progress flag
    notifyListeners(); // Notify listeners of the change
  }

  Future<void> registerUserWithEmailPass(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user; // Assign the registered user
      await sendEmailVerificationEmail(user: _user!); // Send email verification
      notifyListeners();
    } catch (error) {
      throw Exception(
          "Account Creation Failed! Exception => ${error.toString()}"); // Throw exception if account creation fails
    }
  }

  Future<UserCredential> signInWithUserCredential(
      {required AuthCredential authCredential}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(authCredential);
      _user = userCredential.user; // Assign the registered user

      notifyListeners();
      return userCredential;
    } catch (error) {
      throw Exception(
          "Account Creation Failed! Exception => ${error.toString()}"); // Throw exception if account creation fails
    }
  }

  Future<void> loginUserWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user; // Assign the logged-in user
      toggleLoginInProgress(); // Toggle the login progress flag
      notifyListeners(); // Notify listeners of the change
    } catch (error) {
      throw Exception(
          "Logining Failed! Exception => ${error.toString()}"); // Throw exception if login fails
    }
  }

  Future<bool> logoutUser() async {
    try {
      await _firebaseAuth.signOut(); // Sign out the user
      _user = _firebaseAuth.currentUser; // Clear the user data
      notifyListeners(); // Notify listeners of the change
      return true; // Return true to indicate successful logout
    } catch (error) {
      throw Exception(
          "Logout Failed! Exception => ${error.toString()}"); // Throw exception if logout fails
    }
  }

  bool isVerifiedUser({required User user}) {
    return user.emailVerified; // Check if the user is verified
  }

  Future<bool> sendEmailVerificationEmail({required User user}) async {
    try {
      await user.sendEmailVerification(); // Send email verification to the user
      return true; // Return true to indicate successful email sending
    } catch (error) {
      throw Exception(
          "Sending Email Failed! Exception => ${error.toString()}"); // Throw exception if sending email fails
    }
  }

  Future<String> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
          email: email); // Send password reset email
      return "Password Reset Email Send Successfully"; // Return true to indicate successful email sending
    } catch (error) {
      return error.toString(); // Return false if sending email fails
    }
  }

  void logoutHandler(GoogleAuthenticationProvider googleAuthenticationProvider,
      BuildContext ctx) {
    // myFirebaseAuthProvider.logoutUser();
    User? user = _user;
    if (user != null) {
      // User is logged in
      List<UserInfo> providerData = user.providerData;

      // Check each provider data for the sign-in method
      for (UserInfo userInfo in providerData) {
        if (userInfo.providerId == 'google.com') {
          // User is logged in with Google Sign-In
          googleAuthenticationProvider.signOut(context: ctx);
        } else if (userInfo.providerId == 'password') {
          // User is logged in with email/password authentication
          logoutUser();
        }
        // Add more conditions for other sign-in methods if needed
      }
    }
  }
}
