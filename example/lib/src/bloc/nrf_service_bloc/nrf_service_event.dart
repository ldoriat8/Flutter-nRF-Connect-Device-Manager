part of 'nrf_service_bloc.dart';


@immutable
abstract class NrfServiceEvent extends Equatable {
  const NrfServiceEvent();

  @override
  List<Object?> get props => [];
}

class NrfServiceDiscoverDevices extends NrfServiceEvent {}

class NrfServiceAbortDiscovery extends NrfServiceEvent {}

class _NrfServiceDeviceFound extends NrfServiceEvent {
  const _NrfServiceDeviceFound({required this.device});

  final NRFDevices device;
}

class NrfServiceSelectDevice extends NrfServiceEvent {
  const NrfServiceSelectDevice({required this.device});

  final NRFDevices device;
}

class _NrfServiceEncounterError extends NrfServiceEvent {
  const _NrfServiceEncounterError(this.exception);

  final Exception exception;
}
