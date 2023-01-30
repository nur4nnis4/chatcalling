import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Stream<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  @override
  Stream<bool> get isConnected => connectivity.onConnectivityChanged
      .map((event) => event != ConnectivityResult.none);
}
