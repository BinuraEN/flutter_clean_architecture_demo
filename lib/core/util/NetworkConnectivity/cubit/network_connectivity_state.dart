part of 'network_connectivity_cubit.dart';

abstract class NetworkConnectivityState extends Equatable {
  final String? error;
  final ConnectivityResult? result;
  const NetworkConnectivityState({
    this.result,
    this.error,
  });

  @override
  List<Object> get props => [error!, result!];
}

class NetworkConnectivityInitial extends NetworkConnectivityState {
  const NetworkConnectivityInitial(ConnectivityResult result)
      : super(result: result);
}

class NetworkConnectivitySuccess extends NetworkConnectivityState {
  const NetworkConnectivitySuccess(ConnectivityResult result)
      : super(result: result);
}

class NetworkConnectivityFailed extends NetworkConnectivityState {
  const NetworkConnectivityFailed(ConnectivityResult result, String error)
      : super(result: result, error: error);
}
