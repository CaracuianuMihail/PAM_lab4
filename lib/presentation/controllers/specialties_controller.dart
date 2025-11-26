import 'package:get/get.dart';
import 'package:lab2/domain/entities/specialty_entity.dart';
import 'package:lab2/domain/usecases/get_specialties_usecase.dart';

class SpecialtiesController extends GetxController {
  final GetSpecialtiesUseCase getSpecialtiesUseCase;

  SpecialtiesController({
    required this.getSpecialtiesUseCase,
  });

  var specialties = <SpecialtyEntity>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpecialties();
  }

  Future<void> fetchSpecialties() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final data = await getSpecialtiesUseCase.execute();
      specialties.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
