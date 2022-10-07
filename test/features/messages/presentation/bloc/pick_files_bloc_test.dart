import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/features/messages/presentation/bloc/pick_files_bloc.dart/pick_files_bloc.dart';
import 'package:chatcalling/features/messages/presentation/bloc/pick_files_bloc.dart/pick_files_event.dart';
import 'package:chatcalling/features/messages/presentation/bloc/pick_files_bloc.dart/pick_files_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PickFilesBloc imagePickerBloc;

  setUp(() {
    imagePickerBloc = PickFilesBloc();
  });

  test('Initial state should be empty', () {
    // Assert
    expect(imagePickerBloc.state, PickFilesState.initial());
  });

  blocTest<PickFilesBloc, PickFilesState>(
    'emits [pickedImagePathList] when multiple images are ',
    build: () => PickFilesBloc(),
    act: (bloc) => bloc.add(OnSelectMultipleImageEvent()),
    expect: () => [PickFilesState.initial().copyWith(pickedImageList: [])],
  );
}
