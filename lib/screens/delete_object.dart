import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DeleteObjectPage extends StatefulWidget {
  const DeleteObjectPage({super.key});

  @override
  State<DeleteObjectPage> createState() => _DeleteObjectPageState();
}

class _DeleteObjectPageState extends State<DeleteObjectPage> {
  final ApiService api = ApiService();
  bool _isLoading = false;

  Future<void> _deleteDummyObject() async {
    setState(() => _isLoading = true);

    try {

      const idToDelete = "ff8081819782e69e0199557128cf7584";

      await api.deleteObject(idToDelete);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Object deleted successfully!")),
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
      appBar: AppBar(title: const Text("Delete Object (DELETE)")),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _deleteDummyObject,
                child: const Text("Delete Dummy Object"),
              ),
      ),
    );
  }
}
