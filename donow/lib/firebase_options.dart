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
    apiKey: 'AIzaSyA-VV1K5Kps_PE8B-yPY6anfVyQff_kkR4',
    appId: '1:618790631213:web:bb63f5e498014e494a05a4',
    messagingSenderId: '618790631213',
    projectId: 'donow-6e206',
    authDomain: 'donow-6e206.firebaseapp.com',
    storageBucket: 'donow-6e206.appspot.com',
    measurementId: 'G-J3F6P8XW18',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBYrU9T2dCt2v470nO4WT37J4xkDVC7q8',
    appId: '1:618790631213:android:97ec2405294e7ef14a05a4',
    messagingSenderId: '618790631213',
    projectId: 'donow-6e206',
    storageBucket: 'donow-6e206.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXK2UtdqX5z92awWw5ngMLIvc2Rqe0x4g',
    appId: '1:618790631213:ios:6d3d016bf7203be84a05a4',
    messagingSenderId: '618790631213',
    projectId: 'donow-6e206',
    storageBucket: 'donow-6e206.appspot.com',
    iosClientId:
        '618790631213-7o1lms6e3itkjbg50vv2gfs1ut7fb84g.apps.googleusercontent.com',
    iosBundleId: 'com.example.donow',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDXK2UtdqX5z92awWw5ngMLIvc2Rqe0x4g',
    appId: '1:618790631213:ios:9c45cf3db3b78a8f4a05a4',
    messagingSenderId: '618790631213',
    projectId: 'donow-6e206',
    storageBucket: 'donow-6e206.appspot.com',
    iosClientId:
        '618790631213-bso5nnpmolbp1edclo0bqe9g5s9shn49.apps.googleusercontent.com',
    iosBundleId: 'com.example.donow.RunnerTests',
  );
}
