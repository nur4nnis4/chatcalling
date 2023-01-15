import 'package:chatcalling/core/common_features/user/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/profile_page.dart';
import 'package:chatcalling/core/common_features/user/presentation/widgets/user_list_tile.dart';
import 'package:chatcalling/core/common_widgets/custom_search_bar.dart';
import 'package:chatcalling/features/messages/presentation/pages/message_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SearchUserPage extends StatefulWidget {
  final String? title;
  const SearchUserPage({Key? key, this.title}) : super(key: key);

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  late TextEditingController _searchController = TextEditingController();
  late FocusNode _searchFNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            leadingWidth: 35,
            title: SearchBar(
              controller: _searchController,
              focusNode: _searchFNode,
              autofocus: true,
              onChanged: (value) => context
                  .read<SearchUserBloc>()
                  .add(SearchUserEvent(query: value)),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: BlocBuilder<SearchUserBloc, SearchUserState>(
              builder: (context, state) {
                if (state is SearchUserLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.matchedUserList.length,
                    itemBuilder: (context, i) => LoadedUserListTile(
                      user: state.matchedUserList[i],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => widget.title ==
                                        'Send Message'
                                    ? MessageRoomPage(
                                        friendId:
                                            state.matchedUserList[i].userId,
                                        friendUser: state.matchedUserList[i],
                                      )
                                    : ProfilePage(
                                        user: state.matchedUserList[i])));
                      },
                    ),
                  );
                } else if (state is SearchUserLoading) {
                  return Shimmer.fromColors(
                    baseColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                    highlightColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    enabled: true,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (_, __) => LoadingUserListTile(),
                    ),
                  );
                } else if (state is SearchUserError) {
                  return Center(
                    child: Text("OOPS! Something went wrong."),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )),
    );
  }
}
