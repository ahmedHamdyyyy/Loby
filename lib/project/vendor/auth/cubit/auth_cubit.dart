import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/user_model.dart';
import '../data/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(const AuthState());
  final AuthRepo _repo;

  Future<void> signup(UserModel user) async {
    emit(state.copyWith(signupStatus: Status.loading));
    try {
      final addedUser = await _repo.signup(user: user);
      emit(state.copyWith(signupStatus: Status.success, msg: 'Signup successful', user: addedUser));
    } catch (e) {
      emit(state.copyWith(signupStatus: Status.error, msg: e.toString()));
    }
  }

  Future<void> signin({required String email, required String password}) async {
    emit(state.copyWith(signinStatus: Status.loading));
    try {
      final user = await _repo.signin(email: email, password: password);
      emit(state.copyWith(msg: 'Authentication successful', signinStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(signinStatus: Status.error, msg: e.toString().replaceAll('Exception: ', '')));
    }
  }
  Future<void> signout() async {
    emit(state.copyWith(signoutStatus: Status.loading));
    try {
      await _repo.signout();
      emit(state.copyWith(signoutStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(signoutStatus: Status.error, msg: e.toString()));
    }
  }
}
