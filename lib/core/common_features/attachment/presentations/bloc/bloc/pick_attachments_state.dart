part of 'pick_attachments_bloc.dart';

abstract class PickAttachmentsState extends Equatable {
  const PickAttachmentsState();

  @override
  List<Object> get props => [];
}

class PickAttachmentsEmpty extends PickAttachmentsState {}

class PickAttachmentsLoading extends PickAttachmentsState {}

class PickAttachmentsLoaded extends PickAttachmentsState {
  final List<Attachment> attachments;

  PickAttachmentsLoaded({required this.attachments});

  @override
  List<Object> get props => [attachments];
}

class PickAttachmentsError extends PickAttachmentsState {
  final String errorMessage;

  PickAttachmentsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
