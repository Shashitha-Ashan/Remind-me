import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetStatus(status: ConnectionStatus.init));

  Future<void> checkInternet() async {
    final connStatus = await Connectivity().checkConnectivity();
    updateConnectivityStatus(connStatus);
  }

  void updateConnectivityStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      emit(InternetStatus(status: ConnectionStatus.disconnected));
    } else {
      emit(InternetStatus(status: ConnectionStatus.connected));
    }
  }

  late StreamSubscription _streamSubscription;
  void listenConnectionChanges() {
    _streamSubscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        updateConnectivityStatus(event);
      },
    );
  }

  void dispose() {
    _streamSubscription.cancel();
  }
}
