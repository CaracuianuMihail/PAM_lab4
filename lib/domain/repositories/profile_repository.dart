import 'package:lab2/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getCurrentUserProfile();
}
