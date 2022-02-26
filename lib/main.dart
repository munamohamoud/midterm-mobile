import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDsd-VPpNbG5r8_Z5Ay85bVkdQ5GN30Zbw", // Your apiKey
      appId:
          "1:96753874324:web:83d3450952b3f057fecb81:android:9187c6c365e5c99dfecb81", // Your appId
      messagingSenderId: "96753874324", // Your messagingSenderId
      projectId: "fanpage-app-222", // Your projectId
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fan Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}
