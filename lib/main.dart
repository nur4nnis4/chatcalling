import 'package:chatcalling/core/constants/route_name.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/presentation/bloc/message_list_bloc.dart/message_list_bloc.dart';
import 'package:chatcalling/features/messages/presentation/bloc/conversation_list_bloc/conversation_list_bloc.dart';
import 'package:chatcalling/features/messages/presentation/pages/home_page.dart';
import 'package:chatcalling/features/messages/presentation/pages/message_room_page.dart';
import 'package:chatcalling/features/messages/presentation/pages/messages_page.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/constants/theme.dart' as Theme;
import 'firebase_options.dart';
import 'injector.dart' as Injector;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  Injector.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => Injector.sLocator<MessageListBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<ConversationListBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatCalling',
        theme: Theme.light,
        darkTheme: Theme.dark,
        supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorObservers: [RouteObserver<ModalRoute>()],
        onGenerateRoute: (RouteSettings setting) {
          switch (setting.name) {
            case RouteName.homePage:
              return MaterialPageRoute(builder: (context) => HomePage());
            case RouteName.messagesPage:
              return MaterialPageRoute(builder: (context) => MessagesPage());
            case RouteName.messageRoomPage:
              final conversation = setting.arguments as Conversation;
              return MaterialPageRoute(
                  builder: (context) =>
                      MessageRoomPage(conversation: conversation));
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
