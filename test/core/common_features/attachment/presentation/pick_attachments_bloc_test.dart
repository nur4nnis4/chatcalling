import 'package:chatcalling/core/common_features/attachment/presentations/bloc/pick_attachments_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockPickAttachments mockPickAttachments;
  late MockGetLostAttachments mockGetLostAttachments;
  late PickAttachmentsBloc pickAttachmentsBloc;

  setUp(() {
    mockPickAttachments = MockPickAttachments();
    mockGetLostAttachments = MockGetLostAttachments();
    pickAttachmentsBloc = PickAttachmentsBloc(
        pickAttachments: mockPickAttachments,
        getLostAttachments: mockGetLostAttachments);
  });
}
