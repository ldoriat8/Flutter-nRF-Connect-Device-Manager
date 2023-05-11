part of 'nrf_service_bloc.dart';

@immutable
abstract class NrfServiceState extends Equatable {
  const NrfServiceState();

  @override
  List<Object?> get props => [];
}

class NrfServiceDeselected extends NrfServiceState {
  const NrfServiceDeselected();
}

class NrfServiceDiscovering extends NrfServiceState {
  const NrfServiceDiscovering({required this.discoveredDevices});

  final List<NRFDevice> discoveredDevices;

  @override
  List<Object?> get props => [discoveredDevices];
}

class NrfServiceError extends NrfServiceState {
  const NrfServiceError(this.exception);

  final Exception exception;

  @override
  List<Object?> get props => [exception];
}
