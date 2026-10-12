part of 'auth_cubit.dart';

enum Status { initial, loading, success, error }

class AuthState extends Equatable {
  final Status profileStatus;
  final Profile? profile;
  final List<Anak> children;
  final String? profileErrorMessage;
  final Status logoutStatus;
  final Map<String, dynamic>? logoutResponseData;
  final String? logoutErrorMessage;

  const new({
    this.profileStatus = .initial,
    this.profile,
    this.children = const [],
    this.profileErrorMessage,
    this.logoutStatus = .initial,
    this.logoutResponseData,
    this.logoutErrorMessage,
  });

  AuthState copyWith({
    Status? profileStatus,
    Profile? profile,
    List<Anak>? children,
    String? profileErrorMessage,
    Status? logoutStatus,
    Map<String, dynamic>? logoutResponseData,
    String? logoutErrorMessage,
  }) {
    return AuthState(
      profileStatus: profileStatus ?? this.profileStatus,
      profile: profile,
      children: children ?? this.children,
      profileErrorMessage: profileErrorMessage,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      logoutResponseData: logoutResponseData,
      logoutErrorMessage: logoutErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    profileStatus,
    profile,
    children,
    profileErrorMessage,
    logoutStatus,
    logoutResponseData,
    logoutErrorMessage,
  ];
}
