import 'dart:convert';

import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/extensions/utils.dart';

class CustomerHomeController extends BaseController {
  @override
  void onInit() {
    // TODO: implement onInit
    loadCard();
    fetchMenuAsMap();
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

  Future<void> fetchMenuAsMap() async {
    try {
      final response = await dio.get('/menu');

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List data = response.data['data'];
        items = List<Map<String, dynamic>>.from(data);
        update();
      } else {
        throw Exception('Không thể tải menu');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải menu: $e');
    }
  }
}
