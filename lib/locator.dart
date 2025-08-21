import 'package:get_it/get_it.dart';

import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'project/activities/logic/cubit.dart';
import 'project/activities/logic/data.dart';
import 'project/activities/logic/repository.dart';
import 'project/auth/logic/auth_cubit.dart';
import 'project/auth/logic/auth_data.dart';
import 'project/auth/logic/auth_repo.dart';
import 'project/profile/logic/cubit.dart';
import 'project/profile/logic/data.dart';
import 'project/profile/logic/repository.dart';
import 'project/properties/logic/cubit.dart';
import 'project/properties/logic/data.dart';
import 'project/properties/logic/repository.dart';

final getIt = GetIt.instance;

void setup() {
  // services
  getIt.registerSingleton<CacheService>(CacheService());
  getIt.registerSingleton<ApiService>(ApiService(getIt<CacheService>()));

  // Home feature dependencies
  // getIt.registerSingleton<HomeCubit>(HomeCubit(HomeRepository(getIt<ApiService>(), getIt<CacheService>())));
  getIt.registerSingleton<ProfileCubit>(
    ProfileCubit(ProfileRepository(ProfileData(getIt<ApiService>(), getIt<CacheService>()))),
  );
  getIt.registerSingleton<AuthCubit>(AuthCubit(AuthRepo(AuthData(getIt<ApiService>(), getIt<CacheService>()))));
  getIt.registerSingleton<ActivitiesCubit>(ActivitiesCubit(ActivitiesRepository(ActivitiesData(getIt<ApiService>()))));
  getIt.registerSingleton<PropertiesCubit>(PropertiesCubit(PropertiesRespository(PropertiesData(getIt<ApiService>()))));
}
