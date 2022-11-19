import 'package:bloc/bloc.dart';
import '../../domain/entities/attachment.dart';
import '../../domain/usecases/get_lost_attachments.dart';
import '../../domain/usecases/pick_attachments.dart';
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
    on<AttachMultipleImagesEvent>((event, emit) async {
      await _onEvent(emit, AttachmentType.multipleImages);
    });

    on<TakeCameraImageEvent>(
      (event, emit) async {
        await _onEvent(emit, AttachmentType.cameraImage);
      },
    );
    on<AttachVideoEvent>(
      (event, emit) async {
        await _onEvent(emit, AttachmentType.video);
      },
    );
    on<TakeCameraVideoEvent>(
      (event, emit) async {
        await _onEvent(emit, AttachmentType.cameraVideo);
      },
    );

    on<ResetAttachmentEvent>(
      (event, emit) async {
        emit(PickAttachmentsEmpty());
      },
    );
  }

  Future<void> _onEvent(
      Emitter<PickAttachmentsState> emit, AttachmentType attachmentType) async {
    final result = await pickAttachments(attachmentType: attachmentType);
    result.fold(
        (error) => emit(PickAttachmentsError(errorMessage: error.message)),
        (attachments) =>
            emit(MultipleImagesLoaded.copyWith(attachments: attachments)));
  }
}
