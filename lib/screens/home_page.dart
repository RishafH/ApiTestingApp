import 'package:flutter/material.dart';
import 'package:sampleapp/screens/add_object.dart';
import 'package:sampleapp/screens/delete_object.dart';
import 'package:sampleapp/screens/object_by_id.dart';
import 'package:sampleapp/screens/get_objects_page.dart';
import 'package:sampleapp/screens/partial_update.dart';
import 'package:sampleapp/screens/update_object.dart';
import '../widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("REST API Methods")),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 26.0,
          vertical: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeButton(
              title: "GET - Fetch All Objects",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ObjectsPage()));
              },
            ),
            const SizedBox(height: 12),
            HomeButton(title: "GET - Fetch Object by ID", onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ObjectsByIdPage()));
            }),
            const SizedBox(height: 12),
            HomeButton(
              title: "POST - Add Object",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AddObjectPage()));
              },
            ),
            const SizedBox(height: 12),
            HomeButton(
              title: "PUT - Update Object",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateObjectPage()));
              },
            ),
            const SizedBox(height: 12),
            HomeButton(
              title: "PATCH - Partial Update",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PatchObjectPage()));
              },
            ),
            const SizedBox(height: 12),
            HomeButton(
              title: "DELETE - Remove Object",
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => DeleteObjectPage()));
              },
            ),
                     ],
        ),
      ),
    );
  }
}
