import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_widgets/image_gallery.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final User user;
  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            stops: [0.1, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: user.coverPhotoUrl.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(user.coverPhotoUrl),
                  fit: BoxFit.cover,
                )
              : null),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SafeArea(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageGallery(galleryItems: [
                    Attachment(
                        url: user.profilePhotoUrl, contentType: 'Image/jpg')
                  ]),
                ),
              );
            },
            child: CircleAvatar(
              radius: 35,
              backgroundColor:
                  Theme.of(context).colorScheme.onPrimary.withAlpha(200),
              foregroundImage: user.profilePhotoUrl.isNotEmpty
                  ? NetworkImage(user.profilePhotoUrl)
                  : null,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          user.displayName,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        Text(
          '@${user.username}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w300,
          ),
        ),
      ]),
    );
  }
}
