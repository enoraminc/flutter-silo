import 'package:lumbung_common/base/base_repository.dart';
import 'package:silo/implementation/example_use_case/example_use_case_model.dart';
import 'package:silo/model/silo.dart';
import 'package:silo/silo.dart';

class ExampleUseCaseSilo extends Silo with BaseRepository {
  final String url = "https://lumbunghedera-test.et.r.appspot.com/_api/hedera";
  final String topicId = ExampleUseCaseModel.topicId;

  @override
  Future<SiloPrepareResponseModel> prepare(
      SiloPrepareRequestModel siloReq) async {
    SiloPrepareResponseModel result = SiloPrepareResponseModel.empty();

    // Convert Req Data to Model
    ExampleUseCaseModel data = ExampleUseCaseModel.fromMap(siloReq.data);

    await Future.delayed(const Duration(milliseconds: 200));

    // Validation
    if (data.pool.isEmpty) {
      result = result.copyWith(
        status: false,
        message: "Pool cant be empty",
      );
      return result;
    }
    if (data.ph < 0 || data.ph > 14) {
      result = result.copyWith(
        status: false,
        message: "PH is not valid",
      );
      return result;
    }

    // Validated
    result = result.copyWith(
      status: true,
      message: "Silo Prepare Completed",
      data: siloReq.data,
    );
    return result;
  }

  @override
  Future<SiloExecuteResponseModel> execute(
      SiloExecuteRequestModel siloReq) async {
    SiloExecuteResponseModel result = SiloExecuteResponseModel.empty();

    // Convert Req Data to Model
    ExampleUseCaseModel data = ExampleUseCaseModel.fromMap(siloReq.data);

    try {
      await request(
        '$url/consensus/message/submit',
        RequestType.post,
        body: {
          "id": topicId,
          "message": data.toJson(),
        },
      );

      // Success
      result = result.copyWith(
        status: true,
        message: "Data submitted succesfully",
        data: siloReq.data,
      );
      return result;
    } catch (e, s) {
      print("==error $e $s");
      result = result.copyWith(
        status: false,
        message: e.toString(),
      );
      return result;
    }
  }

  @override
  Future<SiloCloseResponseModel> close(SiloCloseRequestModel siloReq) async {
    SiloCloseResponseModel result = SiloCloseResponseModel.empty();

    await Future.delayed(const Duration(milliseconds: 200));

    // There is nothing implementation in close silo, skip this function
    result = result.copyWith(
      status: true,
      message: "Data Submitted to Hedera Concensus Succesfully",
      data: siloReq.data,
    );
    return result;
  }
}
