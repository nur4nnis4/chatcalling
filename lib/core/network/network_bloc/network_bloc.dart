import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/network/network_info.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final NetworkInfo networkInfo;
  NetworkBloc({required this.networkInfo}) : super(NetworkInitial()) {
    on<NetworkEvent>((event, emit) async {
      final connectionStatusStream =
          networkInfo.isConnected.asBroadcastStream();

      await emit.forEach(connectionStatusStream,
          onData: (bool isConnected) =>
              isConnected ? NetworkConnected() : NetworkInfoNotConnected());
    });
  }
}
