part of 'username_availability_bloc.dart';

abstract class UsernameAvailabilityState extends Equatable {
  const UsernameAvailabilityState();

  @override
  List<Object> get props => [];
}

class UsernameInitial extends UsernameAvailabilityState {}

class UsernameLoading extends UsernameAvailabilityState {}

class UsernameAvailable extends UsernameAvailabilityState {}

class UsernameTaken extends UsernameAvailabilityState {
  final String message;

  UsernameTaken({required this.message});

  @override
  List<Object> get props => [message];
}
