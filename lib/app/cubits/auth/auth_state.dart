part of 'auth_cubit.dart';

enum LoginStatus { initial, loading, success, error }

enum ProfileStatus { initial, loading, success, error }

enum LogoutStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final LoginStatus loginStatus;
  final Response? loginResponse;
  final dynamic loginError;
  final ProfileStatus profileStatus;
  final Profile? profile;
  final dynamic profileError;
  final LogoutStatus logoutStatus;
  final Response? logoutResponse;
  final dynamic logoutError;

  const AuthState({
    this.loginStatus = LoginStatus.initial,
    this.loginResponse,
    this.loginError,
    this.profileStatus = ProfileStatus.initial,
    this.profile,
    this.profileError,
    this.logoutStatus = LogoutStatus.initial,
    this.logoutResponse,
    this.logoutError,
  });

  AuthState copyWith({
    LoginStatus? loginStatus,
    Response? loginResponse,
    dynamic loginError,
    ProfileStatus? profileStatus,
    Profile? profile,
    dynamic profileError,
    LogoutStatus? logoutStatus,
    Response? logoutResponse,
    dynamic logoutError,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      loginResponse: loginResponse,
      loginError: loginError ?? this.loginError,
      profileStatus: profileStatus ?? this.profileStatus,
      profile: profile,
      profileError: profileError ?? this.profileError,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      logoutResponse: logoutResponse,
      logoutError: logoutError ?? this.logoutError,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    profile,
    loginError,
    profileStatus,
    profile,
    profileError,
    logoutStatus,
    logoutResponse,
    logoutError,
  ];
}
