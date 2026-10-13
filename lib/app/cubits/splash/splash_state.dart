part of 'splash_cubit.dart';

enum Status { initial, loading, success, error }

enum SplashTarget {
  none,
  update,
  onboard,
  login,
  dashboard,
}

class SplashState extends Equatable {
  final Status status;
  final SplashTarget target;
  final bool isNeedUpdate;
  final bool isOpenedOnboard;
  final bool isLoggedIn;
  final String? errorMessage;
  final bool isBiometricCancelled;
  final bool isBiometricPromptActive;

  const new({
    this.status = .initial,
    this.target = .none,
    this.isNeedUpdate = false,
    this.isOpenedOnboard = false,
    this.isLoggedIn = false,
    this.errorMessage,
    this.isBiometricCancelled = false,
    this.isBiometricPromptActive = false,
  });

  SplashState copyWith({
    Status? status,
    SplashTarget? target,
    bool? isNeedUpdate,
    bool? isOpenedOnboard,
    bool? isLoggedIn,
    String? errorMessage,
    bool? isBiometricCancelled,
    bool? isBiometricPromptActive,
  }) {
    return SplashState(
      status: status ?? this.status,
      target: target ?? this.target,
      isNeedUpdate: isNeedUpdate ?? this.isNeedUpdate,
      isOpenedOnboard: isOpenedOnboard ?? this.isOpenedOnboard,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage ?? this.errorMessage,
      isBiometricCancelled: isBiometricCancelled ?? this.isBiometricCancelled,
      isBiometricPromptActive:
          isBiometricPromptActive ?? this.isBiometricPromptActive,
    );
  }

  @override
  List<Object?> get props => [
    status,
    target,
    isNeedUpdate,
    isOpenedOnboard,
    isLoggedIn,
    errorMessage,
    isBiometricCancelled,
    isBiometricPromptActive,
  ];
}
