part of 'update_read_status_bloc.dart';

class UpdateReadStatusEvent extends Equatable {
  final String friendId;

  UpdateReadStatusEvent(this.friendId);

  @override
  List<Object> get props => [friendId];
}
