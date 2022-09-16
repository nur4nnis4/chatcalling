import 'package:flutter/material.dart';

abstract class MessageBubble extends StatelessWidget {
  final String message;
  const MessageBubble({required this.message}) : super();
}

class ReceivedMessageBubble extends MessageBubble {
  ReceivedMessageBubble({required String message}) : super(message: message);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Card(
            child: Container(
              child: Text(
                message,
                style: (TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            elevation: 0.0,
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(45),
              bottomRight: Radius.circular(45),
              topLeft: Radius.circular(45),
            )),
          ),
        )
      ],
    );
  }
}

class SentMessageBubble extends MessageBubble {
  SentMessageBubble({required String message}) : super(message: message);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Card(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
              child: Text(
                message,
                style: (TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ),
            elevation: 0.0,
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45),
            )),
          ),
        ),
      ],
    );
  }
}
