import 'package:flutter/material.dart';

class OutlinedIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  const OutlinedIconButton({required this.icon, this.onTap}) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Icon(
          icon,
          size: 14,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            border: Border.all(
                color: Theme.of(context).colorScheme.secondaryContainer),
            borderRadius: BorderRadius.circular(9)),
      ),
    );
  }
}

class SolidIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final double? iconSize;
  const SolidIconButton({required this.icon, this.onTap, this.iconSize = 16})
      : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          child: Icon(
            icon,
            size: iconSize,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
