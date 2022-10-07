import 'package:equatable/equatable.dart';

class Attachment extends Equatable {
  final String url;
  final String contentType;

  Attachment({required this.url, required this.contentType});

  @override
  List<Object?> get props => [url, contentType];
}

enum AttachmentType {
  multipleImages,
  cameraImage,
  video,
  cameraVideo,
  doc,
}
