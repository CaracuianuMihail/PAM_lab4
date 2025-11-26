import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/data/models/specialty_model.dart';

abstract class SpecialtyRemoteDataSource {
  Future<List<SpecialtyModel>> getSpecialties();
}

class SpecialtyRemoteDataSourceImpl implements SpecialtyRemoteDataSource {
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/v5/feed';
  final http.Client client;

  SpecialtyRemoteDataSourceImpl({http.Client? client})
      : client = client ?? http.Client();

  @override
  Future<List<SpecialtyModel>> getSpecialties() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        
        // Extract specialities array from JSON
        if (jsonData is Map && jsonData.containsKey('specialities')) {
          final specialitiesData = jsonData['specialities'] as List;
          return specialitiesData
              .map((specialtyJson) => SpecialtyModel.fromJson(specialtyJson))
              .toList();
        }
        
        throw Exception('Specialities data not found in response');
      } else {
        throw Exception('Failed to load specialties: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching specialties: $e');
    }
  }
}
