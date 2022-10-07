import 'package:chatcalling/core/common_features/attachment/data/models/attachment_model.dart';
import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';

final tAttachment = Attachment(
  url: "http://image1.jpg",
  contentType: "Image/jpg",
);

final tAttachmentModel = AttachmentModel(
  url: "http://image1.jpg",
  contentType: "Image/jpg",
);

final Map<String, dynamic> tAttachmentJson = {
  "url": "http://image1.jpg",
  "contentType": "Image/jpg",
};
