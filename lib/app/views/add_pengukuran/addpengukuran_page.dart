import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/views/add_pengukuran/widgets/addpengukuran_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPengukuranPage extends StatelessWidget {
  const AddPengukuranPage({super.key});

  static const String routeName = '/addPengukuran';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<PengukuranCubit>().resetAddFormState();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            'Tambah Pengukuran',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
        body: const AddPengukuranForm(),
      ),
    );
  }
}
