import 'package:epenting/app/cubits/imunisasi/imunisasi_cubit.dart';
import 'package:epenting/app/views/edit_imunisasi/widgets/editimunisasi_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditImunisasiPage extends StatelessWidget {
  const EditImunisasiPage({required this.idImunisasi, super.key});

  final int idImunisasi;

  static const String routeName = '/editImunisasi';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<ImunisasiCubit>().resetEditFormState();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            'Edit Imunisasi',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
        body: EditImunsiasiForm(idImunisasi: idImunisasi),
      ),
    );
  }
}
