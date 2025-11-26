import 'package:lab2/domain/entities/specialist_entity.dart';

abstract class SpecialistRepository {
  Future<List<SpecialistEntity>> getSpecialists();
  Future<SpecialistEntity> getSpecialistById(int id);
}
