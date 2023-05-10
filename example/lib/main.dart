import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/bloc/nrf_service_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/view/home_page.dart';
import 'package:mcumgr_flutter_example/src/bloc/view/nrf_service_provider.dart';
import 'dart:async';

import 'package:mcumgr_flutter_example/src/device_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = "0.0.1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NrfServiceProvider(child: Homepage())
    );
  }
}
