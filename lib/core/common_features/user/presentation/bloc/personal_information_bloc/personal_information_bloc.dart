import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/get_current_user_id.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/get_personal_information.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'personal_information_event.dart';
part 'personal_information_state.dart';

class PersonalInformationBloc
    extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  final GetPersonalInformation getPersonalInformation;
  final GetCurrentUserId getCurrentUserId;

  PersonalInformationBloc(
      {required this.getPersonalInformation, required this.getCurrentUserId})
      : super(PersonalInformationEmpty()) {
    on<PersonalInformationEvent>((event, emit) async {
      emit(PersonalInformationLoading());

      final result = getPersonalInformation(userId: await getCurrentUserId())
          .asBroadcastStream();
      await emit.forEach(
        result,
        onData: (Either<Failure, PersonalInformation> data) => data.fold(
            (error) =>
                PersonalInformationError(errorMessage: 'Platform Failure'),
            (personalInformation) => PersonalInformationLoaded(
                personalInformation: personalInformation)),
      );
    });
  }
}
