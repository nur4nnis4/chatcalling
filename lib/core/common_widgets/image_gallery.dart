import 'dart:io';

import '../common_features/attachment/domain/entities/attachment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageGallery extends StatefulWidget {
  final List<Attachment> galleryItems;
  final int? initialPage;

  const ImageGallery({Key? key, required this.galleryItems, this.initialPage})
      : super(key: key);

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late int _currentPage = widget.initialPage ?? 0;
  late PageController _pageController =
      PageController(initialPage: widget.initialPage ?? 0);

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: PhotoViewGallery.builder(
                      builder: (context, i) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: widget
                                      .galleryItems[i].url.isNotEmpty &&
                                  !kIsWeb &&
                                  !widget.galleryItems[i].url.startsWith("http")
                              ? FileImage(File(widget.galleryItems[i].url))
                                  as ImageProvider
                              : NetworkImage(widget.galleryItems[i].url),
                          initialScale: PhotoViewComputedScale.contained,
                          // heroAttributes: PhotoViewHeroAttributes(tag: i),
                        );
                      },
                      itemCount: widget.galleryItems.length,
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    event.expectedTotalBytes!,
                          ),
                        ),
                      ),
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      pageController: _pageController,
                      onPageChanged: _onPageChanged,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, maxHeight: 60),
                    color: Colors.black.withAlpha(70),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context)),
                        Expanded(
                            child: Text(
                          'Image ${_currentPage + 1}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.galleryItems.length > 1
                ? _pagination(
                    imageList: widget.galleryItems, currentPage: _currentPage)
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  _pagination({required List<Attachment> imageList, required int currentPage}) {
    final double size = 80;
    return Container(
      width: double.infinity,
      height: size,
      color: Colors.black,
      child: ListView.builder(
        itemCount: imageList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: InkWell(
              onTap: () {
                _onPageChanged(i);
                _pageController.jumpToPage(i);
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: size,
                    height: size,
                    child: widget.galleryItems[i].url.isNotEmpty &&
                            !kIsWeb &&
                            !widget.galleryItems[i].url.startsWith("http")
                        ? Image.file(File(imageList[i].url), fit: BoxFit.cover)
                        : Image.network(imageList[i].url, fit: BoxFit.cover),
                  ),
                  Offstage(
                    offstage: i == _currentPage,
                    child: Container(
                      height: size,
                      width: size,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
