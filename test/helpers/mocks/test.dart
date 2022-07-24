import 'package:chatcalling/core/network/network_info.dart';
import 'package:chatcalling/core/user/domain/repositories/user_repository.dart';
import 'package:chatcalling/features/messages/data/datasources/message_local_datasource.dart';
import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:chatcalling/features/messages/domain/repositories/message_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  UserRepository,
  MessageRepository,
  MessageRemoteDatasource,
  MessageLocalDatasource,
  NetworkInfo,
])
void main() {}

// flutter pub run build_runner build --delete-conflicting-outputs --build-filter 'test/helpers/mocks/test.dart'