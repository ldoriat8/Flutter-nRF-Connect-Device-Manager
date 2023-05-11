import 'package:ble_service/src/ble_service_error.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as frb;
import 'package:rxdart/rxdart.dart';

/// {@template ble_service}
/// Package handles the scanninng for devices
/// {@endtemplate}
class BleService {
  /// {@macro ble_service}
  BleService() : _flutterReactiveBle = frb.FlutterReactiveBle();

  /// Inject dependencies for testing purposes
  @visibleForTesting
  BleService.withDependencies({
    required frb.FlutterReactiveBle flutterReactiveBle,
  }) : _flutterReactiveBle = flutterReactiveBle;

  final frb.FlutterReactiveBle _flutterReactiveBle;

  /// The selected device connected to
  @visibleForTesting
  NRFDevice? selectedDevice;

  Stream<NRFDevice> _scanForBleDevices() {
    final foundDevices = <String>{};
    return _flutterReactiveBle
        .scanForDevices(
          withServices: [],
        )
        .where((device) => !foundDevices.contains(device.id))
        .doOnData((device) {
          foundDevices.add(device.id);
        })
        .map(
          (device) => NRFDevice(
            identifier: device.id,
            displayName: device.name,
          ),
        );
  }

  /// scans for ble devices 
  Stream<NRFDevice> scan() {
    return _flutterReactiveBle.statusStream.debounce((event) {
      if (event == frb.BleStatus.unknown || event == frb.BleStatus.poweredOff) {
        return TimerStream(true, const Duration(seconds: 3));
      }
      return const Stream.empty();
    }).switchMap((event) {
      switch (event) {
        case frb.BleStatus.unknown:
          return Stream.error(
            HostBleGeneralException('Host BLE status unknown'),
          );
        case frb.BleStatus.unsupported:
          return Stream.error(
            HostBleGeneralException('Host does not support Bluetooth'),
          );
        case frb.BleStatus.unauthorized:
          return Stream.error(HostBleUnauthorizedException('BLE unauthorized'));
        case frb.BleStatus.poweredOff:
          return Stream.error(HostBleDisabledException('BLE Disabled'));
        case frb.BleStatus.locationServicesDisabled:
          return Stream.error(HostBleGeneralException('Host BLE disabled'));
        case frb.BleStatus.ready:
          return _scanForBleDevices();
      }
    });
  }
}

/// {@template NRF_device}
/// Represents a Nrf Device
/// {@endtemplate}
class NRFDevice extends Equatable {
  /// {@macro NRF_device}
  const NRFDevice({
    required this.identifier,
    required this.displayName,
  });

  /// Identifier used by the App to uniquely identify the Device
  final String identifier;

  /// Name shown to the user
  final String displayName;

  @override
  String toString() {
    return 'nrf(displayName: $displayName,'
        ' identifier: $identifier)';
  }

  @override
  List<Object> get props => [identifier, displayName];
}
