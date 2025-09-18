import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class SampleAnalysicPage extends StatefulWidget {
  const SampleAnalysicPage({super.key});

  @override
  State<SampleAnalysicPage> createState() => _SampleAnalysicPageState();
}

class _SampleAnalysicPageState extends State<SampleAnalysicPage> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    _logScreenView();
  }

  Future<void> _logScreenView() async {
    await analytics.logScreenView(
      screenName: 'SampleAnalysicPage',
      screenClass: 'SampleAnalysicPage',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sample Analysic Page")),
      body: const Center(child: Text("Welcome!")),
    );
  }
}
