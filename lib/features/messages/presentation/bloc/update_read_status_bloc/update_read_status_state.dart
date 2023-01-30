part of 'update_read_status_bloc.dart';

abstract class UpdateReadStatusState extends Equatable {
  const UpdateReadStatusState();

  @override
  List<Object> get props => [];
}

class UpdateReadStatusInitial extends UpdateReadStatusState {}

class UpdateReadStatusSuccess extends UpdateReadStatusState {}

class UpdateReadStatusError extends UpdateReadStatusState {}
