import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sampleapp/firebase_options.dart';
import 'package:sampleapp/screens/home_page.dart';
import 'package:sampleapp/screens/sample_analysic_page.dart';
import 'themes/theme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
     home: const HomePage(), 
     // home: const SampleAnalysicPage (),
    );
  }
}
