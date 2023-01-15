import 'package:chatcalling/core/cubit/current_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'core/common_features/user/presentation/bloc/friend_list_bloc/friend_list_bloc.dart';
import 'core/common_features/user/presentation/bloc/personal_information_bloc/personal_information_bloc.dart';
import 'core/common_features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'core/common_features/user/presentation/pages/friends_page.dart';
import 'core/common_features/user/presentation/pages/user_account_page.dart';
import 'core/common_widgets/radiating_action_button.dart';
import 'features/messages/presentation/bloc/conversation_list_bloc/conversation_list_bloc.dart';
import 'features/messages/presentation/pages/messages_page.dart';
import 'l10n/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<UserBloc>(context).add(GetUserEvent());
      BlocProvider.of<PersonalInformationBloc>(context)
          .add(PersonalInformationEvent());
      BlocProvider.of<FriendListBloc>(context).add(GetFriendListEvent());
      BlocProvider.of<ConversationListBloc>(context)
          .add(ConversationListEvent());
    });
  }

  final List<Widget> _pages = [
    MessagesPage(),
    MessagesPage(), //Todo: Change to CallPage
    FriendsPage(title: 'Send Message'),
    FriendsPage(),
    UserAccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPageCubit, int>(
      builder: (context, currentPageIndex) {
        return Scaffold(
          body: _pages[currentPageIndex],
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: currentPageIndex,
                type: BottomNavigationBarType.fixed,
                iconSize: 15,
                selectedFontSize: 9,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                onTap: (selected) {
                  context.read<CurrentPageCubit>().goToPage(selected);
                },
                items: _bottomNavigationBarItems(
                    currentPageIndex: currentPageIndex)),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems(
      {required int currentPageIndex}) {
    return [
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
          ),
          label: L10n.of(context).newMessage,
          tooltip: L10n.of(context).newMessage),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.userGroup),
        label: L10n.of(context).contacts,
        tooltip: L10n.of(context).contacts,
      ),
      BottomNavigationBarItem(
        icon: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return CircleAvatar(
              maxRadius: currentPageIndex == _pages.length - 1 ? 12 : 10,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: CircleAvatar(
                maxRadius: 10,
                backgroundColor: Theme.of(context).colorScheme.onTertiary,
                foregroundImage: state is UserLoaded
                    ? NetworkImage(state.userData.profilePhotoUrl)
                    : null,
              ),
            );
          },
        ),
        label: L10n.of(context).settings,
        tooltip: L10n.of(context).settings,
      ),
    ];
  }
}
