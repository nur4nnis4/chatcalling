part of 'pick_attachments_bloc.dart';

abstract class PickAttachmentsState extends Equatable {
  const PickAttachmentsState();

  @override
  List<Object> get props => [];
}

class PickAttachmentsEmpty extends PickAttachmentsState {}

class MultipleImagesLoaded extends PickAttachmentsState {
  final List<Attachment> attachments;

  MultipleImagesLoaded({required this.attachments});

  static MultipleImagesLoaded copyWith(
          {required List<Attachment> attachments}) =>
      MultipleImagesLoaded(attachments: attachments);

  @override
  List<Object> get props => [attachments];
}

class PickAttachmentsError extends PickAttachmentsState {
  final String errorMessage;

  PickAttachmentsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
