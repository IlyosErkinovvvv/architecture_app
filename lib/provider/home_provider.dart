import 'package:architecture_app/data/model/currency_model.dart';
import 'package:architecture_app/data/repository/get_currency_repository.dart';
import 'package:architecture_app/helpers/show_message_helper.dart';
import 'package:hive/hive.dart';

class HomeProvider {
  HomeProvider() {
    getCurrency();
  }

  bool isLoading = false;
  String errorMessage = "";
  void getCurrency() async {
    isLoading = true;
    return await CurrencyRepository.getRepository().then((data) {
      if (data is Box<CurrencyModel>) {
        isLoading = false;
        // notifyListener();
      } else {
        isLoading = false;
        errorMessage = data;
        showMessageHelper(data);
      }
    });
  }
}
