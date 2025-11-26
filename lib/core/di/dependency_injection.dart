import 'package:get/get.dart';
import 'package:lab2/data/datasources/profile_remote_data_source.dart';
import 'package:lab2/data/datasources/specialist_remote_data_source.dart';
import 'package:lab2/data/datasources/specialty_remote_data_source.dart';
import 'package:lab2/data/repositories/profile_repository_impl.dart';
import 'package:lab2/data/repositories/specialist_repository_impl.dart';
import 'package:lab2/data/repositories/specialty_repository_impl.dart';
import 'package:lab2/domain/repositories/profile_repository.dart';
import 'package:lab2/domain/repositories/specialist_repository.dart';
import 'package:lab2/domain/repositories/specialty_repository.dart';
import 'package:lab2/domain/usecases/get_current_user_profile_usecase.dart';
import 'package:lab2/domain/usecases/get_specialist_by_id_usecase.dart';
import 'package:lab2/domain/usecases/get_specialists_usecase.dart';
import 'package:lab2/domain/usecases/get_specialties_usecase.dart';
import 'package:lab2/presentation/controllers/profile_controller.dart';
import 'package:lab2/presentation/controllers/specialists_controller.dart';
import 'package:lab2/presentation/controllers/specialties_controller.dart';

class DependencyInjection {
  static void init() {
    // Data Sources
    Get.lazyPut<SpecialistRemoteDataSource>(
      () => SpecialistRemoteDataSourceImpl(),
    );
    Get.lazyPut<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(),
    );
    Get.lazyPut<SpecialtyRemoteDataSource>(
      () => SpecialtyRemoteDataSourceImpl(),
    );

    // Repositories
    Get.lazyPut<SpecialistRepository>(
      () => SpecialistRepositoryImpl(Get.find<SpecialistRemoteDataSource>()),
    );
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryImpl(Get.find<ProfileRemoteDataSource>()),
    );
    Get.lazyPut<SpecialtyRepository>(
      () => SpecialtyRepositoryImpl(Get.find<SpecialtyRemoteDataSource>()),
    );

    // Use Cases
    Get.lazyPut(() => GetSpecialistsUseCase(Get.find<SpecialistRepository>()));
    Get.lazyPut(() => GetSpecialistByIdUseCase(Get.find<SpecialistRepository>()));
    Get.lazyPut(() => GetCurrentUserProfileUseCase(Get.find<ProfileRepository>()));
    Get.lazyPut(() => GetSpecialtiesUseCase(Get.find<SpecialtyRepository>()));

    // Controllers
    Get.lazyPut(
      () => SpecialistsController(
        getSpecialistsUseCase: Get.find<GetSpecialistsUseCase>(),
        getSpecialistByIdUseCase: Get.find<GetSpecialistByIdUseCase>(),
      ),
    );
    Get.lazyPut(
      () => ProfileController(
        getCurrentUserProfileUseCase: Get.find<GetCurrentUserProfileUseCase>(),
      ),
    );
    Get.lazyPut(
      () => SpecialtiesController(
        getSpecialtiesUseCase: Get.find<GetSpecialtiesUseCase>(),
      ),
    );
  }
}
