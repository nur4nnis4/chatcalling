import 'package:chatcalling/features/messages/presentation/pages/messages_screen.dart';
import 'package:chatcalling/injector.dart' as Injector;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.init();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatCalling',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor)),
      home: Scaffold(
        body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) => MessagesScreen(),
        ),
      ),
    );
  }
}
