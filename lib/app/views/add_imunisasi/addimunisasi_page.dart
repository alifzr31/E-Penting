import 'package:epenting/app/cubits/imunisasi/imunisasi_cubit.dart';
import 'package:epenting/app/views/add_imunisasi/widgets/addimunisasi_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddImunisasiPage extends StatelessWidget {
  const AddImunisasiPage({super.key});

  static const String routeName = '/addImunisasi';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<ImunisasiCubit>().resetAddFormState();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            'Tambah Imunisasi',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
        body: const AddImunsiasiForm(),
      ),
    );
  }
}
