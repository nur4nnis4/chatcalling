part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends UserEvent {
  final String userId;

  GetUserDataEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
