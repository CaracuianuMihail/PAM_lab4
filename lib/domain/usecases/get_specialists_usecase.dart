import 'package:lab2/domain/entities/specialist_entity.dart';
import 'package:lab2/domain/repositories/specialist_repository.dart';

class GetSpecialistsUseCase {
  final SpecialistRepository repository;

  GetSpecialistsUseCase(this.repository);

  Future<List<SpecialistEntity>> execute() async {
    return await repository.getSpecialists();
  }
}
