import 'package:app_version_update/data/models/app_version_result.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({required this.appVersionResult, super.key});

  final AppVersionResult appVersionResult;

  static const String routeName = '/update';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      '${AppStrings.assetsImages}/logo2.svg',
                      width: 120.w,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Perbarui Aplikasi E-Penting',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Aplikasi E-Penting versi ${appVersionResult.storeVersion} sudah tersedia di Play Store, Silahkan segera perbarui aplikasi E-Penting anda untuk melanjutkan!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: BaseButton(
                  bgColor: AppColors.blueColor,
                  fgColor: Colors.white,
                  label: 'Perbarui Sekarang',
                  onPressed: () async {
                    final url = Uri.parse(appVersionResult.storeUrl ?? '');

                    await launchUrl(url);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
