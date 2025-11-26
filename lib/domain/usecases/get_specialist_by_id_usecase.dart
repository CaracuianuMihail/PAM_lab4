import 'package:lab2/domain/entities/specialist_entity.dart';
import 'package:lab2/domain/repositories/specialist_repository.dart';

class GetSpecialistByIdUseCase {
  final SpecialistRepository repository;

  GetSpecialistByIdUseCase(this.repository);

  Future<SpecialistEntity> execute(int id) async {
    return await repository.getSpecialistById(id);
  }
}
