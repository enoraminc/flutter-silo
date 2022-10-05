part of 'silo_dispatcher_bloc.dart';

@immutable
abstract class SiloDispatcherState {}

class SiloDispatcherInitial extends SiloDispatcherState {}

class DispatchSiloLoading extends SiloDispatcherState {}

class DispatchSiloSuccess extends SiloDispatcherState {
  final String message;
  final Map<String, dynamic> data;
  DispatchSiloSuccess({
    required this.message,
    required this.data,
  });
}

class DispatchSiloFailed extends SiloDispatcherState {
  final String message;
  DispatchSiloFailed({
    required this.message,
  });
}
