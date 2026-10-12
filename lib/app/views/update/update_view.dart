import 'package:e_penting/app/configs/firebase/firebase_remote.dart';
import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/base_textbutton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateView extends StatefulWidget {
  const new({super.key});

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  String? _latestAppVersion;
  int? _latestBuildNumber;
  String? _updateDescription;
  bool _isMandatory = false;

  void _initUpdateAppInfo() {
    final firebaseRemote = sl<FirebaseRemote>();

    _latestAppVersion = firebaseRemote.latestVersion;
    _latestBuildNumber = firebaseRemote.latestBuildNumber;
    _updateDescription = firebaseRemote.updateDescription;
    _isMandatory = firebaseRemote.mandatoryUpdate;

    setState(() {});
  }

  Future<void> _openPlayStore() async {
    try {
      final url = Uri.parse(
        'https://play.google.com/store/apps/details?id=gov.bdg.epenting',
      );

      final canLaunch = await canLaunchUrl(url);

      if (!canLaunch) return;

      await launchUrl(url);
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _initUpdateAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .all(16),
        child: Column(
          children: [
            Expanded(
              child: SafeArea(
                bottom: false,
                child: Center(
                  child: Material(
                    elevation: 1,
                    color: Colors.white,
                    clipBehavior: .antiAlias,
                    shape: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        '${AppStrings.assetsImages}/logo2.svg',
                        width: context.widthPct(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: .infinity,
              child: Material(
                elevation: 1,
                color: Colors.white,
                clipBehavior: .antiAlias,
                borderRadius: .circular(8),
                child: Padding(
                  padding: const .all(16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      const Text(
                        'Rincian Pembaruan Aplikasi :',
                        style: TextStyle(fontSize: 14, fontWeight: .w600),
                      ),
                      Padding(
                        padding: const .symmetric(vertical: 8),
                        child: Divider(height: 1, color: Colors.grey.shade300),
                      ),
                      BlocBuilder<PackageInfoCubit, PackageInfoState>(
                        buildWhen: (previous, current) {
                          return previous.status != current.status;
                        },
                        builder: (context, state) {
                          return RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style
                                  .copyWith(fontSize: 12),
                              children: [
                                const TextSpan(text: 'Versi Sekarang : '),
                                TextSpan(
                                  text:
                                      '${state.appVersion} (${state.appBuildNumber})',
                                  style: TextStyle(
                                    fontWeight: .w500,
                                    color: Colors.red.shade600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 2),
                      Builder(
                        builder: (context) {
                          return RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style
                                  .copyWith(fontSize: 12),
                              children: [
                                const TextSpan(text: 'Versi Terbaru : '),
                                TextSpan(
                                  text:
                                      '$_latestAppVersion ($_latestBuildNumber)',
                                  style: TextStyle(
                                    fontWeight: .w500,
                                    color: Colors.green.shade600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const .symmetric(vertical: 8),
                        child: Divider(height: 1, color: Colors.grey.shade300),
                      ),
                      const Text(
                        'Deskripsi Pembaruan :',
                        style: TextStyle(fontSize: 12, fontWeight: .w500),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: .infinity,
                        padding: const .all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: .circular(6),
                        ),
                        child: Text(
                          _updateDescription ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SafeArea(
              top: false,
              bottom: _isMandatory,
              child: BaseButtonIcon(
                width: .infinity,
                icon: RemixIcon.mobileDownloadLine,
                label: 'Perbarui Sekarang',
                onPressed: () => _openPlayStore(),
              ),
            ),
            if (!_isMandatory) ...[
              const SizedBox(height: 10),
              SafeArea(
                top: false,
                bottom: !_isMandatory,
                child: BaseTextButton(
                  text: 'Nanti Saja',
                  size: 14,
                  color: AppColors.blueColor,
                  onPressed: () {},
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
