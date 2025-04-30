import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/bloc_base.dart';

extension ScaffoldMessageU on ScaffoldMessengerState {
  void sendMessage(String text) {
    showSnackBar(SnackBar(content: Text(text)));
  }
}

class BaseController extends GetxController {
  Map<String, dynamic> fields = {};
  Map<String, dynamic> error = {};
  BaseStateEntry state = BaseStateEntry.init;
  List<Map<String, dynamic>> items = [];

  operator []=(String key, dynamic value) {
    fields[key] = value;
    update();
  }

  bool get isShowLoading => state == BaseStateEntry.loading;

  void showLoading() {
    state = BaseStateEntry.loading;
    update();
  }

  void hireLoading() {
    state = BaseStateEntry.init;
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
      fieldError = true;
    } else {
      error[key] = null;
      fieldError = false;
    }
  }

  bool fieldError = false;

// dynamic field(String key)=> fields[key];
}

Widget BaseScaffold<T extends BaseController>(Widget Function(T) scaffold,
        {T? init}) =>
    GetBuilder<T>(
      init: init,
      builder: (controller) => Stack(
        children: [
          Builder(builder: (context) {
            return GestureDetector(
                onTap: FocusScope.of(context).unfocus,
                child: scaffold(controller));
          }),
          if (controller.isShowLoading)
            Builder(builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              ).animate().fadeIn(duration: 250.ms);
            })
        ],
      ),
    );
