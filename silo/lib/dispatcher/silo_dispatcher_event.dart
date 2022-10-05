part of 'silo_dispatcher_bloc.dart';

@immutable
abstract class SiloDispatcherEvent {}

class DispatchSiloEvent extends SiloDispatcherEvent {
  final SiloDispatcherModel dispatcher;
  DispatchSiloEvent({
    required this.dispatcher,
  });
}
