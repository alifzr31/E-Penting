import 'package:equatable/equatable.dart';

class Vaccine extends Equatable {
  final String? id;
  final String? name;

  const Vaccine({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
