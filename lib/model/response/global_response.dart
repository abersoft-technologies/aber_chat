import 'package:aberchat/model/response/result_response.dart';

class GlobalResponse {
  GlobalResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  GlobalResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
    result =
        json['result'] != null ? ResultResponse.fromJson(json['result']) : null;
  }

  int? statusCode;
  String? message;
  ResultResponse? result;

  GlobalResponse copyWith({
    int? statusCode,
    String? message,
    ResultResponse? result,
  }) =>
      GlobalResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}
