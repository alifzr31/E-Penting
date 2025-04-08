import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/widgets/base_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrtuHomeHeader extends StatelessWidget {
  const OrtuHomeHeader({required this.ortuKey, super.key});

  final GlobalKey<ScaffoldState> ortuKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.white,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      switch (state.profileStatus) {
                        case ProfileStatus.success:
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hai,',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                state.profile?.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        default:
                          return Skeletonizer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Skeleton.keep(
                                  child: Text(
                                    'Hai,',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                Text(
                                  'xxxxxxxxxxxxxxxxxxxx',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                      }
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                BaseIconButton(
                  icon: MingCute.menu_line,
                  size: 20.sp,
                  color: AppColors.blueColor,
                  onPressed: () {
                    ortuKey.currentState?.openEndDrawer();
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
