import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

enum HandleType { empty, error }

class BaseHandleState extends StatelessWidget {
  const new({
    required this.handleType,
    required this.errorMessage,
    this.lottieWidth = 120,
    this.errorMessageSize = 14,
    this.iconButtonSize = 18,
    this.labelButtonSize = 14,
    this.onRefetch,
    super.key,
  });

  final HandleType handleType;
  final String errorMessage;
  final double lottieWidth;
  final double errorMessageSize;
  final double iconButtonSize;
  final double labelButtonSize;
  final void Function()? onRefetch;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Lottie.asset(
            AppStrings.assetsLotties +
                (handleType == .empty ? '/empty.json' : '/error.json'),
            width: lottieWidth,
          ),
          const SizedBox(height: 10),
          Text(
            errorMessage,
            textAlign: .center,
            maxLines: 2,
            overflow: .ellipsis,
            style: TextStyle(fontSize: errorMessageSize, fontWeight: .w500),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            minimumSize: .zero,
            padding: const .all(2),
            onPressed: onRefetch,
            foregroundColor: onRefetch == null ? null : AppColors.blueColor,
            child: Row(
              mainAxisAlignment: .center,
              children: [
                Icon(RemixIcon.refreshLine, size: iconButtonSize),
                const SizedBox(width: 4),
                Text(
                  'Muat Ulang',
                  style: TextStyle(
                    fontSize: labelButtonSize,
                    fontWeight: .w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
