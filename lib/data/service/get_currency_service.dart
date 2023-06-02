import 'package:architecture_app/core/config/dio_config.dart';
import 'package:architecture_app/core/constants/project_urls.dart';
import 'package:architecture_app/data/model/currency_model.dart';
import 'package:dio/dio.dart';

class CurrencyService {
  Future<dynamic> getCurrency() async {
    try {
      Response response = await DioConfig.createRequest().get(ProjectUrls.url);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => CurrencyModel.fromJson(e))
            .toList();
      } else {
        return response.statusMessage.toString();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        return "Connection timeout";
      } else if (e.type == DioErrorType.receiveTimeout) {
        return "Receive timeout";
      } else if (e.type == DioErrorType.sendTimeout) {
        return "Send timeout";
      } else if (e.type == DioErrorType.unknown) {
        return "Unknown error";
      }
    }
  }
}
