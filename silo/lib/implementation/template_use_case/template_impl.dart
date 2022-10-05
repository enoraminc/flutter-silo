import 'package:lumbung_common/base/base_repository.dart';
import 'package:silo/implementation/example_use_case/example_use_case_model.dart';
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
