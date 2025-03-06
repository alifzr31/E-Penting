import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.label,
    this.labelSize,
    this.onPressed,
    this.bgColor,
    this.fgColor,
  });

  final String label;
  final double? labelSize;
  final void Function()? onPressed;
  final Color? bgColor;
  final Color? fgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: labelSize ?? 12.sp,
          fontWeight: FontWeight.w500,
          color: fgColor,
        ),
      ),
    );
  }
}

class BaseOutlineButton extends StatelessWidget {
  const BaseOutlineButton({
    super.key,
    required this.label,
    this.onPressed,
    this.borderColor,
    this.fgColor,
  });

  final String label;
  final void Function()? onPressed;
  final Color? borderColor;
  final Color? fgColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: fgColor,
        side: BorderSide(width: 1.3, color: borderColor ?? Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: fgColor,
        ),
      ),
    );
  }
}

class BaseButtonIcon extends StatelessWidget {
  const BaseButtonIcon({
    super.key,
    this.bgColor,
    this.fgColor,
    this.onPressed,
    this.labelSize,
    this.iconSize,
    required this.icon,
    required this.label,
  });

  final Color? bgColor;
  final Color? fgColor;
  final void Function()? onPressed;
  final double? labelSize;
  final double? iconSize;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor),
        foregroundColor: WidgetStatePropertyAll(fgColor),
        iconColor: WidgetStatePropertyAll(fgColor),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10),
        ),
        overlayColor: WidgetStatePropertyAll(fgColor?.withValues(alpha: 0.1)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: iconSize ?? 16.sp),
      label: Text(
        label,
        style: TextStyle(
          fontSize: labelSize ?? 12.sp,
          fontWeight: FontWeight.w500,
          color: fgColor,
        ),
      ),
    );
  }
}

class BaseOutlineButtonIcon extends StatelessWidget {
  const BaseOutlineButtonIcon({
    super.key,
    this.fgColor,
    this.borderColor,
    this.labelSize,
    this.iconSize,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  final Color? fgColor;
  final Color? borderColor;
  final double? iconSize;
  final double? labelSize;
  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(fgColor),
        iconColor: WidgetStatePropertyAll(fgColor),
        overlayColor: WidgetStatePropertyAll(fgColor?.withValues(alpha: 0.1)),
        side: WidgetStatePropertyAll(
          BorderSide(width: 1.3, color: borderColor ?? Colors.black),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: iconSize ?? 16.sp),
      label: Text(
        label,
        style: TextStyle(
          fontSize: labelSize ?? 12.sp,
          fontWeight: FontWeight.w500,
          color: fgColor,
        ),
      ),
    );
  }
}
