import 'package:chatcalling/features/messages/presentation/pages/messages_page.dart';
import 'package:chatcalling/core/widgets/radiating_action_button.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MessagesPage(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            iconSize: 15,
            selectedFontSize: 9,
            onTap: (_) {},
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            items: [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidComment),
                label: L10n.of(context).message,
                tooltip: L10n.of(context).message,
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.phone),
                label: L10n.of(context).calls,
                tooltip: L10n.of(context).calls,
              ),
              BottomNavigationBarItem(
                  icon: RadiatingActionButton(
                    icon: Icon(Icons.add_rounded),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                  ),
                  label: L10n.of(context).newMessage,
                  tooltip: L10n.of(context).newMessage),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.userGroup),
                label: L10n.of(context).contacts,
                tooltip: L10n.of(context).contacts,
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.gear),
                label: L10n.of(context).settings,
                tooltip: L10n.of(context).settings,
              ),
            ]),
      ),
    );
  }
}
