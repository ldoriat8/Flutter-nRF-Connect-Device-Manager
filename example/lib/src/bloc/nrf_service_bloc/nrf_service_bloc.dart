import 'dart:async';

import 'package:ble_service/ble_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'nrf_service_event.dart';
part 'nrf_service_state.dart';

class NrfServiceBloc extends Bloc<NrfServiceEvent, NrfServiceState> {
  NrfServiceBloc({required BleService nrfService})
      : _service = nrfService,
        super(const NrfServiceDeselected()) {
    on<NrfServiceDiscoverDevices>(_onNrfServiceDiscoverDevices);
    on<_NrfServiceDeviceFound>(_onNrfServiceDeviceFound);
    on<_NrfServiceEncounterError>(_onNrfServiceEncounterError);
  }

  final BleService _service;
  StreamSubscription<NRFDevice>? _scanSubscription;

  Future<void> _cancelStreams() async {
    await _scanSubscription?.cancel();
  }

  Future<void> _onNrfServiceDiscoverDevices(
    NrfServiceDiscoverDevices event,
    Emitter<NrfServiceState> emit,
  ) async {
    if (state is! NrfServiceDeselected) {
      return;
    }

    emit(const NrfServiceDiscovering(discoveredDevices: []));

    _scanSubscription = _service.scan().listen(
          (device) {
            add(_NrfServiceDeviceFound(device: device));
          },
          cancelOnError: true,
          onError: (dynamic e) {
            if (e is Exception) {
              add(_NrfServiceEncounterError(e));
            } else {
              add(_NrfServiceEncounterError(Exception(e)));
            }
          },
        );
  }

  void _onNrfServiceDeviceFound(
    _NrfServiceDeviceFound event,
    Emitter<NrfServiceState> emit,
  ) {
    if (state is NrfServiceDiscovering) {
      final discoveringState = state as NrfServiceDiscovering;

      emit(
        NrfServiceDiscovering(
          discoveredDevices: [
            ...discoveringState.discoveredDevices,
            event.device,
          ],
        ),
      );
    }
  }

  Future<void> _onNrfServiceEncounterError(
    _NrfServiceEncounterError event,
    Emitter<NrfServiceState> emit,
  ) async {
    await _cancelStreams();

    final exception = event.exception;
    emit(NrfServiceError(exception));
  }
}
