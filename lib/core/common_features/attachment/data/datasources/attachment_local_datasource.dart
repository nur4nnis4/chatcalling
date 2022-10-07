import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class AttachmentLocalDatasource {
  Future<Either<Failure, List<Attachment>>> pickLocalImages();
  Future<Either<Failure, List<Attachment>>> pickCameraImage();
  Future<Either<Failure, List<Attachment>>> pickLocalVideo();
  Future<Either<Failure, List<Attachment>>> pickCameraVideo();
  Future<Either<Failure, List<Attachment>>> retrieveLostAttachments();
}

class AttachmentLocalDatasourceImpl extends AttachmentLocalDatasource {
  final ImagePicker imagePicker;

  AttachmentLocalDatasourceImpl({required this.imagePicker});

  @override
  Future<Either<Failure, List<Attachment>>> pickLocalImages() async {
    try {
      final List<XFile>? xFiles = await imagePicker.pickMultiImage();
      final attachmentList = xFiles!
          .map((e) => Attachment(
              url: e.path,
              contentType: 'Image/${_getAttchmentExtension(e.name)}'))
          .toList();
      return Right(attachmentList);
    } catch (e) {
      return Left(PluginFailure('Plugin Error'));
    }
  }

  @override
  Future<Either<Failure, List<Attachment>>> pickCameraImage() async {
    try {
      final XFile? xFile =
          await imagePicker.pickImage(source: ImageSource.camera);
      final attachmentList = [
        Attachment(
            url: xFile!.path,
            contentType: 'Image/${_getAttchmentExtension(xFile.name)}')
      ];
      return Right(attachmentList);
    } catch (e) {
      return Left(PluginFailure('Plugin Error'));
    }
  }

  @override
  Future<Either<Failure, List<Attachment>>> pickCameraVideo() async {
    try {
      final XFile? xFile = await imagePicker.pickVideo(
          source: ImageSource.camera, maxDuration: Duration(minutes: 3));
      final attachmentList = [
        Attachment(
            url: xFile!.path,
            contentType: 'Video/${_getAttchmentExtension(xFile.name)}')
      ];
      return Right(attachmentList);
    } catch (e) {
      return Left(PluginFailure('Plugin Error'));
    }
  }

  @override
  Future<Either<Failure, List<Attachment>>> pickLocalVideo() async {
    try {
      final XFile? xFile = await imagePicker.pickVideo(
          source: ImageSource.gallery, maxDuration: Duration(minutes: 3));
      final attachmentList = [
        Attachment(
            url: xFile!.path,
            contentType: 'Video/${_getAttchmentExtension(xFile.name)}')
      ];
      return Right(attachmentList);
    } catch (e) {
      return Left(PluginFailure('Plugin Error'));
    }
  }

  @override
  Future<Either<Failure, List<Attachment>>> retrieveLostAttachments() async {
    try {
      final LostDataResponse lostFilesResponse =
          await imagePicker.retrieveLostData();
      if (lostFilesResponse.isEmpty)
        return Right([]);
      else {
        List<Attachment> lostFiles = [];
        String lostFilesType =
            lostFilesResponse.type! == RetrieveType.image ? 'Image' : 'Video';
        if (lostFilesResponse.files != null) {
          lostFiles = lostFilesResponse.files!
              .map((e) => Attachment(
                  url: e.path,
                  contentType:
                      '$lostFilesType/${_getAttchmentExtension(e.name)}'))
              .toList();
        } else {
          lostFiles = [
            Attachment(
                url: lostFilesResponse.file!.path,
                contentType:
                    '$lostFilesType/${_getAttchmentExtension(lostFilesResponse.file!.name)}'),
          ];
        }
        return Right(lostFiles);
      }
    } catch (e) {
      return Left(PluginFailure('Plugin Error'));
    }
  }

  String _getAttchmentExtension(String name) => name.split('.').last;
}
