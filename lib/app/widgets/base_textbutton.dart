import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseTextButton extends StatelessWidget {
  const BaseTextButton({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.decoration,
    this.onPressed,
  });

  final String text;
  final double? size;
  final Color? color;
  final TextDecoration? decoration;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      alignment: Alignment.center,
      minSize: 23,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size ?? 12.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          decoration: decoration,
          color: color,
        ),
      ),
    );
  }
}
