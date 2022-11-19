import 'custom_icon_button.dart';
import '../../l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final double height;
  final Widget? appBarChild;

  CustomAppBar({this.height = 60, this.appBarChild}) : super();
  @override
  Widget build(BuildContext context) {
    final Widget _child = appBarChild != null ? appBarChild! : _AppBarChild();
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                stops: [
                  0.0,
                  0.7
                ],
                tileMode: TileMode.clamp,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight),
          ),
          child: _child),
    );
  }

  @override
  Widget get child => this.appBarChild!;

  @override
  Size get preferredSize => Size.fromHeight(this.height);
}

class _AppBarChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SolidIconButton(
          icon: FontAwesomeIcons.magnifyingGlass,
          iconSize: 12,
          color: Colors.white.withAlpha(40),
          iconColor: Theme.of(context).colorScheme.onPrimary,
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Container(
            child: Center(
              child: Text(L10n.of(context).message,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
          ),
        )),
        CircleAvatar(
          maxRadius: 17,
          backgroundColor: Colors.white.withAlpha(40),
          // TODO : fix Network Image url
          // foregroundImage: NetworkImage(
          //   '',
          // ),
        ),
      ],
    );
  }
}
