import 'package:bloc/bloc.dart';
import '../../domain/entities/attachment.dart';
import '../../domain/usecases/get_lost_attachments.dart';
import '../../domain/usecases/pick_attachments.dart';
import 'package:equatable/equatable.dart';

part 'attachments_event.dart';
part 'attachments_state.dart';

class AttachmentsBloc extends Bloc<AttachmentsEvent, AttachmentsState> {
  final PickAttachments pickAttachments;
  final GetLostAttachments getLostAttachments;
  AttachmentsBloc(
      {required this.pickAttachments, required this.getLostAttachments})
      : super(AttachmentsEmpty()) {
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
        emit(AttachmentsEmpty());
      },
    );
  }

  Future<void> _onEvent(
      Emitter<AttachmentsState> emit, AttachmentType attachmentType) async {
    final result = await pickAttachments(attachmentType: attachmentType);
    result.fold(
        (error) => emit(AttachmentsError(errorMessage: error.message)),
        (attachments) =>
            emit(AttachmentsLoaded.copyWith(attachments: attachments)));
  }
}
