import '../../domain/entities/attachment.dart';

class AttachmentModel extends Attachment {
  AttachmentModel({required String url, required String contentType})
      : super(url: url, contentType: contentType);

  factory AttachmentModel.fromJson({Map<String, dynamic>? json}) =>
      AttachmentModel(url: json?['url'], contentType: json?["contentType"]);

  Map<String, dynamic> toJson() => {"url": url, "contentType": contentType};

  factory AttachmentModel.fromEntity({required Attachment attachment}) {
    return AttachmentModel(
        url: attachment.url, contentType: attachment.contentType);
  }
}
