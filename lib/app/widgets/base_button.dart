import 'package:flutter/material.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';

class BaseButton extends StatelessWidget {
  const new({
    required this.label,
    this.labelSize = 14,
    this.height = 38,
    this.width,
    this.onPressed,
    this.bgColor = AppColors.orangeColor,
    this.fgColor,
    super.key,
  });

  final String label;
  final double labelSize;
  final double height;
  final double? width;
  final void Function()? onPressed;
  final Color bgColor;
  final Color? fgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(borderRadius: .circular(8)),
          padding: const .symmetric(horizontal: 10),
          minimumSize: .zero,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            fontWeight: .w500,
            color: fgColor,
          ),
        ),
      ),
    );
  }
}

class BaseOutlineButton extends StatelessWidget {
  const new({
    required this.label,
    this.labelSize = 14,
    this.height = 38,
    this.width,
    this.onPressed,
    this.borderColor = AppColors.orangeColor,
    this.fgColor = AppColors.orangeColor,
    super.key,
  });

  final String label;
  final double labelSize;
  final double height;
  final double? width;
  final void Function()? onPressed;
  final Color borderColor;
  final Color fgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(fgColor),
          iconColor: WidgetStatePropertyAll(fgColor),
          overlayColor: WidgetStatePropertyAll(fgColor.withValues(alpha: 0.1)),
          side: WidgetStatePropertyAll(
            BorderSide(width: 1, color: borderColor),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: .circular(8)),
          ),
          alignment: .center,
          padding: const WidgetStatePropertyAll(.symmetric(horizontal: 10)),
          minimumSize: const WidgetStatePropertyAll(.zero),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            fontWeight: .w500,
            color: fgColor,
          ),
        ),
      ),
    );
  }
}

class BaseButtonIcon extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    this.iconSize = 18,
    this.labelSize = 14,
    this.height = 38,
    this.width,
    this.bgColor = AppColors.orangeColor,
    this.fgColor,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final String label;
  final double? iconSize;
  final double labelSize;
  final double height;
  final double? width;
  final Color bgColor;
  final Color? fgColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton.icon(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(bgColor),
          foregroundColor: WidgetStatePropertyAll(fgColor),
          iconColor: WidgetStatePropertyAll(fgColor),
          padding: const WidgetStatePropertyAll(.symmetric(horizontal: 10)),
          overlayColor: WidgetStatePropertyAll(fgColor?.withValues(alpha: 0.1)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: .circular(8)),
          ),
          minimumSize: const WidgetStatePropertyAll(.zero),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        label: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            fontWeight: .w500,
            color: fgColor,
          ),
        ),
      ),
    );
  }
}

class BaseOutlineButtonIcon extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    this.iconSize = 18,
    this.labelSize = 14,
    this.height = 38,
    this.width,
    this.borderColor = AppColors.orangeColor,
    this.fgColor = AppColors.orangeColor,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final String label;
  final double? iconSize;
  final double labelSize;
  final double height;
  final double? width;
  final Color borderColor;
  final Color fgColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton.icon(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(fgColor),
          iconColor: WidgetStatePropertyAll(fgColor),
          overlayColor: WidgetStatePropertyAll(fgColor.withValues(alpha: 0.1)),
          side: WidgetStatePropertyAll(
            BorderSide(width: 1, color: borderColor),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: .circular(8)),
          ),
          alignment: .center,
          padding: const WidgetStatePropertyAll(.symmetric(horizontal: 10)),
          minimumSize: const WidgetStatePropertyAll(.zero),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        label: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            fontWeight: .w500,
            color: fgColor,
          ),
        ),
      ),
    );
  }
}
