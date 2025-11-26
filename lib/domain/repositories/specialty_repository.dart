import 'package:lab2/domain/entities/specialty_entity.dart';

abstract class SpecialtyRepository {
  Future<List<SpecialtyEntity>> getSpecialties();
}
