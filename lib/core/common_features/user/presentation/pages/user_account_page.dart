import 'package:chatcalling/core/common_features/user/presentation/bloc/personal_information_bloc/personal_information_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/update_user_page.dart';

import '../bloc/user_bloc/user_bloc.dart';
import '../widgets/profile_header.dart';
import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/injector.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAccountPage extends StatefulWidget {
  UserAccountPage({Key? key}) : super(key: key);

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignOutBloc, SignOutState>(
        listener: (_, state) {},
        child: SingleChildScrollView(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return BlocBuilder<PersonalInformationBloc,
                  PersonalInformationState>(
                builder: (context, personalInformationState) {
                  if (userState is UserLoaded &&
                      personalInformationState is PersonalInformationLoaded) {
                    return Column(
                      children: [
                        ProfileHeader(user: userState.userData),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 17, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateUserPage(
                                                  user: userState.userData,
                                                  personalInformation:
                                                      personalInformationState
                                                          .personalInformation),
                                            )).then((_) {
                                          // To refresh page after updating user data
                                          setState(() {});
                                        });
                                      },
                                      iconSize: 20,
                                      splashRadius: 22,
                                      padding: EdgeInsets.all(0),
                                      constraints: BoxConstraints(),
                                      icon: Icon(
                                        FontAwesomeIcons.solidPenToSquare,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              UserTile(
                                title: Text('About'),
                                subtitle: userState.userData.about,
                              ),
                              UserTile(
                                title: Text('Gender'),
                                subtitle: personalInformationState
                                    .personalInformation.gender,
                              ),
                              UserTile(
                                title: Text('DOB'),
                                subtitle: personalInformationState
                                            .personalInformation.dateOfBirth !=
                                        null
                                    ? sLocator.get<TimeFormat>().yMMMMd(
                                        personalInformationState
                                            .personalInformation.dateOfBirth!,
                                        L10n.getLocalLanguageCode(context))
                                    : '',
                              ),
                              UserTile(
                                title: Text('Phone'),
                                subtitle: personalInformationState
                                    .personalInformation.phoneNumber,
                              ),
                              UserTile(
                                title: Text('Email'),
                                subtitle: personalInformationState
                                    .personalInformation.email,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 14),
                                child: Text(
                                  'Other',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _showSignOutDialog(context),
                                child: UserTile(
                                  title:
                                      Icon(Icons.exit_to_app_rounded, size: 18),
                                  subtitle: 'Sign out',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                        alignment: Alignment.center,
                        height:
                            MediaQuery.of(context).size.height - kToolbarHeight,
                        child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showSignOutDialog(context) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              content: Text('Do you want to sign out?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'.toUpperCase())),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<SignOutBloc>(context).add(SignOutEvent());
                      Navigator.pop(context);
                    },
                    child: Text('Sign Out'.toUpperCase())),
              ],
            ));
  }
}

class UserTile extends StatelessWidget {
  final Widget title;
  final String? subtitle;
  const UserTile({Key? key, required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        elevation: 0.4,
        color: Theme.of(context).colorScheme.primaryContainer,
        margin: EdgeInsets.all(0),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 55),
                  child: title is Text
                      ? Text(
                          title
                              .toString()
                              .split("\"")[1], //Get the data of Text widget
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Align(alignment: Alignment.centerLeft, child: title),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    subtitle ?? '',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
