// ignore_for_file: prefer_const_constructors

import 'package:ble_service/ble_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BleService', () {
    test('can be instantiated', () {
      expect(BleService(), isNotNull);
    });
  });
}
