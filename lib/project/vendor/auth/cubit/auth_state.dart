part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String msg;
  final Status signupStatus;
  final Status signinStatus;
  final Status signoutStatus;
  final UserModel user;

  const AuthState({
    this.msg = '',
    this.signoutStatus = Status.initial,
    this.signupStatus = Status.initial,
    this.signinStatus = Status.initial,
    this.user = UserModel.non,
  });
  AuthState copyWith({String? msg, 
  Status? signoutStatus,
  Status? signupStatus, 
  Status? signinStatus, 
  UserModel? user}) => AuthState(
    msg: msg ?? this.msg,
    signupStatus: signupStatus ?? this.signupStatus,
    signinStatus: signinStatus ?? this.signinStatus,
    user: user ?? this.user,
    signoutStatus: signoutStatus ?? this.signoutStatus,
  );

  @override
  List<Object?> get props => [msg, signupStatus, signinStatus, signoutStatus, user];
}
