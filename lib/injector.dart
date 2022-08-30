import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/core/helpers/unique_id.dart';
import 'package:chatcalling/core/network/network_info.dart';
import 'package:chatcalling/core/user/data/datasources/user_local_datasource.dart';
import 'package:chatcalling/core/user/data/datasources/user_remote_datasource.dart';
import 'package:chatcalling/core/user/data/repositories/user_repository_impl.dart';
import 'package:chatcalling/core/user/domain/repositories/user_repository.dart';
import 'package:chatcalling/core/user/domain/usecases/get_user_data.dart';
import 'package:chatcalling/core/user/presentation/bloc/bloc/user_bloc.dart';
import 'package:chatcalling/features/messages/data/datasources/message_local_datasource.dart';
import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:chatcalling/features/messages/data/repositories/message_repository_impl.dart';
import 'package:chatcalling/features/messages/domain/repositories/message_repository.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_conversations.dart';
import 'package:chatcalling/features/messages/domain/usecases/send_message.dart';
import 'package:chatcalling/features/messages/domain/usecases/update_read_status.dart';
import 'package:chatcalling/features/messages/presentation/bloc/messages_bloc.dart';
import 'package:chatcalling/features/messages/presentation/utils/message_input_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/messages/domain/usecases/get_messages.dart';

final sLocator = GetIt.instance;

void init() {
  // FEATURES
  initMessage();

  // CORE - Network
  sLocator
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sLocator()));

  // CORE - User
  initUser();

  // Core - Helpers
  sLocator.registerLazySingleton<UniqueId>(() => UniqueIdImpl());
  sLocator.registerLazySingleton<Time>(() => TimeImpl());

  // EXTERNAL
  sLocator.registerLazySingleton(() => InternetConnectionChecker());
  sLocator.registerSingleton(() => FirebaseFirestore.instance);
}

void initMessage() {
  // Bloc
  sLocator.registerFactory(
    () => MessagesBloc(
      getConversations: sLocator(),
      getMessages: sLocator(),
      sendMessage: sLocator(),
      updateReadStatus: sLocator(),
      messageInputConverter: sLocator(),
    ),
  );

  // Use cases
  sLocator.registerLazySingleton(() => GetMessages(sLocator()));
  sLocator.registerLazySingleton(() => GetConversations(sLocator()));
  sLocator.registerLazySingleton(() => SendMessage(sLocator()));
  sLocator.registerLazySingleton(() => UpdateReadStatus(sLocator()));

  // Repository
  sLocator.registerLazySingleton<MessageRepository>(() => MessageRepositoryImpl(
      messageLocalDatasource: sLocator(),
      messageRemoteDatasource: sLocator(),
      networkInfo: sLocator()));

  // Data sources
  sLocator.registerLazySingleton<MessageRemoteDatasource>(
      () => MessageRemoteDatasourceImpl(sLocator()));
  sLocator.registerLazySingleton<MessageLocalDatasource>(
      () => MessageLocalDatasourceImpl());

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
  sLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userLocalDatasource: sLocator(),
      userRemoteDatasource: sLocator(),
      networkInfo: sLocator()));

  // Data sources
  sLocator.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(sLocator()));
  sLocator.registerLazySingleton<UserLocalDatasource>(
      () => UserLocalDatasourceImpl());
}
