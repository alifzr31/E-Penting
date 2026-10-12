import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/models/profile.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class ChildCard extends StatelessWidget {
  const new({
    required this.child,
    required this.onSelectedChild,
    this.dataLength = 0,
    this.index = 0,
    super.key,
  });

  final Anak child;
  final Function(Anak child) onSelectedChild;
  final int dataLength;
  final int index;

  @override
  Widget build(BuildContext context) {
    final selectedChild = context.watch<SelectedChildCubit>().state;

    return Card(
      elevation: 0,
      color: selectedChild == child
          ? selectedChild?.jenisKelamin == 'Laki-laki'
                ? AppColors.maleColor.withValues(alpha: 0.4)
                : AppColors.femaleColor.withValues(alpha: 0.4)
          : Colors.transparent,
      clipBehavior: .antiAlias,
      margin: .only(
        left: selectedChild == child ? 16 : 0,
        right: selectedChild == child ? 16 : 0,
        bottom: index == (dataLength - 1) ? 10 : 6,
      ),
      child: ListTile(
        onTap: selectedChild == child ? null : () => onSelectedChild(child),
        leading: Ink(
          padding: const .all(8),
          decoration: BoxDecoration(
            color: selectedChild == child
                ? Colors.white
                : child.jenisKelamin == 'Laki-laki'
                ? AppColors.maleColor.withValues(alpha: 0.2)
                : AppColors.femaleColor.withValues(alpha: 0.2),
            shape: .circle,
          ),
          child: Icon(
            child.jenisKelamin == 'Laki-laki'
                ? RemixIcon.menLine
                : RemixIcon.womenLine,
            size: 24,
            color: child.jenisKelamin == 'Laki-laki'
                ? AppColors.maleColor
                : AppColors.femaleColor,
          ),
        ),
        minTileHeight: 0,
        contentPadding: const .symmetric(vertical: 8, horizontal: 16),
        title: Text(
          child.nama ?? '',
          maxLines: 1,
          overflow: .ellipsis,
          style: TextStyle(
            fontSize: selectedChild == child ? 14 : 16,
            fontWeight: .w600,
          ),
        ),
        subtitle: Text(
          child.tanggalLahir == null ? '-' : child.tanggalLahir!.ageYearMonth(),
          maxLines: 1,
          overflow: .ellipsis,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
