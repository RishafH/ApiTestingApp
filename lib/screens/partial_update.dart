import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/object_model.dart';

class PatchObjectPage extends StatefulWidget {
  const PatchObjectPage({super.key});

  @override
  State<PatchObjectPage> createState() => _PatchObjectPageState();
}

class _PatchObjectPageState extends State<PatchObjectPage> {
  final ApiService api = ApiService();
  bool _isLoading = false;
  ObjectModel? _patchedObject;

  Future<void> _patchDummyObject() async {
    setState(() {
      _isLoading = true;
      _patchedObject = null;
    });

    try {
  
      const idToPatch = "ff8081819782e69e0199557128cf7584";

      final patched = await api.patchObject(idToPatch, {
        "name": "Partially Updated MacBook",
        "data": {
          "price": 1999.99, 
        },
      });

      setState(() {
        _patchedObject = patched;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Object patched successfully!")),
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
      appBar: AppBar(title: const Text("Patch Object (PATCH)")),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _patchDummyObject,
                    child: const Text("Patch Object"),
                  ),
                  const SizedBox(height: 20),
                  if (_patchedObject != null)
                    Card(
                      margin: const EdgeInsets.all(16),
                      child: ListTile(
                        title: Text(_patchedObject!.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _patchedObject!.data?.entries
                                  .map((e) => Text("${e.key}: ${e.value}"))
                                  .toList() ??
                              [const Text("No data")],
                        ),
                        trailing: Text(
                          _patchedObject!.id ?? "",
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
