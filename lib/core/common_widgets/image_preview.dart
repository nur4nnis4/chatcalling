import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Custom widget to show the preview of image from the device memory

class ImagePreview extends StatelessWidget {
  final String imageUrl;
  final Function()? onTap;
  const ImagePreview({Key? key, required this.imageUrl, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(50),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: Offset.zero,
          ),
        ],
        color: Theme.of(context).colorScheme.primaryContainer,
        image: imageUrl.isNotEmpty && !kIsWeb
            ? DecorationImage(
                image: FileImage(File(imageUrl)), fit: BoxFit.cover)
            : imageUrl.isNotEmpty && kIsWeb
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
      ),
    );
  }
}
