import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/common_features/attachment/presentations/bloc/attachments_bloc.dart';
import 'core/common_features/user/presentation/bloc/friend_list_bloc/friend_list_bloc.dart';
import 'core/common_features/user/presentation/bloc/other_user_bloc/other_user_bloc.dart';
import 'core/common_features/user/presentation/bloc/personal_information_bloc/personal_information_bloc.dart';
import 'core/common_features/user/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'core/common_features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'core/common_features/user/presentation/pages/friends_page.dart';
import 'core/style/theme.dart' as Theme;
import 'features/messages/presentation/bloc/conversation_list_bloc/conversation_list_bloc.dart';
import 'features/messages/presentation/bloc/message_list_bloc.dart/message_list_bloc.dart';
import 'features/messages/presentation/bloc/send_message_bloc.dart/send_message_bloc.dart';
import 'features/messages/presentation/pages/messages_page.dart';
import 'firebase_options.dart';
import 'home_page.dart';
import 'injector.dart' as Injector;
import 'l10n/l10n.dart';

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
          create: (_) => Injector.sLocator<UserBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<OtherUserBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<FriendListBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<SearchUserBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<PersonalInformationBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<MessageListBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<ConversationListBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<SendMessageBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<AttachmentsBloc>(),
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
            case '/':
              return MaterialPageRoute(builder: (context) => HomePage());
            case '/messages_page':
              return MaterialPageRoute(builder: (context) => MessagesPage());
            case '/friends_page':
              return MaterialPageRoute(builder: (context) => FriendsPage());
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
