import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/object_model.dart';

class ObjectsPage extends StatefulWidget {
  const ObjectsPage({super.key});

  @override
  State<ObjectsPage> createState() => _ObjectsPageState();
}

class _ObjectsPageState extends State<ObjectsPage> {
  final ApiService api = ApiService(); //api instance for Api services
  late Future<List<ObjectModel>> _futureObjects;// futureobjects for future building object list

  @override
  void initState() {
    super.initState();
    _futureObjects = api.fetchObjects(); //call fetch objects and store data in _futureobjects
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Objects List')),
      body: FutureBuilder<List<ObjectModel>>(
        future: _futureObjects, //wait for future objects
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { //show loading indicator while waiting
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) { //show error message if error occurs
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

          final objects = snapshot.data!; //store available data in objects

          return ListView.builder(
            itemCount: objects.length,
            itemBuilder: (context, index) {
              final obj = objects[index]; //current object in the list

              return Card(
                              child: ListTile(
                  title: Text(
                    obj.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
                  ),
                  subtitle: obj.data != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: obj.data!.entries
                              .map(
                                (entry) => Text(
                                  "${entry.key}: ${entry.value}",
                                  style: Theme.of(context).textTheme.bodySmall,
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
