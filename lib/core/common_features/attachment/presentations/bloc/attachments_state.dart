part of 'attachments_bloc.dart';

abstract class AttachmentsState extends Equatable {
  const AttachmentsState();

  @override
  List<Object> get props => [];
}

class AttachmentsEmpty extends AttachmentsState {}

class AttachmentsLoaded extends AttachmentsState {
  final List<Attachment> attachments;

  AttachmentsLoaded({required this.attachments});

  static AttachmentsLoaded copyWith({required List<Attachment> attachments}) =>
      AttachmentsLoaded(attachments: attachments);

  @override
  List<Object> get props => [attachments];
}

class AttachmentsError extends AttachmentsState {
  final String errorMessage;

  AttachmentsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
