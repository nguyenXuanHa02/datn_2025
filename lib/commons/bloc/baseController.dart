import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/bloc_base.dart';

class BaseController extends GetxController {
  Map<String, dynamic> fields = {};
  Map<String, dynamic> error = {};
  BaseStateEntry state = BaseStateEntry.init;
  List<Map<String, dynamic>> items = [];

  operator []=(String key, dynamic value) {
    fields[key] = value;
    update();
  }

  void validate() {
    update();
  }

  Future<void> submit() async {
    validate();
    if (error.values.every(
      (element) => element == null || element == '',
    )) {}
  }

  void require(String key, {String? message}) {
    if (fields[key] == null || fields[key] == '') {
      error[key] = message ?? 'Trường không được bỏ trống';
    } else {
      error[key] = null;
    }
  }

// dynamic field(String key)=> fields[key];
}
