import 'package:silo/model/silo_dispatcher.dart';
import 'package:silo/silo.dart';

import '../implementation/example_use_case/example_use_case_impl.dart';

class SiloSelector {
  static Silo? byType(String type) {
    Silo? silo;
    if (type == SiloDispatcherModel.exampleUseCaseType) {
      silo = ExampleUseCaseSilo();
    }

    return silo;
  }
}
