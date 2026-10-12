import 'package:flutter/cupertino.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';

class BaseTextButton extends StatelessWidget {
  const new({
    super.key,
    required this.text,
    this.color = AppColors.orangeColor,
    this.size = 12,
    this.decoration,
    this.onPressed,
  });

  final String text;
  final Color color;
  final double size;
  final TextDecoration? decoration;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      alignment: .center,
      minimumSize: .zero,
      padding: const .all(2),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontFamily: 'Poppins',
          fontWeight: .w500,
          decoration: decoration,
          color: color,
        ),
      ),
    );
  }
}
