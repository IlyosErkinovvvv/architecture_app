import 'dart:io';
import 'package:hive/hive.dart';
import 'package:architecture_app/data/model/currency_model.dart';
import 'package:architecture_app/data/service/get_currency_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class CurrencyRepository {
  static Box<CurrencyModel>? currencyBox;
  static CurrencyService currencyService = CurrencyService();

  static Future<dynamic> getRepository() async {
    return await currencyService.getCurrency().then((dynamic response) async {
      if (response is List<CurrencyModel>) {
        await openBox();
        await putToBox(response);
        if (response.isEmpty) {
          return "Currency ma'lumotlari hali qoshilmagan";
        } else {
          return currencyBox;
        }
      } else {
        return response;
      }
    });
  }

  static Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    currencyBox = await Hive.openBox("currencyBox");
  }

  Future<void> registerAdapters() async {
    Hive.registerAdapter(CurrencyModelAdapter());
  }

  static Future<void> putToBox(List<CurrencyModel> users) async {
    await currencyBox!.clear();
    for (int i = 0; i < users.length; i++) {
      await currencyBox!.add(users[i]);
    }
  }
}
