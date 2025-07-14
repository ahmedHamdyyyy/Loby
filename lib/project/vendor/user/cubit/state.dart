part of 'cubit.dart';

class UserState extends Equatable {
  final String callback;
  final UserModel user;
  final Status fetchUserStatus;

  const UserState({required this.callback, required this.user, required this.fetchUserStatus});

  UserState copyWith({String? callback, UserModel? user, Status? fetchUserStatus}) {
    return UserState(
      callback: callback ?? this.callback,
      user: user ?? this.user,
      fetchUserStatus: fetchUserStatus ?? this.fetchUserStatus,
    );
  }

  @override
  List<Object> get props => [callback, user, fetchUserStatus];
}
