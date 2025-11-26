import 'package:lab2/data/datasources/specialty_remote_data_source.dart';
import 'package:lab2/domain/entities/specialty_entity.dart';
import 'package:lab2/domain/repositories/specialty_repository.dart';

class SpecialtyRepositoryImpl implements SpecialtyRepository {
  final SpecialtyRemoteDataSource remoteDataSource;

  SpecialtyRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<SpecialtyEntity>> getSpecialties() async {
    final models = await remoteDataSource.getSpecialties();
    return models.map((model) => model.toEntity()).toList();
  }
}
