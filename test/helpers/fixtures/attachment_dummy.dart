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
final tAttachmentModelList = [
  AttachmentModel(
      url: "test/helpers/images/image1.jpg", contentType: "Image/jpg"),
  AttachmentModel(
      url: "test/helpers/images/image2.jpg", contentType: "Image/jpg")
];

final tExpectedAttachmentModelList = [
  AttachmentModel(
      url:
          "https://firebasestorage.googleapis.com/v0/b/some-bucket/o/messages/newMessageId-0.jpg",
      contentType: "Image/jpg"),
  AttachmentModel(
      url:
          "https://firebasestorage.googleapis.com/v0/b/some-bucket/o/messages/newMessageId-1.jpg",
      contentType: "Image/jpg")
];

final Map<String, dynamic> tAttachmentJson = {
  "url": "http://image1.jpg",
  "contentType": "Image/jpg",
};
