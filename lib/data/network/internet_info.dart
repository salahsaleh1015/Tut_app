import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetInfo{
   Future<bool> get isConnected;
}
class InternetInfoImpl implements InternetInfo{
 final  InternetConnectionChecker _internetConnectionChecker;

  InternetInfoImpl(this._internetConnectionChecker);

  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;

}