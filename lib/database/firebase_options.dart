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
    apiKey: 'AIzaSyAPYTLBSC46jwysbF0oZsiAqy_puh4dLHM',
    appId: '1:654920545900:web:ecf7e9bbce31f914fa4a49',
    messagingSenderId: '654920545900',
    projectId: 'book-distribution-10d76',
    authDomain: 'book-distribution-10d76.firebaseapp.com',
    storageBucket: 'book-distribution-10d76.appspot.com',
    measurementId: 'G-W8X6RQ86EV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_bWl6Vn2piEz9_8WSNeoz96m-ZhlgtWg',
    appId: '1:654920545900:android:5f330b23d6830e13fa4a49',
    messagingSenderId: '654920545900',
    projectId: 'book-distribution-10d76',
    storageBucket: 'book-distribution-10d76.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABLPVjyLE2JYs4xoFgvoJHJripcZxb_Yk',
    appId: '1:654920545900:ios:57c0fa46d04192bffa4a49',
    messagingSenderId: '654920545900',
    projectId: 'book-distribution-10d76',
    storageBucket: 'book-distribution-10d76.appspot.com',
    iosBundleId: 'com.example.bookDistributionCaseOne',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABLPVjyLE2JYs4xoFgvoJHJripcZxb_Yk',
    appId: '1:654920545900:ios:2a1d0f907c3fd152fa4a49',
    messagingSenderId: '654920545900',
    projectId: 'book-distribution-10d76',
    storageBucket: 'book-distribution-10d76.appspot.com',
    iosBundleId: 'com.example.bookDistributionCaseOne.RunnerTests',
  );
}
