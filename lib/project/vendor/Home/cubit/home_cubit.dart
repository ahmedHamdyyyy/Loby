import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(const HomeState());
  final HomeRepository _homeRepository;

  Future<void> loadUserProfile() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final user = _homeRepository.getCachedUser();
      emit(state.copyWith(status: HomeStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: e.toString()));
    }
  }
}
