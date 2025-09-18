
class ObjectModel {
  final String? id;
  final String name;
  final Map<String, dynamic>? data;


  ObjectModel({
    this.id,
    required this.name,
    this.data,
  });

  // factory constructor to create ObjectModel from JSON map (server response)
  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    // return mapped object (safely casting data if present)
    return ObjectModel(
      id: json['id']?.toString(), // server might return id as number or string
      name: json['name'] ?? '', // default to empty string if missing
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'] as Map)
          : null, // convert data to Map<String,dynamic> if present
    );
  }

  // convert this model to JSON (for POST body)
  Map<String, dynamic> toJson() {
    // return map with name and data (data default to empty map if null)
    return {
      'name': name,
      'data': data ?? {},
    };
  }
}
