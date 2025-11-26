import 'package:lab2/data/datasources/profile_remote_data_source.dart';
import 'package:lab2/domain/entities/profile_entity.dart';
import 'package:lab2/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileEntity> getCurrentUserProfile() async {
    final model = await remoteDataSource.getCurrentUserProfile();
    return model.toEntity();
  }
}
