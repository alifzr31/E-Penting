import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

Future<Object?> nutritionResultDialog(
  BuildContext context, {
  String? classification,
  String? weight,
  String? nutrition,
  VoidCallback? onRecheck,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Center(
          child: Padding(
            padding: const .all(26),
            child: Material(
              elevation: 1,
              color: Colors.white,
              clipBehavior: .antiAlias,
              borderRadius: .circular(10),
              child: Padding(
                padding: const .all(16),
                child: Column(
                  mainAxisSize: .min,
                  mainAxisAlignment: .center,
                  children: [
                    const Text(
                      'Status Gizi Balita Anda',
                      textAlign: .center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SvgPicture.asset(
                      '${AppStrings.assetsImages}/baby.svg',
                      width: 200,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: .infinity,
                      child: Material(
                        clipBehavior: .antiAlias,
                        color: Colors.blue.shade100,
                        borderRadius: .circular(4),
                        child: Padding(
                          padding: const .symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          child: RichText(
                            textAlign: .center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style
                                  .copyWith(
                                    fontSize: 12,
                                    color: Colors.blue.shade600,
                                  ),
                              children: [
                                const TextSpan(text: 'Tinggi Badan Balita : '),
                                TextSpan(
                                  text: classification,
                                  style: const TextStyle(fontWeight: .w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: .infinity,
                      child: Material(
                        clipBehavior: .antiAlias,
                        color: Colors.blue.shade100,
                        borderRadius: .circular(4),
                        child: Padding(
                          padding: const .symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          child: RichText(
                            textAlign: .center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style
                                  .copyWith(
                                    fontSize: 12,
                                    color: Colors.blue.shade600,
                                  ),
                              children: [
                                const TextSpan(text: 'Berat Badan Balita : '),
                                TextSpan(
                                  text: weight,
                                  style: const TextStyle(fontWeight: .w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: .infinity,
                      child: Material(
                        clipBehavior: .antiAlias,
                        color: Colors.blue.shade100,
                        borderRadius: .circular(4),
                        child: Padding(
                          padding: const .symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          child: RichText(
                            textAlign: .center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style
                                  .copyWith(
                                    fontSize: 12,
                                    color: Colors.blue.shade600,
                                  ),
                              children: [
                                const TextSpan(text: 'Gizi Balita : '),
                                TextSpan(
                                  text: nutrition,
                                  style: const TextStyle(fontWeight: .w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    BaseButtonIcon(
                      icon: RemixIcon.refreshLine,
                      label: 'Cek Ulang',
                      onPressed: onRecheck,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
