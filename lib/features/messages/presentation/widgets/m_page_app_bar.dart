import 'package:chatcalling/core/widgets/custom_icon_button.dart';
import 'package:chatcalling/core/controllers/visibility_controller.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessagePageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MessagePageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MessagePageAppBar> createState() => _MessagePageAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(70);
}

class _MessagePageAppBarState extends State<MessagePageAppBar> {
  final VisibilityController _visibilityController = VisibilityController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _visibilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AnimatedBuilder(
          animation: _visibilityController,
          builder: (_, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: _visibilityController.visible,
                  child: Expanded(
                    child: Row(
                      children: [
                        SolidIconButton(
                          onTap: () => _visibilityController.toggle(),
                          icon: FontAwesomeIcons.magnifyingGlass,
                          iconSize: 12,
                          color: Theme.of(context).colorScheme.primaryContainer,
                          iconColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                            child: Center(
                              child: Text(L10n.of(context).message,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !_visibilityController.visible,
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 17),
                      child: Container(
                        padding: EdgeInsets.only(right: 17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: TextFormField(
                          maxLines: 1,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            isDense: true,
                            filled: false,
                            hintText: "${L10n.of(context).search}...",
                            prefixIcon: InkWell(
                                onTap: () => _visibilityController.toggle(),
                                hoverColor: Colors.transparent,
                                child: Icon(Icons.arrow_back)),
                            prefixIconConstraints:
                                BoxConstraints(minHeight: 30, minWidth: 35),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  maxRadius: 17,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  // TODO : fix Network Image url
                  // foregroundImage: NetworkImage(
                  //   '',
                  // ),
                ),
              ],
            );
          }),
    );
  }
}
