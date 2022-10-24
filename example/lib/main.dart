import 'package:example/silo_selector/silo_selector_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silo/dispatcher/silo_dispatcher_bloc.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Silo Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<SiloDispatcherBloc>(
        create: (context) => SiloDispatcherBloc(
          siloSelector: SiloSelectorImpl.instance(),
        ),
        child: const HomeScreen(),
      ),
    );
  }
}
