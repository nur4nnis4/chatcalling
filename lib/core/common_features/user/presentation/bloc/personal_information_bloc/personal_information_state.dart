part of 'personal_information_bloc.dart';

abstract class PersonalInformationState extends Equatable {
  const PersonalInformationState();

  @override
  List<Object> get props => [];
}

class PersonalInformationEmpty extends PersonalInformationState {}

class PersonalInformationLoading extends PersonalInformationState {}

class PersonalInformationLoaded extends PersonalInformationState {
  final PersonalInformation personalInformation;

  PersonalInformationLoaded({required this.personalInformation});

  @override
  List<Object> get props => [personalInformation];
}

class PersonalInformationError extends PersonalInformationState {
  final String errorMessage;

  PersonalInformationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
