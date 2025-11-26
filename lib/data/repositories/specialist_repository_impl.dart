import 'package:lab2/data/datasources/specialist_remote_data_source.dart';
import 'package:lab2/domain/entities/specialist_entity.dart';
import 'package:lab2/domain/repositories/specialist_repository.dart';

class SpecialistRepositoryImpl implements SpecialistRepository {
  final SpecialistRemoteDataSource remoteDataSource;

  SpecialistRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<SpecialistEntity>> getSpecialists() async {
    final models = await remoteDataSource.getSpecialists();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<SpecialistEntity> getSpecialistById(int id) async {
    final model = await remoteDataSource.getSpecialistById(id);
    return model.toEntity();
  }
}
