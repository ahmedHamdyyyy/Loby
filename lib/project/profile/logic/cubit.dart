import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../models/user.dart';
import 'repository.dart';

part 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(ProfileState());
  final ProfileRepository _userRepository;

  Future<void> fetchUser() async {
    emit(state.copyWith(fetchUserStatus: Status.loading));
    try {
      final userData = await _userRepository.fetchUserData();
      emit(state.copyWith(fetchUserStatus: Status.success, user: userData.user, vendorRole: userData.role));
    } catch (e) {
      emit(state.copyWith(fetchUserStatus: Status.error, callback: e.toString()));
    } finally {
      emit(state.copyWith(fetchUserStatus: Status.initial));
    }
  }

  void chooseVendorRole(VendorRole role) async {
    emit(state.copyWith(chooseVendorRole: Status.loading));
    try {
      await _userRepository.setVendorRole(role);
      emit(state.copyWith(chooseVendorRole: Status.success, vendorRole: role));
    } catch (e) {
      emit(state.copyWith(chooseVendorRole: Status.error, callback: e.toString()));
    } finally {
      emit(state.copyWith(chooseVendorRole: Status.initial));
    }
  }
}
