import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/views/add_balita/widgets/addbalita_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBalitaPage extends StatelessWidget {
  const AddBalitaPage({super.key});

  static const String routeName = '/addBalita';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<BalitaCubit>().resetAddFormState();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            'Tambah Balita',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
        body: const AddBalitaForm(),
      ),
    );
  }
}
