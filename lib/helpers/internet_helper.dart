import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';


   Future<bool> get isInternet async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());

    DataConnectionChecker _connectionChecker = DataConnectionChecker();

    if (connectivityResult == ConnectivityResult.mobile) {
      if (await _connectionChecker.hasConnection) {
        return true;
      } else {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await _connectionChecker.hasConnection) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
