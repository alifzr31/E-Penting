import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

Future<Object?> showCustomBottomSheet(
  BuildContext context, {
  bool enableDrag = true,
  required Widget child,
}) {
  return showModalBottomSheet(
    clipBehavior: .antiAlias,
    elevation: 2,
    isDismissible: false,
    isScrollControlled: true,
    enableDrag: enableDrag,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: .only(topLeft: .circular(10), topRight: .circular(10)),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: .only(bottom: context.deviceViewInsets.bottom),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxHeight = context.heightPct(6);

            return Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 8,
                      width: context.widthPct(13),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: .circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const .only(top: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxHeight),
                    child: SizedBox(width: .infinity, child: child),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
