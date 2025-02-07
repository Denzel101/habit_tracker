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
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCXUX5OFm0snNOKJsQ5RNJEG_87F7fh4HI',
    appId: '1:873133403502:web:b42c2274106f9758d3a57f',
    messagingSenderId: '873133403502',
    projectId: 'habit-tracker-2ee7e',
    authDomain: 'habit-tracker-2ee7e.firebaseapp.com',
    storageBucket: 'habit-tracker-2ee7e.firebasestorage.app',
    measurementId: 'G-K281XKYF5D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBD5vWPQwDx5775KfCHz0c-CaYI1a5TXcs',
    appId: '1:873133403502:android:d0ed7f2238bf8470d3a57f',
    messagingSenderId: '873133403502',
    projectId: 'habit-tracker-2ee7e',
    storageBucket: 'habit-tracker-2ee7e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6ydnTrIKv89KxUDIAFF9z-q1T1HmIQp0',
    appId: '1:873133403502:ios:711ed91fbdb812c6d3a57f',
    messagingSenderId: '873133403502',
    projectId: 'habit-tracker-2ee7e',
    storageBucket: 'habit-tracker-2ee7e.firebasestorage.app',
    androidClientId:
        '873133403502-57pdoj37lpe764fichjete420l4uh565.apps.googleusercontent.com',
    iosClientId:
        '873133403502-k702q1gqj65fscs72t51rrb1b4r51rkl.apps.googleusercontent.com',
    iosBundleId: 'com.example.verygoodcore.habit-tracker',
  );
}
