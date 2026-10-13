part of 'biometric_cubit.dart';

enum Status { initial, loading, success, error }

class BiometricState extends Equatable {
  final Status checkBiometricHardwareStatus;
  final bool hasBiometricHardware;
  final String? checkBiometricHardwareErrorMessage;
  final Status checkAvailableBiometricsStatus;
  final List<BiometricType> availableBiometrics;
  final String? checkAvailableBiometricsErrorMessage;
  final bool isBiometricActive;
  final Status toggleBiometricStatus;
  final String? toggleBiometricErrorMessage;

  const new({
    this.checkBiometricHardwareStatus = .initial,
    this.hasBiometricHardware = false,
    this.checkBiometricHardwareErrorMessage,
    this.checkAvailableBiometricsStatus = .initial,
    this.availableBiometrics = const [],
    this.checkAvailableBiometricsErrorMessage,
    this.isBiometricActive = false,
    this.toggleBiometricStatus = .initial,
    this.toggleBiometricErrorMessage,
  });

  BiometricState copyWith({
    Status? checkBiometricHardwareStatus,
    bool? hasBiometricHardware,
    String? checkBiometricHardwareErrorMessage,
    Status? checkAvailableBiometricsStatus,
    List<BiometricType>? availableBiometrics,
    String? checkAvailableBiometricsErrorMessage,
    bool? isBiometricActive,
    Status? toggleBiometricStatus,
    String? toggleBiometricErrorMessage,
  }) {
    return BiometricState(
      checkBiometricHardwareStatus:
          checkBiometricHardwareStatus ?? this.checkBiometricHardwareStatus,
      hasBiometricHardware: hasBiometricHardware ?? this.hasBiometricHardware,
      checkBiometricHardwareErrorMessage: checkBiometricHardwareErrorMessage,
      checkAvailableBiometricsStatus:
          checkAvailableBiometricsStatus ?? this.checkAvailableBiometricsStatus,
      availableBiometrics: availableBiometrics ?? this.availableBiometrics,
      checkAvailableBiometricsErrorMessage:
          checkAvailableBiometricsErrorMessage,
      isBiometricActive: isBiometricActive ?? this.isBiometricActive,
      toggleBiometricStatus:
          toggleBiometricStatus ?? this.toggleBiometricStatus,
      toggleBiometricErrorMessage: toggleBiometricErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    checkBiometricHardwareStatus,
    hasBiometricHardware,
    checkBiometricHardwareErrorMessage,
    checkAvailableBiometricsStatus,
    availableBiometrics,
    checkAvailableBiometricsErrorMessage,
    isBiometricActive,
    toggleBiometricStatus,
    toggleBiometricErrorMessage,
  ];
}
