import 'package:silo/model/silo_dispatcher.dart';
import 'package:silo/silo.dart';

abstract class SiloSelector {
  Silo? byType(String type);
}
