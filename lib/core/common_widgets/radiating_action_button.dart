import 'package:flutter/material.dart';

class RadiatingActionButton extends StatelessWidget {
  final Icon icon;
  final Function() onPressed;
  final Color? color;
  final bool? mini;
  final int? shadowAlpha;
  final String? heroTag;

  const RadiatingActionButton(
      {required this.icon,
      required this.onPressed,
      this.color,
      this.mini,
      this.shadowAlpha,
      this.heroTag})
      : super();

  @override
  Widget build(BuildContext context) {
    final _color = color ?? Theme.of(context).colorScheme.secondary;
    return FloatingActionButton(
        heroTag: heroTag,
        mini: mini ?? true,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: _color.withAlpha(shadowAlpha ?? 100),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset.zero,
              ),
            ],
          ),
          child: icon,
        ),
        backgroundColor: _color,
        elevation: 2,
        onPressed: onPressed);
  }
}
