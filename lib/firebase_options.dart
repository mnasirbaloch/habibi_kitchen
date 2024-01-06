// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDTTLcBWbovjx8QGOR1UqIACuaEkiztvbc',
    appId: '1:723490719489:web:39492df5d5ed26c0507d00',
    messagingSenderId: '723490719489',
    projectId: 'habibi-kitchen',
    authDomain: 'habibi-kitchen.firebaseapp.com',
    storageBucket: 'habibi-kitchen.appspot.com',
    measurementId: 'G-PW3Z01PDWC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxDsG2Pq_Fb9n9g7gWrR5bSm0HxSy1Rjk',
    appId: '1:723490719489:android:bd688bc109a26d5e507d00',
    messagingSenderId: '723490719489',
    projectId: 'habibi-kitchen',
    storageBucket: 'habibi-kitchen.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6gqaxGgb1qnnpVx5f6vWP7Dlm37BduyQ',
    appId: '1:723490719489:ios:a815bb629a342150507d00',
    messagingSenderId: '723490719489',
    projectId: 'habibi-kitchen',
    storageBucket: 'habibi-kitchen.appspot.com',
    androidClientId: '723490719489-emrbe5s58a4bjfbj67cb831s5f4obee1.apps.googleusercontent.com',
    iosClientId: '723490719489-bkntfpuo2ma609a5slnvadrptooviup3.apps.googleusercontent.com',
    iosBundleId: 'com.example.habibiKitchen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6gqaxGgb1qnnpVx5f6vWP7Dlm37BduyQ',
    appId: '1:723490719489:ios:cd624b990e84b92f507d00',
    messagingSenderId: '723490719489',
    projectId: 'habibi-kitchen',
    storageBucket: 'habibi-kitchen.appspot.com',
    androidClientId: '723490719489-emrbe5s58a4bjfbj67cb831s5f4obee1.apps.googleusercontent.com',
    iosClientId: '723490719489-pqne5mvk9gkkd3ms05spc043p1f79pq7.apps.googleusercontent.com',
    iosBundleId: 'com.example.habibiKitchen.RunnerTests',
  );
}