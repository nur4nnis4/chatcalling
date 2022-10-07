import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ViewImagePage extends StatelessWidget {
  final String imagePath;
  const ViewImagePage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: imagePath.isNotEmpty && !kIsWeb
                      ? DecorationImage(
                          image: FileImage(File(imagePath)), fit: BoxFit.contain)
                      : imagePath.isNotEmpty && kIsWeb
                          ? DecorationImage(
                              image: NetworkImage(imagePath), fit: BoxFit.contain)
                          : null,
                ),
              )),
            ],
          ),
          Container(
            constraints:
                BoxConstraints(maxWidth: double.infinity, maxHeight: 60),
            color: Colors.black.withAlpha(70),
            alignment: Alignment.centerLeft,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context)),
          ),
        ]),
      ),
    );
  }
}
