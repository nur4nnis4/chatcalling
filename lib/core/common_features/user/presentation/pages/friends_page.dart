import 'package:chatcalling/core/common_features/user/presentation/bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/profile_page.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/search_user_page.dart';
import 'package:chatcalling/core/common_features/user/presentation/widgets/user_list_tile.dart';
import 'package:chatcalling/core/common_widgets/custom_search_bar.dart';
import 'package:chatcalling/features/messages/presentation/pages/message_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchUserPage(title: widget.title),
                  )),
              child: SearchBar(
                controller: _searchController,
                enabled: false,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<FriendListBloc, FriendListState>(
              builder: (context, state) {
                if (state is FriendListLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.friendList.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: LoadedUserListTile(
                        user: state.friendList[i],
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => widget.title ==
                                          'Send Message'
                                      ? MessageRoomPage(
                                          friendId: state.friendList[i].userId,
                                          friendUser: state.friendList[i],
                                        )
                                      : ProfilePage(
                                          user: state.friendList[i])));
                        },
                      ),
                    ),
                  );
                } else if (state is FriendListLoading) {
                  return Shimmer.fromColors(
                    baseColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                    highlightColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    enabled: true,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: LoadingUserListTile(),
                      ),
                    ),
                  );
                } else if (state is FriendListError) {
                  return Center(
                    child: Text("OOPS! Something went wrong."),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
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
