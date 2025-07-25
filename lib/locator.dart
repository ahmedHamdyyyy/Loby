import 'package:get_it/get_it.dart';

import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'project/vendor/Home/cubit/home_cubit.dart';
import 'project/vendor/Home/data/home_repository.dart';
import 'project/vendor/activities/cubit/cubit.dart';
import 'project/vendor/activities/data/data.dart';
import 'project/vendor/activities/data/repository.dart';
import 'project/vendor/auth/cubit/auth_cubit.dart';
import 'project/vendor/auth/data/auth_data.dart';
import 'project/vendor/auth/data/auth_repo.dart';
import 'project/vendor/properties/cubit/cubit.dart';
import 'project/vendor/properties/data/data.dart';
import 'project/vendor/properties/data/repository.dart';
import 'project/vendor/user/cubit/cubit.dart';
import 'project/vendor/user/data/data.dart';
import 'project/vendor/user/data/repository.dart';

final getIt = GetIt.instance;

void setup() {
  // services
  getIt.registerSingleton<CacheService>(CacheService());
  getIt.registerSingleton<ApiService>(ApiService(getIt<CacheService>()));

  // Home feature dependencies
  getIt.registerSingleton<HomeCubit>(HomeCubit(HomeRepository(getIt<ApiService>(), getIt<CacheService>())));
  getIt.registerSingleton<AuthCubit>(AuthCubit(AuthRepo(AuthData(getIt<ApiService>(), getIt<CacheService>()))));
  getIt.registerSingleton<UserCubit>(UserCubit(UserRepository(UserData(getIt<ApiService>(), getIt<CacheService>()))));
  getIt.registerSingleton<ActivitiesCubit>(ActivitiesCubit(ActivitiesRepository(ActivitiesData(getIt<ApiService>()))));
  getIt.registerSingleton<PropertiesCubit>(PropertiesCubit(PropertiesRespository(PropertiesData(getIt<ApiService>()))));
}
