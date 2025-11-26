import 'package:get/get.dart';
import 'package:lab2/domain/entities/profile_entity.dart';
import 'package:lab2/domain/usecases/get_current_user_profile_usecase.dart';

class ProfileController extends GetxController {
  final GetCurrentUserProfileUseCase getCurrentUserProfileUseCase;

  ProfileController({
    required this.getCurrentUserProfileUseCase,
  });

  var profile = Rxn<ProfileEntity>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final data = await getCurrentUserProfileUseCase.execute();
      profile.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
