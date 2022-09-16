import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/core/helpers/unique_id.dart';
import 'package:chatcalling/core/network/network_info.dart';
import 'package:chatcalling/core/user/data/datasources/user_local_datasource.dart';
import 'package:chatcalling/core/user/data/datasources/user_remote_datasource.dart';
import 'package:chatcalling/core/user/domain/repositories/user_repository.dart';
import 'package:chatcalling/core/user/domain/usecases/get_user_data.dart';
import 'package:chatcalling/features/messages/data/datasources/message_local_datasource.dart';
import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:chatcalling/features/messages/domain/repositories/message_repository.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_conversations.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_messages.dart';
import 'package:chatcalling/features/messages/domain/usecases/send_message.dart';
import 'package:chatcalling/features/messages/domain/usecases/update_read_status.dart';
import 'package:chatcalling/features/messages/presentation/utils/message_input_converter.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // CORE - User
  UserRepository,
  UserRemoteDatasource,
  UserLocalDatasource,
  GetUserData,

  // Features - Messages
  MessageRepository,
  MessageRemoteDatasource,
  MessageLocalDatasource,
  GetConversations,
  GetMessages,
  SendMessage,
  UpdateReadStatus,
  MessageInputConverter,

  // Core - Network
  NetworkInfo,

  // Core - Helpers
  Time,
  UniqueId,
])
void main() {}

// flutter pub run build_runner build --delete-conflicting-outputs 
