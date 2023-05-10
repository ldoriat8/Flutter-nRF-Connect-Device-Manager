import 'package:ble_service/ble_service.dart';
import 'package:flutter/material.dart';

class DiscoveredDevices extends StatelessWidget {
  const DiscoveredDevices({required this.devices, super.key});
  final List<NRFDevices> devices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover nearby Devices'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: devices.isEmpty
                    ? [
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 200),
                            child: Column(
                              children: [
                                Text(
                                  'No Devices found',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[700]),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Icon(
                                  Icons.bluetooth_disabled_rounded,
                                  size: 80,
                                  color: Colors.grey[700],
                                )
                              ],
                            ),
                          ),
                        ),
                      ]
                    : [
                        ...devices.map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              )),
                            ),
                            child: ListTile(
                              dense: false,
                              leading: Icon(Icons.bluetooth),
                              title: Text(
                                e.displayName == '' ? 'n/a' : e.displayName,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                e.identifier,
                              ),
                              onTap: () {},
                            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
