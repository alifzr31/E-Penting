import 'package:flutter/cupertino.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';

class BaseIconButton extends StatelessWidget {
  const new({
    super.key,
    required this.icon,
    this.size,
    this.color = AppColors.blueColor,
    this.onPressed,
  });

  final IconData icon;
  final double? size;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      alignment: .center,
      minimumSize: .zero,
      padding: const .all(2),
      onPressed: onPressed,
      child: Icon(icon, size: size, color: color),
    );
  }
}
