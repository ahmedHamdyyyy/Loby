import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../models/user_model.dart';
import 'auth_repo.dart';

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
      emit(
        state.copyWith(
          signupStatus: Status.error,
          msg: e.toString() == "[email already registered]" ? "Email already registered" : e.toString(),
        ),
      );
    }
    emit(state.copyWith(signupStatus: Status.initial));
  }

  Future<void> signin({required String email, required String password}) async {
    emit(state.copyWith(signinStatus: Status.loading));
    try {
      final user = await _repo.signin(email: email, password: password);
      emit(state.copyWith(msg: 'Authentication successful', signinStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(signinStatus: Status.error, msg: e.toString().replaceAll('Exception: ', '')));
    }
    emit(state.copyWith(signinStatus: Status.initial));
  }

  void signout() async {
    emit(state.copyWith(signoutStatus: Status.loading));
    try {
      final message = await _repo.signout();
      emit(state.copyWith(signoutStatus: Status.success, msg: message, user: UserModel.non));
    } catch (e) {
      emit(state.copyWith(signoutStatus: Status.error, msg: e.toString()));
    }
    emit(state.copyWith(signoutStatus: Status.initial));
  }

  void verifyEmail(String email) async {
    emit(state.copyWith(verifyEmailStatus: Status.loading));
    try {
      await _repo.verifyEmail(email: email);
      emit(state.copyWith(verifyEmailStatus: Status.success, msg: 'Verification email sent'));
    } catch (e) {
      emit(state.copyWith(verifyEmailStatus: Status.error, msg: e.toString()));
    }
    emit(state.copyWith(verifyEmailStatus: Status.initial));
  }

  void confirmOtp(String email, String otp, bool willSignup) async {
    emit(state.copyWith(confirmOtpStatus: Status.loading));
    try {
      await _repo.confirmOtp(email, otp, willSignup);
      emit(state.copyWith(confirmOtpStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(confirmOtpStatus: Status.error, msg: e.toString()));
    }
    emit(state.copyWith(confirmOtpStatus: Status.initial));
  }

  void resetPassword(String email, String newPassword) async {
    emit(state.copyWith(resetPasswordStatus: Status.loading));
    try {
      final message = await _repo.resetPassword(email, newPassword);
      emit(state.copyWith(resetPasswordStatus: Status.success, msg: message));
    } catch (e) {
      emit(state.copyWith(resetPasswordStatus: Status.error, msg: e.toString()));
    }
    emit(state.copyWith(resetPasswordStatus: Status.initial));
  }
}
