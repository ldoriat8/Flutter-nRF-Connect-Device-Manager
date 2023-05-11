import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/nrf_service_bloc/nrf_service_bloc.dart';


class NrfServiceBuilder
    extends BlocBuilder<NrfServiceBloc, NrfServiceState> {
  NrfServiceBuilder({
    required Widget Function(BuildContext context, NrfServiceState state)
        builder,
    super.key,
  }) : super(builder: (context, state) => builder(context, state));
}