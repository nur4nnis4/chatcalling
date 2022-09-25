import 'package:flutter/material.dart';

class EmptyConversation extends StatelessWidget {
  const EmptyConversation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Text(
            'Hi there!',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w800,
                fontSize: 38),
          ),
          SizedBox(height: 10),
          Text(
            'Looks like you have not initiated any conversation yet.',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          SizedBox(height: 25),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            width: 1.7,
                            color: Theme.of(context).colorScheme.primary)))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                'Write a Message',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
