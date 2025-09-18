import 'package:dio/dio.dart';
import '../models/object_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.restful-api.dev',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  
  

  // GET all objects
  Future<List<ObjectModel>> fetchObjects() async {
    final response = await _dio.get(
      '/objects',
    ); // Sends GET request to the API.
    final data = response.data as List; //API returns a JSON array.
    return data
        .map(
          (item) => ObjectModel.fromJson(item),
        ) //Converts each JSON map into an ObjectModel.
        .toList();
  }

  // GET objects by a list of IDs
  Future<List<ObjectModel>> fetchObjectsByIds(List<String> ids) async {
    final idsQuery = ids.join(',');
    final response = await _dio.get(
      '/objects',
      queryParameters: {'id': idsQuery},
    );

    final data = response.data as List;
    return data.map((item) => ObjectModel.fromJson(item)).toList();
  }

  // GET single object by ID
  Future<ObjectModel> fetchObjectById(String id) async {
    final response = await _dio.get('/objects/$id');
    return ObjectModel.fromJson(response.data);
  }

  // POST create new object
  Future<ObjectModel> createObject(ObjectModel object) async {
    final response = await _dio.post('/objects', data: object.toJson());
    return ObjectModel.fromJson(response.data);
  }

  // PUT update existing object by ID
  Future<ObjectModel> updateObject(String id, ObjectModel object) async {
    final response = await _dio.put('/objects/$id', data: object.toJson());
    return ObjectModel.fromJson(response.data);
  }

  // PATCH: Partially update object
  Future<ObjectModel> patchObject(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final response = await _dio.patch('/objects/$id', data: updates);
    return ObjectModel.fromJson(response.data);
  }

  // DELETE object by ID
  Future<void> deleteObject(String id) async {
    await _dio.delete('/objects/$id');
  }

  // HEAD request for object by ID
  Future<Headers> headObject(String id) async {
    final response = await _dio.head('/objects/$id');
    return response.headers;
  }
}
