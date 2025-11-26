import 'package:lab2/domain/entities/profile_entity.dart';
import 'package:lab2/domain/repositories/profile_repository.dart';

class GetCurrentUserProfileUseCase {
  final ProfileRepository repository;

  GetCurrentUserProfileUseCase(this.repository);

  Future<ProfileEntity> execute() async {
    return await repository.getCurrentUserProfile();
  }
}
