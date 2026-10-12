part of 'package_info_cubit.dart';

enum Status { initial, loading, success, error }

class PackageInfoState extends Equatable {
  final Status status;
  final String? appName;
  final String? appVersion;
  final int? appBuildNumber;

  const new({
    this.status = .initial,
    this.appName,
    this.appVersion,
    this.appBuildNumber,
  });

  PackageInfoState copyWith({
    Status? status,
    String? appName,
    String? appVersion,
    int? appBuildNumber,
  }) {
    return PackageInfoState(
      status: status ?? this.status,
      appName: appName,
      appVersion: appVersion,
      appBuildNumber: appBuildNumber,
    );
  }

  @override
  List<Object?> get props => [status, appName, appVersion, appBuildNumber];
}
