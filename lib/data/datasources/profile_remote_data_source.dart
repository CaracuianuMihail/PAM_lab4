import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getCurrentUserProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/v5/feed';
  final http.Client client;

  ProfileRemoteDataSourceImpl({http.Client? client})
      : client = client ?? http.Client();

  @override
  Future<ProfileModel> getCurrentUserProfile() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        
        // Extract user object from JSON
        if (jsonData is Map && jsonData.containsKey('user')) {
          final userData = jsonData['user'];
          return ProfileModel(
            name: userData['name'] ?? 'User',
            location: userData['location'] ?? 'Unknown',
            imageUrl: userData['profile_image'] ?? 'https://i.pravatar.cc/300',
          );
        }
        
        throw Exception('User data not found in response');
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }
}
