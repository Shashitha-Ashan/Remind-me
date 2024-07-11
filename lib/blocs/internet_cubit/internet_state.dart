part of 'internet_cubit.dart';

@immutable
sealed class InternetState {}

enum ConnectionStatus { connected, disconnected, init }

final class InternetStatus extends InternetState {
  final ConnectionStatus status;
  InternetStatus({required this.status});
}
