part of 'auth_cubit.dart';

enum LoginStatus { initial, loading, success, error }

enum ProfileStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final LoginStatus loginStatus;
  final Response? loginResponse;
  final dynamic loginError;
  final ProfileStatus profileStatus;
  final Profile? profile;
  final dynamic profileError;

  const AuthState({
    this.loginStatus = LoginStatus.initial,
    this.loginResponse,
    this.loginError,
    this.profileStatus = ProfileStatus.initial,
    this.profile,
    this.profileError,
  });

  AuthState copyWith({
    LoginStatus? loginStatus,
    Response? loginResponse,
    dynamic loginError,
    ProfileStatus? profileStatus,
    Profile? profile,
    dynamic profileError,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      loginResponse: loginResponse,
      loginError: loginError ?? this.loginError,
      profileStatus: profileStatus ?? this.profileStatus,
      profile: profile,
      profileError: profileError ?? this.profileError,
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
  ];
}
