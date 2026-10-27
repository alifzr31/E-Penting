import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/views/activation/widgets/activation_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class ActivationView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.deviceHeight,
          width: context.deviceWidth,
          child: Stack(
            children: [
              Positioned(
                bottom: -40,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: .2,
                  child: SvgPicture.asset(
                    '${AppStrings.assetsImages}/bottom_statusgizi.svg',
                    fit: BoxFit.cover,
                    width: context.deviceWidth,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const .all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: .centerLeft,
                        child: CupertinoButton(
                          minimumSize: .zero,
                          padding: const .all(2),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Material(
                            elevation: 1,
                            color: Colors.white,
                            clipBehavior: .antiAlias,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: .all(4),
                              child: Icon(
                                RemixIcon.arrowLeftLine,
                                size: 22,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: .infinity,
                        child: Material(
                          elevation: 1,
                          color: Colors.white,
                          clipBehavior: .antiAlias,
                          borderRadius: .circular(10),
                          child: Padding(
                            padding: const .all(16),
                            child: Column(
                              children: [
                                Align(
                                  alignment: .centerLeft,
                                  child: Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      const Text(
                                        'Aktivasi Akun',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: .w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Silahkan aktivasi akun anda dengan memasukkan NIK anda (Ayah atau Ibu) pada kolom dibawah ini.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const ActivationForm(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
