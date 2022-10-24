# Flutter Silo

**Requirement**

1. Flutter >=3.3.0
2. Dart >=2.18.0
3. Flutter Bloc >=8.1.0

## How to use this package:

### add silo library in pubspec.yaml

> https://github.com/enoraminc/flutter-silo

```dart
dependencies:
  flutter:
    sdk: flutter

  silo:
    path: ../flutter-silo/silo
```

### Create Silo Implementation Use Case using Template

> Template use case : https://github.com/enoraminc/flutter-silo/blob/master/silo/lib/implementation/template_use_case/template_impl.dart

> Example use case : https://github.com/enoraminc/flutter-silo/tree/master/example/lib/silo_implementation/example_use_case.dart

```dart
import 'package:silo/model/silo.dart';
import 'package:silo/silo.dart';

class TemplateSiloImpl extends Silo {
  @override
  Future<SiloPrepareResponseModel> prepare(
      SiloPrepareRequestModel siloReq) async {
    SiloPrepareResponseModel result = SiloPrepareResponseModel.empty();

    result = result.copyWith(
      status: true,
      data: siloReq.data,
    );
    return result;
  }

  @override
  Future<SiloExecuteResponseModel> execute(
      SiloExecuteRequestModel siloReq) async {
    SiloExecuteResponseModel result = SiloExecuteResponseModel.empty();

    result = result.copyWith(
      status: true,
      data: siloReq.data,
    );
    return result;
  }

  @override
  Future<SiloCloseResponseModel> close(SiloCloseRequestModel siloReq) async {
    SiloCloseResponseModel result = SiloCloseResponseModel.empty();

    result = result.copyWith(
      status: true,
      data: siloReq.data,
    );
    return result;
  }
}

```

### Create Silo Selector Implementation

> Example : https://github.com/enoraminc/flutter-silo/tree/master/example/lib/silo_implementation/example_use_case.dart

```dart
class SiloSelectorImpl extends SiloSelector {
  static SiloSelector instance() => SiloSelectorImpl();

  @override
  Silo? byType(String type) {
    Silo? silo;
    if (type == SiloTypeUtil.exampleUseCaseType) {
      silo = ExampleUseCaseSilo();
    }

    return silo;
  }
}

```



### Create Silo Dispatcher Bloc Provider

> Example : https://github.com/enoraminc/flutter-silo/blob/master/example/lib/main.dart

```dart

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

```



### Run Silo

> Example : https://github.com/enoraminc/flutter-silo/blob/master/example/lib/home.dart

```dart
  ExampleUseCaseModel data = ExampleUseCaseModel(
      id: DateTime.now().millisecondsSinceEpoch,
      ph: int.tryParse(phCtrl.text) ?? -1,
      pool: poolSelected,
    );

    context.read<SiloDispatcherBloc>().add(
          DispatchSiloEvent(
            dispatcher: SiloDispatcherModel(
              data: data.toMap(),
              type: SiloDispatcherModel.exampleUseCaseType,
            ),
          ),
        );
```