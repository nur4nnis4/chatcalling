import 'package:chatcalling/core/common_features/user/presentation/bloc/personal_information_bloc/personal_information_bloc.dart';

import '../../domain/entities/personal_information.dart';
import '../bloc/user_bloc/user_bloc.dart';
import '../widgets/profile_header.dart';
import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/injector.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAccountPage extends StatelessWidget {
  UserAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userData) {
            return BlocBuilder<PersonalInformationBloc,
                PersonalInformationState>(
              builder: (context, userPI) {
                if (userData is UserLoaded &&
                    userPI is PersonalInformationLoaded) {
                  return Column(
                    children: [
                      ProfileHeader(user: userData.userData),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    iconSize: 20,
                                    splashRadius: 22,
                                    padding: EdgeInsets.all(0),
                                    constraints: BoxConstraints(),
                                    icon: Icon(
                                      FontAwesomeIcons.solidPenToSquare,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            UserTile(
                              title: Text('About'),
                              subtitle: userData.userData.about,
                            ),
                            UserTile(
                              title: Text('Gender'),
                              subtitle: userPI.personalInformation.gender,
                            ),
                            UserTile(
                              title: Text('DOB'),
                              subtitle: sLocator.get<TimeFormat>().yMMMMd(
                                  userPI.personalInformation.dateOfBirth,
                                  L10n.getLocalLanguageCode(context)),
                            ),
                            UserTile(
                              title: Text('Phone'),
                              subtitle: userPI.personalInformation.phoneNumber,
                            ),
                            UserTile(
                              title: Text('Email'),
                              subtitle: userPI.personalInformation.email,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              child: Text(
                                'Other',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            UserTile(
                              title: Icon(Icons.exit_to_app_rounded, size: 18),
                              subtitle: 'Sign out',
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                      child: Container(child: CircularProgressIndicator()));
                }
              },
            );
          },
        ),
      ),
    );
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
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Card(
        elevation: 0.4,
        color: Theme.of(context).colorScheme.background.withAlpha(248),
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
