import 'dart:convert';

import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/extensions/utils.dart';

class CustomerHomeController extends BaseController {
  @override
  void onInit() {
    // TODO: implement onInit
    loadCard();
    super.onInit();
  }

  Map<String, dynamic> card = {};
  Future<void> loadCard() async {
    final tempCard = await getLocal('card');
    if (tempCard != null) {
      card = jsonDecode(tempCard);
      update();
      print(tempCard + "loca");
    }
  }
}
