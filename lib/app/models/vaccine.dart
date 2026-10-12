import 'package:equatable/equatable.dart';

class Vaccine extends Equatable {
  final String id;
  final String label;

  const new({required this.id, required this.label});

  @override
  List<Object> get props => [id, label];
}
