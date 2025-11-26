import 'package:lab2/domain/entities/specialty_entity.dart';
import 'package:lab2/domain/repositories/specialty_repository.dart';

class GetSpecialtiesUseCase {
  final SpecialtyRepository repository;

  GetSpecialtiesUseCase(this.repository);

  Future<List<SpecialtyEntity>> execute() async {
    return await repository.getSpecialties();
  }
}
