part of 'auth_cubit.dart';


class AuthState extends Equatable {
  final String msg;
  final Status signupStatus, signinStatus, signoutStatus, verifyEmailStatus, resetPasswordStatus, confirmOtpStatus;
  final UserModel user;

  const AuthState({
    this.msg = '',
    this.signupStatus = Status.initial,
    this.signinStatus = Status.initial,
    this.signoutStatus = Status.initial,
    this.verifyEmailStatus = Status.initial,
    this.resetPasswordStatus = Status.initial,
    this.confirmOtpStatus = Status.initial,
    this.user = UserModel.non,
  });
  AuthState copyWith({
    String? msg,
    Status? signupStatus,
    Status? signinStatus,
    Status? signoutStatus,
    Status? verifyEmailStatus,
    UserModel? user,
    Status? resetPasswordStatus,
    Status? confirmOtpStatus,
  }) => AuthState(
    msg: msg ?? this.msg,
    signupStatus: signupStatus ?? this.signupStatus,
    signinStatus: signinStatus ?? this.signinStatus,
    signoutStatus: signoutStatus ?? this.signoutStatus,
    verifyEmailStatus: verifyEmailStatus ?? this.verifyEmailStatus,
    resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
    confirmOtpStatus: confirmOtpStatus ?? this.confirmOtpStatus,
    user: user ?? this.user,
  );

  @override
  List<Object?> get props => [
    msg,
    signupStatus,
    signinStatus,
    signoutStatus,
    verifyEmailStatus,
    user,
    confirmOtpStatus,
    resetPasswordStatus,
  ];




   }

