import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/conversation_list_bloc/conversation_list_bloc.dart';
import '../widgets/conversations_tile.dart';
import '../widgets/empty_conversation.dart';
import '../widgets/m_page_app_bar.dart';

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
      appBar: MessagePageAppBar(),
      body: BlocBuilder<ConversationListBloc, ConversationListState>(
        builder: (context, state) {
          if (state is ConversationListEmpty) {
            return EmptyConversation();
          } else if (state is ConversationListLoading) {
            return Center(
              child: CircularProgressIndicator(),
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
              itemBuilder: (_, index) => ConversationsTile(
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
