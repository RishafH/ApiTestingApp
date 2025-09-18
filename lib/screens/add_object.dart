import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/object_model.dart';

class AddObjectPage extends StatefulWidget {
  const AddObjectPage({super.key});

  @override
  State<AddObjectPage> createState() => _AddObjectPageState();
}

class _AddObjectPageState extends State<AddObjectPage> {
  final ApiService api = ApiService();
  bool _isLoading = false;
  ObjectModel? _createdObject;

  Future<void> _addDummyObject() async {
    setState(() {
      _isLoading = true;
      _createdObject = null;
    });

    try {
      final newObject = ObjectModel(
        name: "Apple MacBook Pro 16",
        data: {
          "year": 2019,
          "price": 1849.99,
          "CPU model": "Intel Core i9",
          "Hard disk size": "1 TB",
        },
      );

      final created = await api.createObject(newObject);

      setState(() {
        _createdObject = created;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Object created! ID: ${created.id}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Objects")),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addDummyObject,
                    child: const Text("Add Object"),
                  ),
                  const SizedBox(height: 20),
                  if (_createdObject != null)
                    Card(
                      margin: const EdgeInsets.all(16),
                      child: ListTile(
                        title: Text(_createdObject!.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _createdObject!.data!.entries
                              .map((e) => Text("${e.key}: ${e.value}"))
                              .toList(),
                        ),
                        trailing: Text(
                          _createdObject!.id ?? "",
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
