import 'package:ble_service/ble_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/bloc/nrf_service_bloc.dart';

class NrfServiceProvider extends StatelessWidget {
  const NrfServiceProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NrfServiceBloc(
        nrfService: BleService(),
      ),
      child: child,
    );
  }
}