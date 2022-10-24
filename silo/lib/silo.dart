library silo;

import 'package:silo/model/silo.dart';

abstract class Silo {
  Future<SiloPrepareResponseModel> prepare(SiloPrepareRequestModel siloReq);
  Future<SiloExecuteResponseModel> execute(SiloExecuteRequestModel siloReq);
  Future<SiloCloseResponseModel> close(SiloCloseRequestModel siloReq);
}

