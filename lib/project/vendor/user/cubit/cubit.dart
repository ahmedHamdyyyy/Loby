import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/user_model.dart';
import '../data/repository.dart';

part 'state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(super.initialState, this._userRepository);
  final UserRepository _userRepository;

  void getCachedUser() {
    emit(state.copyWith(fetchUserStatus: Status.initial));
    try {
      final user = _userRepository.getCachedUser();
      emit(state.copyWith(fetchUserStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(fetchUserStatus: Status.error, callback: e.toString()));
    }
  }

  Future<void> fetchUser() async {
    emit(state.copyWith(fetchUserStatus: Status.loading));
    try {
      final user = await _userRepository.fetchUser(state.user.id);
      emit(state.copyWith(fetchUserStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(fetchUserStatus: Status.error, callback: e.toString()));
    }
  }
}
