part of 'pick_attachments_bloc.dart';

abstract class PickAttachmentsEvent extends Equatable {
  const PickAttachmentsEvent();

  @override
  List<Object> get props => [];
}

class AttachMultipleImagesEvent extends PickAttachmentsEvent {}

class TakeCameraImageEvent extends PickAttachmentsEvent {}

class AttachVideoEvent extends PickAttachmentsEvent {}

class TakeCameraVideoEvent extends PickAttachmentsEvent {}
