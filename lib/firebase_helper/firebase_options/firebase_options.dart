import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
          apiKey: 'AIzaSyBzveTGzdHdDfDRzPt_FKGHIpLKBxYhZHs',
          appId: '1:351038267388:ios:f323a911b9f90eda9e5c79',
          messagingSenderId: '351038267388',
          projectId: 'e-commerce-58a94',
          iosBundleId: 'com.example.ecommerceApp',
          storageBucket: 'e-commerce-58a94.appspot.com');
    } else {
      //Android
      return const FirebaseOptions(
          apiKey: 'AIzaSyAHRORePIKHUOQZxZI8D7OI848UlwFKJ6Y',
          appId: '1:351038267388:android:0024a018845858609e5c79',
          messagingSenderId: '351038267388',
          projectId: 'e-commerce-58a94',
          storageBucket: 'e-commerce-58a94.appspot.com');
    }
  }
}
