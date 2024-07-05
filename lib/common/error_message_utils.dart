  import 'package:dio/dio.dart';

String convertResponseErrorMessage(Map<String, dynamic> body) {
    String message = body['message'];
    return message;
  }

  String getErrorMessages(Object exception) {
    if (exception is DioException) {
      return handleError(exception);
    } else {
      return exception.toString();
    }
  }

  String handleError(DioException error) {
    final errorMessage = error.response?.data["message"];
    return errorMessage ??
        error.message ??
        "Telah Terjadi Kesalahan. Silahkan Coba Lagi";
  }