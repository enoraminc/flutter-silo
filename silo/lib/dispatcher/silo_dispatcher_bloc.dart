import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silo/model/silo.dart';

import 'package:silo/util/silo_selector.dart';

import '../model/silo_dispatcher.dart';
import '../silo.dart';
import '../util/log.dart';

part 'silo_dispatcher_event.dart';
part 'silo_dispatcher_state.dart';

class SiloDispatcherBloc
    extends Bloc<SiloDispatcherEvent, SiloDispatcherState> {
  SiloSelector siloSelector;

  SiloDispatcherBloc({
    required this.siloSelector,
  }) : super(SiloDispatcherInitial()) {
    on<DispatchSiloEvent>((event, emit) async {
      emit(DispatchSiloLoading());

      ///
      /// Predefine Silo based on Silo Dispatcher Type
      ///
      Log.setLog(
        "Silo Dispatcher Type : ${event.dispatcher.type}",
        method: "SiloDispatcherBloc.DispatchSiloEvent",
      );
      Silo? silo = siloSelector.byType(event.dispatcher.type);
      if (silo == null) {
        emit(DispatchSiloFailed(
          message: "Silo not found for ${event.dispatcher.type} Type",
        ));
        return;
      }

      Map<String, dynamic> data = event.dispatcher.data;

      ///
      /// Run Silo Prepare Code
      ///
      final siloPrepareReq = SiloPrepareRequestModel(data: data);

      final siloPrepareResponse = await silo.prepare(siloPrepareReq);

      if (!siloPrepareResponse.status) {
        Log.setLog(
          "Silo Prepare Failed : ${siloPrepareResponse.message}",
          method: "SiloDispatcherBloc.DispatchSiloEvent",
        );
        emit(DispatchSiloFailed(
          message: siloPrepareResponse.message,
        ));
        return;
      }

      data = siloPrepareResponse.data;

      ///
      /// Run Silo Execute Code
      ///
      final siloExecuteReq = SiloExecuteRequestModel(data: data);

      final siloExecuteResponse = await silo.execute(siloExecuteReq);

      if (!siloExecuteResponse.status) {
        Log.setLog(
          "Silo Execute Failed : ${siloExecuteResponse.message}",
          method: "SiloDispatcherBloc.DispatchSiloEvent",
        );
        emit(DispatchSiloFailed(
          message: siloExecuteResponse.message,
        ));
        return;
      }

      data = siloExecuteResponse.data;

      ///
      /// Run Silo Close Code
      ///
      final siloCloseReq = SiloCloseRequestModel(data: data);

      final siloCloseResponse = await silo.close(siloCloseReq);

      if (!siloCloseResponse.status) {
        Log.setLog(
          "Silo Close Failed : ${siloCloseResponse.message}",
          method: "SiloDispatcherBloc.DispatchSiloEvent",
        );
        emit(DispatchSiloFailed(
          message: siloCloseResponse.message,
        ));
        return;
      }

      ///
      /// Completed
      ///
      Log.setLog(
        "Silo Dispatch Completed: ${siloCloseResponse.message}",
        method: "SiloDispatcherBloc.DispatchSiloEvent",
      );
      emit(DispatchSiloSuccess(
        message: siloCloseResponse.message,
        data: siloCloseResponse.data,
      ));
    });
  }
}
