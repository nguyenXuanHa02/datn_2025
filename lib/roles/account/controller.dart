import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/page.dart';

enum AccountRole { guest, customer, staff, manager }

class AccountController extends BaseController {
  Map<String, dynamic> accountData = {};
  AccountRole currentRole = AccountRole.guest;
  @override
  void onInit() {
    loadAccount();
    loadOrder();

    super.onInit();
  }

  Future<void> loadAccount() async {
    final account = await getLocal('account');
    if (account?.isNotEmpty ?? false) {
      accountData = jsonDecode(account!);
      currentRole = AccountRole.values[accountData['role']];
      update();
    }
  }

  Map<String, dynamic> structAccount(int index) => {
        'role': index,
        'username': fields['username'],
        'password': fields['password']
      };
  // final Dio dio = DioClient().dio;

  Future<Map<String, dynamic>> _login(String username, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.data['status'] == 'success') {
        return {
          'success': true,
          'user': response.data['user'],
        };
      } else {
        return {
          'success': false,
          'message': 'Tài khoản hoặc mật khẩu không đúng',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data.toString() ?? e.message,
      };
    }
  }

  Future<Map<String, dynamic>> _register(
      String username, String password) async {
    try {
      final response = await DioClient().dio.post(
        '/register',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.data['staus'] == 'success') {
        return {
          'success': true,
          'message': 'Đăng ký thành công',
        };
      } else {
        return {
          'success': false,
          'message': 'Đăng ký thất bại',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data.toString() ?? e.message,
      };
    }
  }

  Future<void> dangNhap() async {
    error = {};
    require('username', message: 'Tên đăng nhập không được để trống');
    require('password', message: 'Mật khẩu không được để trống');
    if (!fieldError) {
      //todo: callapi
      showLoading();
      final response = await _login(fields['username'], fields['password']);
      if (response['user'] != null) {
        int rule = response['user']['rule'];
        accountData = structAccount(rule);
        saveLocal('account', jsonEncode(accountData));
        currentRole = AccountRole.values[rule];
        hireLoading();
        update();
      } else {
        hireLoading();
        showError('Tài khoản hoặc mật khẩu không chính xác');
      }
    } else {
      update();
    }
  }

  Future<void> dangKy() async {
    error = {};
    require('username', message: 'Tên đăng nhập không được để trống');
    require('password', message: 'Mật khẩu không được để trống');
    if (!fieldError) {
      //todo: callapi
      final response = await _register(fields['username'], fields['password']);
      if (response['success']) {
        accountData = structAccount(1);
        saveLocal('account', jsonEncode(accountData));
        currentRole = AccountRole.customer;
        hireLoading();
        update();
      } else {
        hireLoading();
        showError(response['message']);
      }
    } else {
      update();
    }
  }

  Future<void> dangXuat() async {
    showLoading();
    clearLocal('account');
    fields = {};
    await Future.delayed(1000.ms);
    hireLoading();
    currentRole = AccountRole.guest;
    update();
  }

  Future<void> loadOrder() async {
    final order = await getLocal(
      'order',
    );
    final context = Get.context;

    if (order is String && context != null) {
      final Map<String, dynamic> orderData = jsonDecode(order);
      // print(orderData);
      print(
          '${(orderData['orderData'] as Map).values.first['count'].runtimeType}');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CustomerHomeConfirmPage(
              data: orderData..addAll({'notAllowBack': false})),
        ),
      );
    }
  }
}
