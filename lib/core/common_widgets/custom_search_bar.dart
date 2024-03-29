import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final bool? enabled;
  final Function(String)? onChanged;
  final Function()? onTap;
  const CustomSearchBar(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.focusNode,
      this.onTap,
      this.autofocus,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return TextField(
              maxLines: 1,
              autofocus: autofocus ?? false,
              enabled: enabled ?? true,
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged ?? (value) {},
              onTap: onTap ?? () {},
              style: TextStyle(fontSize: 14),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                hintText: "${L10n.of(context).search}...",
                hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                border: InputBorder.none,
                suffixIconConstraints:
                    BoxConstraints(minHeight: 43, maxWidth: 43),
                suffixIcon: controller.text.isEmpty
                    ? Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 15,
                      )
                    : GestureDetector(
                        onTap: () => controller.clear(),
                        child: Icon(
                          Icons.clear,
                          size: 17,
                        ),
                      ),
              ),
            );
          }),
    );
  }
}
