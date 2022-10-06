import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckConnection{
  static Future<bool> checkConnection() async {
    bool internetConnection = await InternetConnectionChecker().hasConnection;
    return internetConnection;
  }
}


// abstract class NetworkInfo {
//   Future<bool> get isConnected;
// }
//
// class NetworkInfoImpl implements NetworkInfo {
//   final InternetConnectionChecker connectionChecker;
//
//   NetworkInfoImpl({required this.connectionChecker});
//   @override
//   Future<bool> get isConnected async => await connectionChecker.hasConnection;
// }