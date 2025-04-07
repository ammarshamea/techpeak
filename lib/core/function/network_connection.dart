import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkConnection {
  Future<bool> get isConnected;
}
class NetworkConnectionImp implements NetworkConnection{
 final InternetConnectionChecker internetConnectionChecker;

 NetworkConnectionImp({required this.internetConnectionChecker});
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;

}