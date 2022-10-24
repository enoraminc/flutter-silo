import 'package:example/util/silo_type_util.dart';
import 'package:silo/silo.dart';
import 'package:silo/util/silo_selector.dart';

import '../silo_implementation/example_use_case/example_use_case_impl.dart';

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
