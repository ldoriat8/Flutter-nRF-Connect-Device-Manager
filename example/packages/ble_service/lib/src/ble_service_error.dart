import 'package:equatable/equatable.dart';

/// {@template hostBleException}
/// General Exception to signal problem with Bluetooth on the host device
/// {@endtemplate}
abstract class HostBleException implements Exception {
  /// {@macro hostBleException}
  HostBleException(this.message);

  /// Internal message suited for development purposes and debug output
  final String message;

  @override
  String toString() => message;
}

/// {@template hostBleUnauthorizedException}
/// Exception to signal that access to Bluetooth is not allowed on the
///  host device
/// {@endtemplate}
class HostBleUnauthorizedException extends HostBleException {
  /// {@macro hostBleUnauthorizedException}
  HostBleUnauthorizedException(super.message);
}

/// {@template hostBleDisabledException}
/// Exception to signal that Bluetooth is disabled on the host device
/// {@endtemplate}
class HostBleDisabledException extends HostBleException {
  /// {@macro hostBleDisabledException}
  HostBleDisabledException(super.message);
}

/// {@template hostBleGeneralException}
/// Exception to signal a general error on the host device that does not fit
///  any other Exception-class
/// {@endtemplate}
class HostBleGeneralException extends HostBleException {
  /// {@macro hostBleGeneralException}
  HostBleGeneralException(super.message);
}

/// Describes the kind of exception in more detail
enum NRFExceptionKind {
  /// Error decoding Data received from the NRF
  bleDecode,

  /// Emitted, when the track player on the NRF discarded the received
  /// player input event
  ///
  /// This occurs either if the ringbuffer is full or the input event was faulty
  playerInput,

  /// Error during data transfer via bluetooth
  bleTransfer,

  /// The service is not connected to any device.
  ///
  /// A connecten can be established by the `connect` method
  bleNoDevice,
}

/// {@template NRFServiceException}
/// Exception class to signal errors with the usage of the NRFe device
/// {@endtemplate}
class NRFException extends Equatable implements Exception {
  /// {@macro NRFServiceException}
  const NRFException({required this.kind, required this.message});

  /// Internal message suited for development purposes and debug output
  final String message;

  /// Describes the kind of error so it can be acted upon
  final NRFExceptionKind kind;

  @override
  String toString() => message;

  @override
  List<Object?> get props => [kind, message];
}
