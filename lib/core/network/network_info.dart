import 'package:internet_connection_checker/internet_connection_checker.dart';


// TODO: NO need internet connection checker
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected => InternetConnectionChecker().hasConnection;
}
