import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/core/common_features/attachment/domain/usecases/get_lost_attachments.dart';
import 'package:chatcalling/core/common_features/attachment/domain/usecases/pick_attachments.dart';
import 'package:equatable/equatable.dart';

part 'pick_attachments_event.dart';
part 'pick_attachments_state.dart';

class PickAttachmentsBloc
    extends Bloc<PickAttachmentsEvent, PickAttachmentsState> {
  final PickAttachments pickAttachments;
  final GetLostAttachments getLostAttachments;
  PickAttachmentsBloc(
      {required this.pickAttachments, required this.getLostAttachments})
      : super(PickAttachmentsEmpty()) {
    on<PickAttachmentsEvent>((event, emit) async {
      emit(PickAttachmentsLoading());
      late AttachmentType attachmentType;

      if (event is AttachMultipleImagesEvent) {
        attachmentType = AttachmentType.multipleImages;
      } else if (event is TakeCameraImageEvent) {
        attachmentType = AttachmentType.cameraImage;
      } else if (event is AttachVideoEvent) {
        attachmentType = AttachmentType.video;
      } else {
        attachmentType = AttachmentType.cameraVideo;
      }

      final result = await pickAttachments(attachmentType: attachmentType);
      result.fold(
          (error) => emit(PickAttachmentsError(errorMessage: error.message)),
          (attachments) =>
              emit(PickAttachmentsLoaded(attachments: attachments)));
    });
  }
}
