import 'package:silo/model/silo.dart';
import 'package:silo/silo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'example_use_case_model.dart';

class ExampleUseCaseSilo extends Silo {
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
      final uri = Uri.parse('$url/consensus/message/submit');

      final body = {
        "id": topicId,
        "message": data.toJson(),
      };

      String? stringBody = json.encode(body);

      http.Response response = await http.post(
        uri,
        body: stringBody,
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // Log.setLog("Data : ${result.toString()} ", method: "BaseRepository");

        if (responseBody["status"] == false) {
          throw Exception(responseBody["message"]);
        } else {
          // Success
          result = result.copyWith(
            status: true,
            message: "Data submitted succesfully",
            data: siloReq.data,
          );
          return result;
        }
      } else if (response.statusCode == 401) {
        final responseBody = json.decode(response.body);

        String message = responseBody["message"] ??
            "Something wrong with server : ${response.statusCode}";
        throw Exception(message);
      } else {
        String message =
            "${response.statusCode} : Something wrong with server ";
        throw Exception(message);
      }
    } catch (e, s) {
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
