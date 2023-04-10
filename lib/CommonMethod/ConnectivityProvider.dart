import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class ConnectivityProvider with ChangeNotifier{
  late bool _isOnline=false;
  bool get isOnline=>_isOnline;

  ConnectivityProvider(){
    Connectivity _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((result) {
      if(result== ConnectivityResult.none){
        _isOnline=false;
        notifyListeners();
      }else{
        _isOnline=true;
        notifyListeners();
      }
    });

  }

}