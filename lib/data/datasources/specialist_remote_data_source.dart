import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/data/models/specialist_model.dart';

abstract class SpecialistRemoteDataSource {
  Future<List<SpecialistModel>> getSpecialists();
  Future<SpecialistModel> getSpecialistById(int id);
}

class SpecialistRemoteDataSourceImpl implements SpecialistRemoteDataSource {
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/v5/feed';
  final http.Client client;

  SpecialistRemoteDataSourceImpl({http.Client? client})
      : client = client ?? http.Client();

  @override
  Future<List<SpecialistModel>> getSpecialists() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        
        // Extract specialists array from JSON
        if (jsonData is Map && jsonData.containsKey('specialists')) {
          final specialistsData = jsonData['specialists'] as List;
          return specialistsData
              .map((specialistJson) => SpecialistModel.fromJson(specialistJson))
              .toList();
        }
        
        throw Exception('Specialists data not found in response');
      } else {
        throw Exception('Failed to load specialists: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching specialists: $e');
    }
  }

  @override
  Future<SpecialistModel> getSpecialistById(int id) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/details'));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        
        // Build complete specialist data from all parts of the response
        if (jsonData is Map && jsonData.containsKey('doctor')) {
          final doctorData = Map<String, dynamic>.from(jsonData['doctor']);
          
          // Add appointment, timing, and locations from the top level
          if (jsonData.containsKey('appointment')) {
            doctorData['appointment'] = jsonData['appointment'];
          }
          if (jsonData.containsKey('timing')) {
            doctorData['timing'] = jsonData['timing'];
          }
          if (jsonData.containsKey('locations')) {
            doctorData['locations'] = jsonData['locations'];
          }
          
          return SpecialistModel.fromJson(doctorData);
        }
        
        throw Exception('Doctor data not found in response');
      } else {
        throw Exception('Failed to load specialist details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching specialist by id: $e');
    }
  }
}
