part of 'username_availability_bloc.dart';

class CheckUsernameAvailabilityEvent extends Equatable {
  final String newUsername;
  final String currentUsername;
  const CheckUsernameAvailabilityEvent(
      {required this.currentUsername, required this.newUsername});

  @override
  List<Object> get props => [newUsername];
}
