import 'package:ble_service/ble_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/bloc/nrf_service_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/view/nrf_service_builder.dart';

// Widget hintOrPlayer({required bool playInProgress}) {
//   return NrfServiceBuilder(builder: (context, state) {
//     return CircularProgressIndicator();
//   });
// }

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
          return Scaffold(
            appBar: AppBar(
              title: Text('Discover nearby Devices'),
            ),
            body: listDiscoveredDevices(
              state.discoveredDevices,
            ),
          );
        }

        void startBlitzbrilleDiscovery() {
          bloc.add(NrfServiceDiscoverDevices());
        }

        return Scaffold(
          body: ListView(
            primary: false,
            children: [
              AppBar(
                title: Text('Discovery'),
              ),
              Center(
                child: GestureDetector(
                  onTap: () => startBlitzbrilleDiscovery(),
                  child: Container(
                    color: Colors.amber,
                    height: 100,
                    width: 200,
                    child: Text('Start Discovery'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget listDiscoveredDevices(
  List<NRFDevices> devices,
) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: devices.isEmpty
          ? [const Center(child: Text('No Devices found'))]
          : [
              ...devices.map(
                (e) => ListTile(
                  title: Text(
                    e.displayName == '' ? 'N/a' : e.displayName,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CircularProgressIndicator(),
              SizedBox(
                height: 50,
              )
            ],
    ),
  );
}
