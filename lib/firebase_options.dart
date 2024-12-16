// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBoj7o6RVLyZamGbwj3BQ-Ok7mtKRemECE',
    appId: '1:834665412930:web:2660eb05badc6d493730db',
    messagingSenderId: '834665412930',
    projectId: 'projetadopetauthentification',
    authDomain: 'projetadopetauthentification.firebaseapp.com',
    storageBucket: 'projetadopetauthentification.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMfgZCbduqSyvEr2I42G-P1jIb1bDfuMk',
    appId: '1:834665412930:android:14612663837c86303730db',
    messagingSenderId: '834665412930',
    projectId: 'projetadopetauthentification',
    storageBucket: 'projetadopetauthentification.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBoj7o6RVLyZamGbwj3BQ-Ok7mtKRemECE',
    appId: '1:834665412930:web:54b9fa22a23aa4a33730db',
    messagingSenderId: '834665412930',
    projectId: 'projetadopetauthentification',
    authDomain: 'projetadopetauthentification.firebaseapp.com',
    storageBucket: 'projetadopetauthentification.firebasestorage.app',
  );
}
