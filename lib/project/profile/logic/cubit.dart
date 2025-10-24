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
      emit(state.copyWith(fetchUserStatus: Status.success, user: userData));
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

  void updateUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String imagePath,
  }) async {
    emit(state.copyWith(updateUserStatus: Status.loading));
    try {
      final user = await _userRepository.updateUser(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        imagePath: imagePath,
      );
      emit(state.copyWith(updateUserStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(updateUserStatus: Status.error, callback: e.toString()));
    }
  }

  void uploadDocuments({
    required String nationalId,
    required String iban,
    required String certificateNumber,
    required String nationalIdFile,
    required String ibanFile,
    required String certificateFile,
  }) async {
    emit(state.copyWith(uploadDocumentsStatus: Status.loading));
    try {
      final user = await _userRepository.uploadDocuments(
        nationalId: nationalId,
        iban: iban,
        certificateNumber: certificateNumber,
        nationalIdFile: nationalIdFile,
        ibanFile: ibanFile,
        certificateFile: certificateFile,
      );
      emit(state.copyWith(uploadDocumentsStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(uploadDocumentsStatus: Status.error, callback: e.toString()));
    } finally {
      emit(state.copyWith(uploadDocumentsStatus: Status.initial));
    }
  }
}
