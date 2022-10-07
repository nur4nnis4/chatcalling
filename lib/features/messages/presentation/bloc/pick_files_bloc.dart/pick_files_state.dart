import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:equatable/equatable.dart';

class PickFilesState extends Equatable {
  final List<Attachment> pickedImageList;

  PickFilesState({required this.pickedImageList});
  factory PickFilesState.initial() => PickFilesState(pickedImageList: []);
  PickFilesState copyWith({required List<Attachment> pickedImageList}) =>
      PickFilesState(pickedImageList: pickedImageList);

  @override
  List<Object> get props => [pickedImageList];
}
