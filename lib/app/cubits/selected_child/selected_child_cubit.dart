import 'package:e_penting/app/models/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedChildCubit extends Cubit<Anak?> {
  new() : super(null);

  void selectChild(Anak child) {
    emit(child);
  }
}
