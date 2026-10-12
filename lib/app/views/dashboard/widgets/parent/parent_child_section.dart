import 'package:e_penting/app/cubits/auth/auth_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/models/profile.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/dashboard/components/parent/child_card.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class ParentChildSection extends StatefulWidget {
  const new({
    this.isActive = true,
    this.topSafeArea = true,
    this.padding = .zero,
    super.key,
  });

  final bool isActive;
  final bool topSafeArea;
  final EdgeInsets padding;

  @override
  State<ParentChildSection> createState() => _ParentChildSectionState();
}

class _ParentChildSectionState extends State<ParentChildSection> {
  final _childrenCardKey = GlobalKey<ExpansionTileCardState>();

  @override
  void didUpdateWidget(ParentChildSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isActive && oldWidget.isActive) {
      _childrenCardKey.currentState?.collapse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: widget.topSafeArea,
      bottom: false,
      child: Padding(
        padding: widget.padding,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            return BlocBuilder<SelectedChildCubit, Anak?>(
              builder: (context, selectedChild) {
                return Card(
                  elevation: 1,
                  margin: .zero,
                  clipBehavior: .antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: .circular(10)),
                  child: ExpansionTileCard(
                    key: _childrenCardKey,
                    elevation: 0,
                    initialElevation: 0,
                    finalPadding: .zero,
                    initialPadding: .zero,
                    baseColor: Colors.white,
                    expandedColor: Colors.white,
                    contentPadding: const .symmetric(horizontal: 16),
                    borderRadius: .zero,
                    leading: Ink(
                      padding: const .all(8),
                      decoration: BoxDecoration(
                        shape: .circle,
                        color: selectedChild?.jenisKelamin == 'Laki-laki'
                            ? AppColors.maleColor
                            : AppColors.femaleColor,
                      ),
                      child: Icon(
                        selectedChild?.jenisKelamin == 'Laki-laki'
                            ? RemixIcon.menLine
                            : RemixIcon.womenLine,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      selectedChild?.nama ?? '',
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: .w600,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      selectedChild?.tanggalLahir == null
                          ? '-'
                          : selectedChild!.tanggalLahir!.ageYearMonth(),
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const .only(bottom: 10, left: 16, right: 16),
                        child: Divider(height: 1, color: Colors.grey.shade300),
                      ),
                      ...List.generate(authState.children.length, (index) {
                        final child = authState.children[index];

                        return ChildCard(
                          child: child,
                          onSelectedChild: (child) {
                            context.read<SelectedChildCubit>().selectChild(
                              child,
                            );

                            _childrenCardKey.currentState?.collapse();
                          },
                        );
                      }),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
