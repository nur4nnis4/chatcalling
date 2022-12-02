import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/conversation_list_bloc/conversation_list_bloc.dart';
import '../widgets/conversations_tile.dart';
import '../widgets/empty_conversation.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(L10n.of(context).message,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w600,
                  fontSize: 18)),
        ),
      ),
      body: BlocBuilder<ConversationListBloc, ConversationListState>(
        builder: (context, state) {
          if (state is ConversationListEmpty) {
            return EmptyConversation();
          } else if (state is ConversationListLoading) {
            return Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.onTertiaryContainer,
              highlightColor: Theme.of(context).colorScheme.tertiaryContainer,
              enabled: true,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                itemCount: 4,
                itemBuilder: (_, __) => LoadingConversationsTile(),
              ),
            );
          } else if (state is ConversationListError) {
            return Container(
              child: Text("ERROR : ${state.errorMessage}"),
            );
          } else if (state is ConversationListLoaded)
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: state.conversationList.length,
              itemBuilder: (_, index) => LoadedConversationsTile(
                  conversation: state.conversationList[index]),
            );
          else {
            return Center(
              child: Text('Something went wrong...'),
            );
          }
        },
      ),
    );
  }
}
