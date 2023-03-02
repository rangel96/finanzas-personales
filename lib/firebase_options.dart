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
    apiKey: 'AIzaSyDzdkaOWpOMrjzQJVRrmEX4VLcGKhNtTrs',
    appId: '1:104800812244:web:6092186aaaf9f1035dcf41',
    messagingSenderId: '104800812244',
    projectId: 'finanzas-personales-af41d',
    authDomain: 'finanzas-personales-af41d.firebaseapp.com',
    storageBucket: 'finanzas-personales-af41d.appspot.com',
    measurementId: 'G-H9QDX0D22L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDx1QTufbHaW3AkGaAQP1Ll-tytsJhAR4Y',
    appId: '1:104800812244:android:5e683a01a85032185dcf41',
    messagingSenderId: '104800812244',
    projectId: 'finanzas-personales-af41d',
    storageBucket: 'finanzas-personales-af41d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAti23mwhVq9lLKPYZtvaQJ0Ren4Ctw_2k',
    appId: '1:104800812244:ios:2c93c1c2ec7e399b5dcf41',
    messagingSenderId: '104800812244',
    projectId: 'finanzas-personales-af41d',
    storageBucket: 'finanzas-personales-af41d.appspot.com',
    iosClientId: '104800812244-cn1mq318nen0990rkl6r43p8sm8ct8v9.apps.googleusercontent.com',
    iosBundleId: 'com.example.finanzasPersonales',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAti23mwhVq9lLKPYZtvaQJ0Ren4Ctw_2k',
    appId: '1:104800812244:ios:2c93c1c2ec7e399b5dcf41',
    messagingSenderId: '104800812244',
    projectId: 'finanzas-personales-af41d',
    storageBucket: 'finanzas-personales-af41d.appspot.com',
    iosClientId: '104800812244-cn1mq318nen0990rkl6r43p8sm8ct8v9.apps.googleusercontent.com',
    iosBundleId: 'com.example.finanzasPersonales',
  );
}