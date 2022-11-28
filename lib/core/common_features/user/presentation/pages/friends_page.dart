import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/profile_page.dart';
import 'package:chatcalling/features/messages/presentation/pages/message_room_page.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsPage extends StatefulWidget {
  final String? title;
  FriendsPage({Key? key, this.title}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildAppBar(widget.title ?? 'Friends'),
        Expanded(
          child: BlocBuilder<FriendListBloc, FriendListState>(
              builder: (context, state) {
            if (state is FriendListLoaded) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: TextFormField(
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                        controller: _searchController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: false,
                          hintText: "${L10n.of(context).search}...",
                          prefixIconConstraints:
                              BoxConstraints(minHeight: 30, minWidth: 35),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.friendList.length,
                        itemBuilder: (context, i) => FriendListViewTile(
                              friend: state.friendList[i],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => widget.title ==
                                                'Send Message'
                                            ? MessageRoomPage(
                                                friendId:
                                                    state.friendList[i].userId,
                                                friendUser: state.friendList[i],
                                              )
                                            : ProfilePage(
                                                user: state.friendList[i])));
                              },
                            )),
                  ),
                ],
              );
            } else if (state is FriendListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FriendListError) {
              return Center(
                child: Text("OOPS! Something went wrong."),
              );
            } else {
              return Container();
            }
          }),
        )
      ],
    ));
  }

  Container _buildAppBar(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
      ),
      child: SafeArea(
        child: Container(
          height: kToolbarHeight,
          width: double.infinity,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              )),
        ),
      ),
    );
  }
}

class FriendListViewTile extends StatelessWidget {
  final User friend;
  final Function()? onTap;

  const FriendListViewTile({Key? key, required this.friend, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Card(
          elevation: 0.6,
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: ListTile(
            dense: true,
            horizontalTitleGap: 10,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundImage: NetworkImage(friend.profilePhotoUrl)),
            title: Text(
              friend.displayName,
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              friend.about,
              maxLines: 1,
              style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ),
    );
  }
}
