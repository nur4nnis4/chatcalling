part of 'attachments_bloc.dart';

abstract class AttachmentsEvent extends Equatable {
  const AttachmentsEvent();

  @override
  List<Object> get props => [];
}

class AttachMultipleImagesEvent extends AttachmentsEvent {}

class TakeCameraImageEvent extends AttachmentsEvent {}

class AttachVideoEvent extends AttachmentsEvent {}

class TakeCameraVideoEvent extends AttachmentsEvent {}

class ResetAttachmentEvent extends AttachmentsEvent {}
