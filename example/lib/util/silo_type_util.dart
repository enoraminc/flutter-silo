import 'package:silo/model/silo_dispatcher.dart';
import 'package:silo/silo.dart';

class SiloTypeUtil {
  static String exampleUseCaseType = "ExampleUseCase";

  bool isExampleUseCaseType(SiloDispatcherModel? silo) =>
      silo?.type == exampleUseCaseType;
}
