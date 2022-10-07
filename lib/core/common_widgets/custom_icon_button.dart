import 'package:flutter/material.dart';

abstract class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final double? iconSize;
  final Color? color;
  final Color? iconColor;

  const CustomIconButton(
      {Key? key,
      required this.icon,
      this.onTap,
      this.iconSize,
      this.color,
      this.iconColor})
      : super(key: key);
}

class OutlinedIconButton extends CustomIconButton {
  OutlinedIconButton(
      {required icon,
      Function()? onTap,
      double iconSize = 14,
      Color? color,
      Color? iconColor})
      : super(
            icon: icon,
            onTap: onTap,
            iconSize: iconSize,
            color: color,
            iconColor: iconColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor != null
              ? iconColor!
              : Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        decoration: BoxDecoration(
            color: color != null
                ? color!
                : Theme.of(context).colorScheme.background,
            border: Border.all(
                color: Theme.of(context).colorScheme.secondaryContainer),
            borderRadius: BorderRadius.circular(9)),
      ),
    );
  }
}

class SolidIconButton extends CustomIconButton {
  SolidIconButton(
      {required icon,
      Function()? onTap,
      double iconSize = 16,
      Color? color,
      Color? iconColor})
      : super(
            icon: icon,
            onTap: onTap,
            iconSize: iconSize,
            color: color,
            iconColor: iconColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        height: 30,
        width: 30,
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor != null
              ? iconColor!
              : Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        decoration: BoxDecoration(
            color: color != null
                ? color!
                : Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
