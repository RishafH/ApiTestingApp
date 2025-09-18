   import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/object_model.dart';

class SingleObjectPage extends StatefulWidget {
  const SingleObjectPage({super.key});

  @override
  State<SingleObjectPage> createState() => _SingleObjectPageState();
}

class _SingleObjectPageState extends State<SingleObjectPage> {
  final ApiService api = ApiService();
  late Future<ObjectModel> _futureObject;

  @override
  void initState() {
    super.initState();
     _futureObject = api.fetchObjectById("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single Object')),
     body: FutureBuilder<ObjectModel>(
  future: _futureObject, 
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          color: Colors.red.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Error loading object:\n${snapshot.error}",
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else if (!snapshot.hasData) {
      return const Center(child: Text("No object found."));
    }

    final obj = snapshot.data!;

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
),
    );
  }
}
