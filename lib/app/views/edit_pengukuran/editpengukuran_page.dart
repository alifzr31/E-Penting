import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/views/edit_pengukuran/widgets/editpengukuran_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditPengukuranPage extends StatelessWidget {
  const EditPengukuranPage({required this.idPengukuran, super.key});

  final int idPengukuran;

  static const String routeName = '/editPengukuran';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<PengukuranCubit>().resetEditFormState();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            'Edit Pengukuran',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
        body: EditPengukuranForm(idPengukuran: idPengukuran),
      ),
    );
  }
}
