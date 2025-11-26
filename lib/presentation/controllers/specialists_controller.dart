import 'package:get/get.dart';
import 'package:lab2/domain/entities/specialist_entity.dart';
import 'package:lab2/domain/usecases/get_specialists_usecase.dart';
import 'package:lab2/domain/usecases/get_specialist_by_id_usecase.dart';

class SpecialistsController extends GetxController {
  final GetSpecialistsUseCase getSpecialistsUseCase;
  final GetSpecialistByIdUseCase getSpecialistByIdUseCase;

  SpecialistsController({
    required this.getSpecialistsUseCase,
    required this.getSpecialistByIdUseCase,
  });

  var specialists = <SpecialistEntity>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var selectedDoctor = Rxn<SpecialistEntity>();
  var selectedDateIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpecialists();
  }

  Future<void> fetchSpecialists() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final data = await getSpecialistsUseCase.execute();
      specialists.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectDoctorById(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Always load detailed data from API (ID is ignored, returns same doctor)
      final doctor = await getSpecialistByIdUseCase.execute(id);
      selectedDoctor.value = doctor;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
