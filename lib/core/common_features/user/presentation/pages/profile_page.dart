import 'package:chatcalling/core/common_features/user/presentation/bloc/other_user_bloc/other_user_bloc.dart';
import 'package:chatcalling/features/messages/presentation/pages/message_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common_widgets/custom_icon_button.dart';
import '../../domain/entities/user.dart';
import '../widgets/profile_header.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  ProfilePage({required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<OtherUserBloc>(context)
        .add(GetOtherUserEvent(userId: widget.user.userId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OtherUserBloc, OtherUserState>(
        builder: (context, state) {
          if (state is OtherUserLoaded) {
            user = state.userData;
          } else {
            user = widget.user;
          }
          return Column(
            children: [
              Stack(
                children: [
                  ProfileHeader(user: user),
                  SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: SizedBox.square(
                            dimension: 40,
                            child: SolidIconButton(
                              onTap: () => Navigator.pop(context),
                              icon: FontAwesomeIcons.angleLeft,
                              color: Colors.transparent,
                              iconColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ))),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Offstage(
                      offstage: user.about.isEmpty,
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        margin: EdgeInsets.all(0),
                        elevation: 0.6,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 17),
                            child: Text(
                              "\"${user.about}\"",
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _button(
                        foregroundColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withAlpha(200),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessageRoomPage(
                                      friendId: user.userId,
                                      friendUser: user,
                                    ))),
                        child: Text('Send Message')),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  OutlinedButton _button(
      {Color? foregroundColor, Widget? child, Function()? onPressed}) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(
            width: 2,
            color: foregroundColor ?? Theme.of(context).colorScheme.primary)),
        foregroundColor: MaterialStateProperty.all(
            foregroundColor ?? Theme.of(context).colorScheme.primary),
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 0)),
      ),
      onPressed: onPressed ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: child ?? Text(''),
      ),
    );
  }
}
