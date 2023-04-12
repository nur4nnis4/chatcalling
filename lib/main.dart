import 'package:chatcalling/authenticate.dart';
import 'package:chatcalling/core/common_features/user/presentation/cubit/obscure_cubit.dart';
import 'package:chatcalling/core/cubit/current_page_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/common_features/attachment/presentations/bloc/attachments_bloc.dart';
import 'core/network/network_bloc/network_bloc.dart';
import 'core/common_features/user/presentation/bloc/friend_list_bloc/friend_list_bloc.dart';
import 'core/common_features/user/presentation/bloc/other_user_bloc/other_user_bloc.dart';
import 'core/common_features/user/presentation/bloc/personal_information_bloc/personal_information_bloc.dart';
import 'core/common_features/user/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'core/common_features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'core/common_features/user/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'core/common_features/user/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'core/common_features/user/presentation/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'core/common_features/user/presentation/bloc/update_user_bloc/update_user_bloc.dart';
import 'core/common_features/user/presentation/bloc/username_availability_bloc/username_availability_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_status_bloc/sign_in_status_bloc.dart';

import 'core/style/theme.dart' as Theme;
import 'features/messages/presentation/bloc/conversation_list_bloc/conversation_list_bloc.dart';
import 'features/messages/presentation/bloc/message_list_bloc.dart/message_list_bloc.dart';
import 'features/messages/presentation/bloc/update_read_status_bloc/update_read_status_bloc.dart';
import 'features/messages/presentation/bloc/send_message_bloc.dart/send_message_bloc.dart';
import 'firebase_options.dart';
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
          create: (_) => CurrentPageCubit(),
        ),
        BlocProvider(
          create: (_) => ObscureCubit(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<NetworkBloc>(),
        ),
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
          create: (_) => Injector.sLocator<SignUpBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<UsernameAvailabilityBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<SignInStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<SignInBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<SignOutBloc>(),
        ),
        BlocProvider(
          create: (_) => Injector.sLocator<UpdateUserBloc>(),
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
          create: (_) => Injector.sLocator<UpdateReadStatusBloc>(),
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
        home: Authenticate(),
      ),
    );
  }
}
