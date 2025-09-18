import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/object_model.dart';

class UpdateObjectPage extends StatefulWidget {
  const UpdateObjectPage({super.key});

  @override
  State<UpdateObjectPage> createState() => _UpdateObjectPageState();
}

class _UpdateObjectPageState extends State<UpdateObjectPage> {
  final ApiService api = ApiService();
  bool _isLoading = false;
  ObjectModel? _updatedObject;

  Future<void> _updateDummyObject() async {
    setState(() {
      _isLoading = true;
      _updatedObject = null;
    });

    try {
    
      const idToUpdate = "ff8081819782e69e0199557128cf7584";

      final updated = await api.updateObject(
        idToUpdate,
        ObjectModel(
          name: "Updated MacBook Pro",
          data: {
            "year": 2023,
            "price": 2499.99,
            "CPU model": "Apple M2 Pro",
            "Hard disk size": "2 TB",
          },
        ),
      );

      setState(() {
        _updatedObject = updated;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Object updated successfully!")),
      );
    } catch (e) {
      print("Unexpected error: $e");
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
      appBar: AppBar(title: const Text("Update Object (PUT)")),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _updateDummyObject,
                    child: const Text("Update Object"),
                  ),
                  const SizedBox(height: 20),
                  if (_updatedObject != null)
                    Card(
                      margin: const EdgeInsets.all(16),
                      child: ListTile(
                        title: Text(_updatedObject!.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _updatedObject!.data!.entries
                              .map((e) => Text("${e.key}: ${e.value}"))
                              .toList(),
                        ),
                        trailing: Text(
                          _updatedObject!.id ?? "",
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
