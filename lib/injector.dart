import 'package:chatcalling/core/common_features/user/data/datasources/auth_remote_datasource.dart';
import 'package:chatcalling/core/common_features/user/data/repositories/auth_repository_impl.dart';
import 'package:chatcalling/core/common_features/user/data/utils/auth_error_message.dart';
import 'package:chatcalling/core/common_features/user/domain/repositories/auth_repository.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/get_current_user_id.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/is_signed_in.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_in_with_email.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_in_with_google.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_out.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_up_with_email.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/check_username_availability.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_status_bloc/sign_in_status_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/utils/form_validator.dart';
import 'package:chatcalling/core/common_features/user/presentation/utils/user_input_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'core/common_features/attachment/data/datasources/attachment_local_datasource.dart';
import 'core/common_features/attachment/data/repositories/attachment_repository_impl.dart';
import 'core/common_features/attachment/domain/repositories/attachment_repository.dart';
import 'core/common_features/attachment/domain/usecases/get_lost_attachments.dart';
import 'core/common_features/attachment/domain/usecases/pick_attachments.dart';
import 'core/common_features/attachment/presentations/bloc/attachments_bloc.dart';
import 'core/common_features/user/data/datasources/user_remote_datasource.dart';
import 'core/common_features/user/data/repositories/user_repository_impl.dart';
import 'core/common_features/user/domain/repositories/user_repository.dart';
import 'core/common_features/user/domain/usecases/user_usercases/get_friend_list.dart';
import 'core/common_features/user/domain/usecases/user_usercases/get_personal_information.dart';
import 'core/common_features/user/domain/usecases/user_usercases/get_user_data.dart';
import 'core/common_features/user/domain/usecases/user_usercases/search_user.dart';
import 'core/common_features/user/presentation/bloc/friend_list_bloc/friend_list_bloc.dart';
import 'core/common_features/user/presentation/bloc/other_user_bloc/other_user_bloc.dart';
import 'core/common_features/user/presentation/bloc/personal_information_bloc/personal_information_bloc.dart';
import 'core/common_features/user/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'core/common_features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'core/helpers/check_platform.dart';
import 'core/helpers/time.dart';
import 'core/helpers/unique_id.dart';
import 'features/messages/data/datasources/message_remote_datasource.dart';
import 'features/messages/data/repositories/message_repository_impl.dart';
import 'features/messages/domain/repositories/message_repository.dart';
import 'features/messages/domain/usecases/get_conversations.dart';
import 'features/messages/domain/usecases/get_messages.dart';
import 'features/messages/domain/usecases/send_message.dart';
import 'features/messages/domain/usecases/update_read_status.dart';
import 'features/messages/presentation/bloc/conversation_list_bloc/conversation_list_bloc.dart';
import 'features/messages/presentation/bloc/message_list_bloc.dart/message_list_bloc.dart';
import 'features/messages/presentation/bloc/send_message_bloc.dart/send_message_bloc.dart';
import 'features/messages/presentation/utils/message_input_converter.dart';

final sLocator = GetIt.instance;

void init() {
  // FEATURES
  initMessage();

  // CORE - User
  initUser();
  initAttachment();

  // Core - Helpers
  sLocator.registerLazySingleton<UniqueId>(() => UniqueIdImpl());
  sLocator.registerLazySingleton(() => TimeFormat(time: sLocator()));
  sLocator.registerLazySingleton<Time>(() => TimeImpl());
  sLocator.registerLazySingleton<CheckPlatform>(() => CheckPlatformImpl());

  // EXTERNAL

  sLocator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  sLocator
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sLocator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sLocator.registerLazySingleton(() => GoogleSignIn());

  sLocator.registerLazySingleton(() => ImagePicker());
}

void initAttachment() {
  // Bloc
  sLocator.registerFactory(() => AttachmentsBloc(
      pickAttachments: sLocator(), getLostAttachments: sLocator()));

  // Use case
  sLocator.registerLazySingleton(() => PickAttachments(sLocator()));
  sLocator.registerLazySingleton(() => GetLostAttachments(sLocator()));

  // Repository
  sLocator.registerLazySingleton<AttachmentRepository>(
      () => AttachmentRepositoryImpl(attachmentLocalDatasource: sLocator()));

  // Data sources
  sLocator.registerLazySingleton<AttachmentLocalDatasource>(
      () => AttachmentLocalDatasourceImpl(imagePicker: sLocator()));
}

void initMessage() {
  // Bloc
  sLocator.registerFactory(() => MessageListBloc(
      getMessages: sLocator(),
      updateReadStatus: sLocator(),
      uniqueId: sLocator(),
      getCurrentUserId: sLocator()));
  sLocator.registerFactory(() => ConversationListBloc(
      getConversations: sLocator(), getCurrentUserId: sLocator()));
  sLocator.registerFactory(() => SendMessageBloc(
      sendMessage: sLocator(),
      messageInputConverter: sLocator(),
      getCurrentUserId: sLocator()));

  // Use cases
  sLocator.registerLazySingleton(() => GetMessages(sLocator()));
  sLocator.registerLazySingleton(() => GetConversations(sLocator()));
  sLocator.registerLazySingleton(() => SendMessage(sLocator()));
  sLocator.registerLazySingleton(() => UpdateReadStatus(sLocator()));

  // Repository
  sLocator.registerLazySingleton<MessageRepository>(() => MessageRepositoryImpl(
        messageRemoteDatasource: sLocator(),
      ));

  // Data sources
  sLocator.registerLazySingleton<MessageRemoteDatasource>(() =>
      MessageRemoteDatasourceImpl(
          firebaseFirestore: sLocator(),
          firebaseStorage: sLocator(),
          checkPlatform: sLocator()));

  // Utils
  sLocator.registerLazySingleton(
      () => MessageInputConverter(uniqueId: sLocator(), time: sLocator()));
}

void initUser() {
  // Bloc
  sLocator.registerFactory(
      () => UserBloc(getUserData: sLocator(), getCurrentUserId: sLocator()));
  sLocator.registerFactory(() => OtherUserBloc(getUserData: sLocator()));
  sLocator.registerFactory(() => SearchUserBloc(searchUser: sLocator()));
  sLocator.registerFactory(() => SignInStatusBloc(isSignedIn: sLocator()));
  sLocator.registerFactory(() => SignOutBloc(signOut: sLocator()));
  sLocator.registerFactory(() =>
      FriendListBloc(getFriendList: sLocator(), getCurrentUserId: sLocator()));
  sLocator.registerFactory(() => PersonalInformationBloc(
      getPersonalInformation: sLocator(), getCurrentUserId: sLocator()));
  sLocator.registerFactory(() => SignUpBloc(
      checkUsernameAvailability: sLocator(),
      formValidator: sLocator(),
      signUpWithEmail: sLocator(),
      userInputConverter: sLocator()));
  sLocator.registerFactory(() =>
      SignInBloc(signInWithEmail: sLocator(), signInWithGoogle: sLocator()));

  // User Use cases
  sLocator.registerLazySingleton(() => GetUserData(sLocator()));
  sLocator.registerLazySingleton(() => GetPersonalInformation(sLocator()));
  sLocator.registerLazySingleton(() => GetFriendList(sLocator()));
  sLocator.registerLazySingleton(() => SearchUser(sLocator()));
  sLocator.registerLazySingleton(() => CheckUsernameAvailability(sLocator()));

  // Auth Use cases
  sLocator.registerLazySingleton(() => GetCurrentUserId(sLocator()));
  sLocator.registerLazySingleton(() => IsSignedIn(sLocator()));
  sLocator.registerLazySingleton(() => SignUpWithEmail(sLocator()));
  sLocator.registerLazySingleton(() => SignInWithEmail(sLocator()));
  sLocator.registerLazySingleton(() => SignInWithGoogle(sLocator()));
  sLocator.registerLazySingleton(() => SignOut(sLocator()));

  // Repository
  sLocator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDatasource: sLocator()));
  sLocator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      userRemoteDatasource: sLocator(), authRemoteDatasource: sLocator()));

  // Data sources
  sLocator.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(sLocator()));

  // Data sources
  sLocator.registerLazySingleton<AuthRemoteDatasource>(() =>
      AuthRemoteDatasourceImpl(
          authErrorMessage: sLocator(),
          firebaseAuth: sLocator(),
          googleSignIn: sLocator(),
          time: sLocator()));

  // Utils
  sLocator
      .registerLazySingleton<AuthErrorMessage>(() => AuthErrorMessageImpl());
  sLocator.registerLazySingleton<FormValidator>(() => FormValidatorImpl());
  sLocator.registerLazySingleton(
      () => UserInputConverter(time: sLocator(), uniqueId: sLocator()));
}
