import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/bloc_base.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://kichi.onrender.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Interceptor (log, token, v.v.)
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  void setMultipartHeaders() {
    dio.options.headers['Content-Type'] = 'multipart/form-data';
  }

  /// Khôi phục header về JSON nếu cần
  void setJsonHeaders() {
    dio.options.headers['Content-Type'] = 'application/json';
  }
}

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
  final Dio dio = DioClient().dio;

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

  Future<void> showError(String? message, {Duration? time}) async {
    error['message'] = message;
    update();
    await Future.delayed(
      time ?? 1001.ms,
      () {
        error['message'] = null;
        update();
      },
    );
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
        {T? init, bool showLoading = true}) =>
    GetBuilder<T>(
      init: init,
      builder: (controller) => Stack(
        children: [
          Builder(builder: (context) {
            return GestureDetector(
                onTap: FocusScope.of(context).unfocus,
                child: scaffold(controller));
          }),
          if (controller.isShowLoading && showLoading)
            Builder(builder: (context) {
              return Container(
                color: AppColors.warning.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(),
                ).animate().fadeIn(duration: 250.ms),
              );
            }),
          if ((controller.error['message'] != null))
            Builder(
              builder: (context) {
                return IntrinsicHeight(
                  child: Card(
                    child: Text(
                      '${controller.error['message']}',
                      style: AppTextStyles.error,
                    ),
                  ).safePad().animate().fadeOut(delay: 1000.ms),
                );
              },
            )
        ],
      ),
    );
