import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/update_personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/update_user_data.dart';
import 'package:chatcalling/core/common_features/user/presentation/utils/form_validator.dart';
import 'package:equatable/equatable.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UpdateUserData updateUserData;
  final UpdatePersonalInformation updatePersonalInformation;
  final FormValidator formValidator;
  UpdateUserBloc({
    required this.updateUserData,
    required this.formValidator,
    required this.updatePersonalInformation,
  }) : super(UpdateUserInitial()) {
    on<UpdateUserEvent>((event, emit) async {
      final isValid = formValidator.validate(
        username: event.user.username,
        email: event.personalInformation.email,
        displayName: event.user.displayName,
        phoneNumber: event.personalInformation.phoneNumber,
      );
      await isValid.fold(
          (error) async =>
              emit(UpdateUserError.copyWith(errorMessage: error.message)),
          (valid) async {
        emit(UpdateUserLoading());

        final userUpdateresult = await updateUserData(user: event.user);
        final personalInfoUpdateresult = await updatePersonalInformation(
            personalInformation: event.personalInformation);

        userUpdateresult.isRight() && personalInfoUpdateresult.isRight()
            ? emit(UpdateUserSuccess())
            : emit(UpdateUserError(otherError: 'Whoops something went wrong!'));
      });
    });
  }
}
