import 'package:connectivity_plus/connectivity_plus.dart';

// TODO: Change internet connection checker library
abstract class NetworkInfo {
  Stream<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Stream<bool> get isConnected => Connectivity()
      .onConnectivityChanged
      .map((event) => event != ConnectivityResult.none);
}
