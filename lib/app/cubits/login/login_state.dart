part of 'login_cubit.dart';

enum Status { initial, loading, success, error }

class LoginState extends Equatable {
  final Status status;
  final Map<String, dynamic>? responseData;
  final String? errorMessage;

  const new({this.status = .initial, this.responseData, this.errorMessage});

  LoginState copyWith({
    Status? status,
    Map<String, dynamic>? responseData,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      responseData: responseData,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, responseData, errorMessage];
}
