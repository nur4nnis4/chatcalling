import 'package:flutter/material.dart ';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        child: Text(
          'Hello World',
          style: TextStyle(fontSize: 38, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
