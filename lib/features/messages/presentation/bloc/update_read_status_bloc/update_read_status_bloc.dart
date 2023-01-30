import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/get_current_user_id.dart';
import 'package:chatcalling/core/helpers/unique_id.dart';
import 'package:chatcalling/features/messages/domain/usecases/update_read_status.dart';
import 'package:equatable/equatable.dart';

part 'update_read_status_event.dart';
part 'update_read_status_state.dart';

class UpdateReadStatusBloc
    extends Bloc<UpdateReadStatusEvent, UpdateReadStatusState> {
  final GetCurrentUserId getCurrentUserId;
  final UpdateReadStatus updateReadStatus;
  final UniqueId uniqueId;
  UpdateReadStatusBloc({
    required this.updateReadStatus,
    required this.uniqueId,
    required this.getCurrentUserId,
  }) : super(UpdateReadStatusInitial()) {
    on<UpdateReadStatusEvent>((event, emit) async {
      final userId = await getCurrentUserId();
      final conversationId = uniqueId.concat(event.friendId, userId);

      final result = await updateReadStatus(
          conversationId: conversationId, userId: userId);

      result.fold((error) => emit(UpdateReadStatusError()),
          (success) => emit(UpdateReadStatusSuccess()));
    });
  }
}
