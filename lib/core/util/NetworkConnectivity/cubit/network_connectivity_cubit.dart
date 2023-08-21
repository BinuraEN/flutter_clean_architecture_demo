import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_connectivity_state.dart';

class NetworkConnectivityCubit extends Cubit<NetworkConnectivityState> {
  NetworkConnectivityCubit()
      : super(const NetworkConnectivityInitial(ConnectivityResult.none));
  StreamSubscription? _connectivityStreamSubscription;

  void checkConnection() {
    _connectivityStreamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        emit(NetworkConnectivitySuccess(result));
      } else {
        emit(NetworkConnectivityFailed(result, "No Internet Connection"));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
