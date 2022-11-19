import 'core/common_features/attachment/data/datasources/attachment_local_datasource.dart';
import 'core/common_features/attachment/data/repositories/attachment_repository_impl.dart';
import 'core/common_features/attachment/domain/repositories/attachment_repository.dart';
import 'core/common_features/attachment/domain/usecases/get_lost_attachments.dart';
import 'core/common_features/attachment/domain/usecases/pick_attachments.dart';
import 'core/common_features/attachment/presentations/bloc/pick_attachments_bloc.dart';
import 'core/helpers/check_platform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'core/helpers/time.dart';
import 'core/helpers/unique_id.dart';
import 'core/common_features/user/data/datasources/user_remote_datasource.dart';
import 'core/common_features/user/data/repositories/user_repository_impl.dart';
import 'core/common_features/user/domain/repositories/user_repository.dart';
import 'core/common_features/user/domain/usecases/get_user_data.dart';
import 'core/common_features/user/presentation/bloc/user_bloc.dart';
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

  sLocator.registerLazySingleton(() => ImagePicker());
}

void initAttachment() {
  // Bloc
  sLocator.registerFactory(() => PickAttachmentsBloc(
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
  sLocator.registerFactory(() =>
      MessageListBloc(getMessages: sLocator(), updateReadStatus: sLocator()));
  sLocator.registerFactory(
      () => ConversationListBloc(getConversations: sLocator()));
  sLocator.registerFactory(() => SendMessageBloc(
      sendMessage: sLocator(), messageInputConverter: sLocator()));

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
  sLocator.registerLazySingleton(() => UserBloc(getUserData: sLocator()));

  // Use cases
  sLocator.registerLazySingleton(() => GetUserData(sLocator()));

  // Repository
  sLocator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDatasource: sLocator()));

  // Data sources
  sLocator.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(sLocator()));
}
