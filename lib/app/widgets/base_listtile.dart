import 'package:flutter/material.dart';

class BaseListTile extends StatelessWidget {
  const new({
    required this.title,
    this.titleSize = 14,
    this.titleColor = Colors.black,
    this.subtitle,
    this.subtitleSize = 12,
    this.subtitleColor,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String title;
  final double titleSize;
  final Color titleColor;
  final String? subtitle;
  final double subtitleSize;
  final Color? subtitleColor;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const .symmetric(horizontal: 16),
      horizontalTitleGap: 10,
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          fontSize: titleSize,
          fontWeight: .w500,
          color: titleColor,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle ?? '',
              style: TextStyle(
                fontSize: subtitleSize,
                fontWeight: .w400,
                color: subtitleColor,
              ),
            ),
      trailing: trailing,
    );
  }
}
