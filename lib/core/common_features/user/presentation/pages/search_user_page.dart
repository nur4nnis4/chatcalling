import 'package:chatcalling/core/common_features/user/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/profile_page.dart';
import 'package:chatcalling/core/common_features/user/presentation/widgets/user_list_view_tile.dart';
import 'package:chatcalling/core/common_widgets/custom_search_bar.dart';
import 'package:chatcalling/features/messages/presentation/pages/message_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUserPage extends StatefulWidget {
  final String? title;
  const SearchUserPage({Key? key, this.title}) : super(key: key);

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  @override
  Widget build(BuildContext context) {
    late TextEditingController _searchController = TextEditingController();
    late FocusNode _searchFNode = FocusNode();

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 25,
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
                  itemBuilder: (context, i) => UserListViewTile(
                    user: state.matchedUserList[i],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => widget.title ==
                                      'Send Message'
                                  ? MessageRoomPage(
                                      friendId: state.matchedUserList[i].userId,
                                      friendUser: state.matchedUserList[i],
                                    )
                                  : ProfilePage(
                                      user: state.matchedUserList[i])));
                    },
                  ),
                );
              } else if (state is SearchUserLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SearchUserError) {
                return Center(
                  child: Text("OOPS! Something went wrong."),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
