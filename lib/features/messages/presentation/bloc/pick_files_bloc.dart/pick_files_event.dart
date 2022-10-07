import 'package:equatable/equatable.dart';

abstract class PickFilesEvent extends Equatable {
  const PickFilesEvent();

  @override
  List<Object> get props => [];
}

class OnSelectMultipleImageEvent extends PickFilesEvent {}

class OnUnselectMultipleImageEvent extends PickFilesEvent {}
