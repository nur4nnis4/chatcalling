import 'package:flutter/material.dart';

class RadiatingActionButton extends StatelessWidget {
  final Color? color;
  final int shadowAlpha;
  final int splashAlpha;
  final bool mini;
  final Icon icon;

  const RadiatingActionButton(
      {this.color,
      required this.icon,
      this.mini = true,
      this.shadowAlpha = 100,
      this.splashAlpha = 8})
      : super();

  @override
  Widget build(BuildContext context) {
    final _color =
        color != null ? color! : Theme.of(context).colorScheme.secondary;
    return FloatingActionButton(
        mini: mini,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: _color.withAlpha(shadowAlpha),
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
        splashColor: _color.withAlpha(splashAlpha),
        onPressed: () {});
  }
}