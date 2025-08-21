part of 'cubit.dart';

class ProfileState extends Equatable {
  final Status fetchUserStatus, chooseVendorRole;
  final String callback;
  final UserModel user;
  final VendorRole vendorRole;

  const ProfileState({
    this.callback = '',
    this.user = UserModel.non,
    this.vendorRole = VendorRole.non,
    this.fetchUserStatus = Status.initial,
    this.chooseVendorRole = Status.initial,
  });

  ProfileState copyWith({
    String? callback,
    UserModel? user,
    VendorRole? vendorRole,
    Status? fetchUserStatus,
    Status? chooseVendorRole,
  }) => ProfileState(
    callback: callback ?? this.callback,
    user: user ?? this.user,
    vendorRole: vendorRole ?? this.vendorRole,
    fetchUserStatus: fetchUserStatus ?? this.fetchUserStatus,
    chooseVendorRole: chooseVendorRole ?? this.chooseVendorRole,
  );

  @override
  List<Object> get props => [callback, user, fetchUserStatus, chooseVendorRole, vendorRole];
}
