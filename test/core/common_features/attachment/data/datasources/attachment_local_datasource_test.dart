import 'package:chatcalling/core/common_features/attachment/data/datasources/attachment_local_datasource.dart';
import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockImagePicker mockImagePicker;
  late AttachmentLocalDatasourceImpl datasource;

  setUp(() {
    mockImagePicker = MockImagePicker();
    datasource = AttachmentLocalDatasourceImpl(imagePicker: mockImagePicker);
  });

  group('pickLocalImages', () {
    test(
        'Should return Attachment list when the getting images from local source is successful',
        () async {
      // Arrange
      final tXFileList = [
        XFile("path:/image1.jpg", name: "Image1.jpg"),
        XFile("path:/image2.png", name: "Image2.png"),
      ];
      when(mockImagePicker.pickMultiImage())
          .thenAnswer((_) async => (tXFileList));
      // Act
      final actual = await datasource
          .pickLocalImages()
          .then((value) => value.getOrElse(() => []));
      // Assert
      final tAttachmentList = [
        Attachment(url: tXFileList[0].path, contentType: 'Image/jpg'),
        Attachment(url: tXFileList[1].path, contentType: 'Image/png')
      ];

      expect(actual, containsAll(tAttachmentList));
      verify(mockImagePicker.pickMultiImage()).called(1);
    });

    test(
        'Should return PluginFailure  when the getting images from local source failed',
        () async {
      // Arrange
      when(mockImagePicker.pickMultiImage())
          .thenThrow(PluginFailure('Plugin Error'));
      // Act
      final actual = await datasource.pickLocalImages();
      // Assert
      expect(actual, Left(PluginFailure('Plugin Error')));
      verify(mockImagePicker.pickMultiImage()).called(1);
    });
  });

  group('pickCamerImage', () {
    final tXFile = XFile("path:/image1.jpg", name: "Image1.jpg");
    final tAttachmentList = [
      Attachment(url: tXFile.path, contentType: 'Image/jpg')
    ];

    test(
        'Should return Attachment list when the getting images from camera source is successful',
        () async {
      // Arrange
      when(mockImagePicker.pickImage(source: ImageSource.camera))
          .thenAnswer((_) async => tXFile);
      // Act
      final actual = await datasource
          .pickCameraImage()
          .then((value) => value.getOrElse(() => []));
      // Assert
      expect(actual, containsAll(tAttachmentList));
      verify(mockImagePicker.pickImage(source: ImageSource.camera)).called(1);
    });

    test(
        'Should return PluginFailure  when the getting images from camera source failed',
        () async {
      // Arrange
      when(mockImagePicker.pickImage(source: ImageSource.camera))
          .thenThrow(PluginFailure('Plugin Error'));
      // Act
      final actual = await datasource.pickCameraImage();
      // Assert
      expect(actual, Left(PluginFailure('Plugin Error')));
      verify(mockImagePicker.pickImage(source: ImageSource.camera)).called(1);
    });
  });
  group('pickLocalVideo', () {
    final tXFile = XFile("path:/video1.mp4", name: "video1.mp4");
    final tAttachmentList = [
      Attachment(url: tXFile.path, contentType: 'Video/mp4')
    ];

    test(
        'Should return Attachment list when the getting video from local source is successful',
        () async {
      // Arrange
      when(mockImagePicker.pickVideo(
              source: ImageSource.gallery, maxDuration: Duration(minutes: 3)))
          .thenAnswer((_) async => tXFile);
      // Act
      final actual = await datasource
          .pickLocalVideo()
          .then((value) => value.getOrElse(() => []));
      // Assert
      expect(actual, containsAll(tAttachmentList));
      verify(mockImagePicker.pickVideo(
              source: ImageSource.gallery, maxDuration: Duration(minutes: 3)))
          .called(1);
    });

    test(
        'Should return PluginFailure  when the getting video from local source failed',
        () async {
      // Arrange
      when(mockImagePicker.pickVideo(
              source: ImageSource.gallery, maxDuration: Duration(minutes: 3)))
          .thenThrow(PluginFailure('Plugin Error'));
      // Act
      final actual = await datasource.pickLocalVideo();
      // Assert
      expect(actual, Left(PluginFailure('Plugin Error')));
      verify(mockImagePicker.pickVideo(
              source: ImageSource.gallery, maxDuration: Duration(minutes: 3)))
          .called(1);
    });
  });
  group('pickCameraVideo', () {
    final tXFile = XFile("path:/video1.mp4", name: "Video1.mp4");
    final tAttachmentList = [
      Attachment(url: tXFile.path, contentType: 'Video/mp4')
    ];

    test(
        'Should return Attachment list when the getting video from camera source is successful',
        () async {
      // Arrange
      when(mockImagePicker.pickVideo(
              source: ImageSource.camera, maxDuration: Duration(minutes: 3)))
          .thenAnswer((_) async => tXFile);
      // Act
      final actual = await datasource
          .pickCameraVideo()
          .then((value) => value.getOrElse(() => []));
      // Assert
      expect(actual, containsAll(tAttachmentList));
      verify(mockImagePicker.pickVideo(
              source: ImageSource.camera, maxDuration: Duration(minutes: 3)))
          .called(1);
    });

    test(
        'Should return PluginFailure  when the getting video from camera source failed',
        () async {
      // Arrange
      when(mockImagePicker.pickVideo(
              source: ImageSource.camera, maxDuration: Duration(minutes: 3)))
          .thenThrow(PluginFailure('Plugin Error'));
      // Act
      final actual = await datasource.pickCameraVideo();
      // Assert
      expect(actual, Left(PluginFailure('Plugin Error')));
      verify(mockImagePicker.pickVideo(
              source: ImageSource.camera, maxDuration: Duration(minutes: 3)))
          .called(1);
    });
  });

  group('getLostAttachments', () {
    test('Should return empty list when there is no lostData found', () async {
      // Arrange
      when(mockImagePicker.retrieveLostData())
          .thenAnswer((_) async => LostDataResponse.empty());
      // Act
      final actual = await datasource
          .retrieveLostAttachments()
          .then((value) => value.getOrElse(() => []));
      // Assert
      expect(actual, []);
      verify(mockImagePicker.retrieveLostData()).called(1);
    });

    test(
        'Should return list of Attachment when there is a list of lost files found',
        () async {
      // Arrange
      final tXFileList = [
        XFile("path:/image1.jpg", name: "image1.jpg"),
        XFile("path:/image2.png", name: "image2.png"),
      ];
      when(mockImagePicker.retrieveLostData()).thenAnswer((_) async =>
          LostDataResponse(files: tXFileList, type: RetrieveType.image));
      // Act
      final actual = await datasource
          .retrieveLostAttachments()
          .then((value) => value.getOrElse(() => []));
      // Assert

      final tAttachmentList = [
        Attachment(url: tXFileList[0].path, contentType: 'Image/jpg'),
        Attachment(url: tXFileList[1].path, contentType: 'Image/png')
      ];
      expect(actual, tAttachmentList);
      verify(mockImagePicker.retrieveLostData()).called(1);
    });
  });

  test(
      'Should return list of Attachment when there is only one lost file found',
      () async {
    // Arrange
    final tXFile = XFile("path:/video1.mp4", name: "video1.mp4");
    when(mockImagePicker.retrieveLostData()).thenAnswer(
        (_) async => LostDataResponse(file: tXFile, type: RetrieveType.video));
    // Act
    final actual = await datasource
        .retrieveLostAttachments()
        .then((value) => value.getOrElse(() => []));
    // Assert

    final tAttachmentList = [
      Attachment(url: tXFile.path, contentType: 'Video/mp4')
    ];

    expect(actual, tAttachmentList);
    verify(mockImagePicker.retrieveLostData()).called(1);
  });

  test('Should return PluginFailure  when getting lost data failed', () async {
    // Arrange
    when(mockImagePicker.retrieveLostData())
        .thenThrow(PluginFailure('Plugin Error'));
    // Act
    final actual = await datasource.retrieveLostAttachments();
    // Assert
    expect(actual, Left(PluginFailure('Plugin Error')));
    verify(mockImagePicker.retrieveLostData()).called(1);
  });
}
