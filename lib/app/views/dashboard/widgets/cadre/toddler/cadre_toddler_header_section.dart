import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class CadreToddlerHeaderSection extends StatelessWidget {
  const new({
    required this.keyword,
    required this.keywordController,
    required this.onSearchToddler,
    required this.selectedRangeMonthAge,
    super.key,
  });

  final String? keyword;
  final TextEditingController keywordController;
  final void Function(String? value) onSearchToddler;
  final String? selectedRangeMonthAge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: .infinity,
      child: Material(
        elevation: 1,
        color: Colors.white,
        clipBehavior: .antiAlias,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const .all(16),
            child: Column(
              children: [
                const Align(
                  alignment: .centerLeft,
                  child: Text(
                    'Kelola Data\nBalita',
                    style: TextStyle(fontSize: 16, fontWeight: .w600),
                  ),
                ),
                const SizedBox(height: 10),
                BaseFormField(
                  hint: 'Cari berdasarkan nama balita',
                  controller: keywordController,
                  prefixIcon: const Icon(RemixIcon.search2Line, size: 18),
                  onChanged: onSearchToddler,
                ),
                const SizedBox(height: 10),
                BaseOutlineButtonIcon(
                  width: .infinity,
                  icon: RemixIcon.addLine,
                  label: 'Tambah Balita',
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      RouteName.createToddler,
                    );

                    if (!context.mounted || result == null) return;

                    final isSuccess = result as bool;

                    if (isSuccess) {
                      context.read<ToddlerCubit>().refetchToddlers(
                        keyword: keyword,
                        rangeMonthAge: selectedRangeMonthAge,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
