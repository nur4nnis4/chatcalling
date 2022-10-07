import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'pick_files_event.dart';
import 'pick_files_state.dart';

class PickFilesBloc extends Bloc<PickFilesEvent, PickFilesState> {
  PickFilesBloc() : super(PickFilesState.initial()) {
    on<OnSelectMultipleImageEvent>((event, emit) async {
      final List<XFile>? xFiles = await ImagePicker().pickMultiImage();
      final attachmentList = xFiles!
          .map((xFile) => Attachment(
              url: xFile.path, contentType: xFile.name.split('.').last))
          .toList();
      print("Name: ${xFiles.first.name.split('.').last}");
      emit(state.copyWith(pickedImageList: attachmentList));
    });
    on<OnUnselectMultipleImageEvent>((event, emit) {
      emit(PickFilesState.initial());
    });
  }
}
