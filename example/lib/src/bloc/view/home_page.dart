import 'package:ble_service/ble_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/bloc/nrf_service_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/view/nrf_service_builder.dart';
import 'package:mcumgr_flutter_example/src/bloc/widgets/discovered_devices_widget.dart';
import 'package:mcumgr_flutter_example/src/bloc/widgets/enable_discovery_widget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  Widget hintOrPlayer({required bool playInProgress}) {
    return NrfServiceBuilder(builder: (context, state) {
      return CircularProgressIndicator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NrfServiceBuilder(
      builder: (context, state) {
        final bloc = BlocProvider.of<NrfServiceBloc>(context);

        if (state is NrfServiceDiscovering) {
          return DiscoveredDevices(devices: state.discoveredDevices);
        }

        void startBlitzbrilleDiscovery() {
          bloc.add(NrfServiceDiscoverDevices());
        }

        return EnableDiscrovery(
          onTap: () => startBlitzbrilleDiscovery(),
        );
      },
    );
  }
}
