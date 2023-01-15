import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/is_signed_in.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_status_event.dart';
part 'sign_in_status_state.dart';

class SignInStatusBloc extends Bloc<GetSignInStatusEvent, SignInStatusState> {
  final IsSignedIn isSignedIn;
  SignInStatusBloc({required this.isSignedIn}) : super(SignInStatusInitial()) {
    on<GetSignInStatusEvent>((event, emit) async {
      final result = isSignedIn().asBroadcastStream();
      await emit.forEach(
        result,
        onData: (bool signedIn) =>
            signedIn ? SignInStatusTrue() : SignInStatusFalse(),
      );
    });
  }
}
