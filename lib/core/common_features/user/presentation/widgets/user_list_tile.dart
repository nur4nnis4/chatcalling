import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';

class LoadedUserListTile extends StatelessWidget {
  final User user;
  final Function()? onTap;

  const LoadedUserListTile({Key? key, required this.user, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.6,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: InkWell(
        onTap: onTap ?? () {},
        child: ListTile(
          dense: true,
          horizontalTitleGap: 10,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundImage: NetworkImage(user.profilePhotoUrl)),
          title: Text(
            user.displayName,
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Text(
            "@${user.username}",
            maxLines: 1,
            style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}

class LoadingUserListTile extends StatelessWidget {
  const LoadingUserListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.6,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        dense: true,
        horizontalTitleGap: 10,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        title: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 8,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        subtitle: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 6,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
