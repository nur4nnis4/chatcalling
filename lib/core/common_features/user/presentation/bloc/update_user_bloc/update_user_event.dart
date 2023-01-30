part of 'update_user_bloc.dart';

class UpdateUserEvent extends Equatable {
  final User user;
  final PersonalInformation personalInformation;
  UpdateUserEvent({required this.user, required this.personalInformation});

  @override
  List<Object> get props => [user, personalInformation];
}
