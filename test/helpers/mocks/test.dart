import 'package:chatcalling/core/common_features/attachment/domain/repositories/attachment_repository.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/get_friend_list.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/get_personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/search_user.dart';
import 'package:chatcalling/core/helpers/check_platform.dart';
import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/core/helpers/unique_id.dart';
import 'package:chatcalling/core/common_features/user/data/datasources/user_remote_datasource.dart';
import 'package:chatcalling/core/common_features/user/domain/repositories/user_repository.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/get_user_data.dart';
import 'package:chatcalling/core/common_features/attachment/data/datasources/attachment_local_datasource.dart';
import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:chatcalling/features/messages/domain/repositories/message_repository.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_conversations.dart';
import 'package:chatcalling/core/common_features/attachment/domain/usecases/get_lost_attachments.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_messages.dart';
import 'package:chatcalling/core/common_features/attachment/domain/usecases/pick_attachments.dart';
import 'package:chatcalling/features/messages/domain/usecases/send_message.dart';
import 'package:chatcalling/features/messages/domain/usecases/update_read_status.dart';
import 'package:chatcalling/features/messages/presentation/utils/message_input_converter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // CORE - Common_Features - User
  UserRepository,
  UserRemoteDatasource,
  GetUserData,
  SearchUser,
  GetFriendList,
  GetPersonalInformation,

  // CORE - Common_Features- Attachment
  AttachmentRepository,
  AttachmentLocalDatasource,
  GetLostAttachments,
  PickAttachments,

  // Features - Messages
  MessageRepository,
  MessageRemoteDatasource,
  GetConversations,
  GetMessages,
  SendMessage,
  UpdateReadStatus,

  MessageInputConverter,

  // Core - Helpers
  Time,
  UniqueId,
  CheckPlatform,

  // Plugins
  ImagePicker,
])
void main() {}

// flutter pub run build_runner build --delete-conflicting-outputs 
