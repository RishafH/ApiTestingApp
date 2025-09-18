
  import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/object_model.dart';

class ObjectsByIdPage extends StatefulWidget {
  const ObjectsByIdPage({super.key});

  @override
  State<ObjectsByIdPage> createState() => _ObjectsByIdPageState();
}

class _ObjectsByIdPageState extends State<ObjectsByIdPage> {
  final ApiService api = ApiService();
  late Future<List<ObjectModel>> _futureObjects;

  @override
  void initState() {
    super.initState();
   _futureObjects = api.fetchObjectsByIds(["1", "3"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Objects List bu IDs')),
      body: FutureBuilder<List<ObjectModel>>(
        future: _futureObjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Card(
                margin: const EdgeInsets.all(16),
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Error loading objects:\n${snapshot.error}",
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No objects found."),
            );
          }

          final objects = snapshot.data!;

          return ListView.builder(
            itemCount: objects.length,
            itemBuilder: (context, index) {
              final obj = objects[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    obj.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: obj.data != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: obj.data!.entries
                              .map(
                                (entry) => Text(
                                  "${entry.key}: ${entry.value}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                              )
                              .toList(),
                        )
                      : const Text(
                          "No additional data",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                  trailing: Text(
                    obj.id ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
