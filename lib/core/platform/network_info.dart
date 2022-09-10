import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> isConnected() async {
    // verificando conexão

    // final ping = await InternetAddress.lookup('https://www.google.com.br/');
    var connectivityResult = await (Connectivity().checkConnectivity());
    // final bool pingResult = (ping.isNotEmpty && ping[0].rawAddress.isNotEmpty);
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
      // I am connected to a wifi network.
    }
    return false;
  }
}
