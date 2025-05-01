import 'dart:convert';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/extensions/utils.dart';

enum AccountRole { guest, customer, staff, manager }

class AccountController extends BaseController {
  Map<String, dynamic> accountData = {};
  AccountRole currentRole = AccountRole.guest;
  Map<String, dynamic> structAccount() => {
        'role': AccountRole.guest.index,
        'username': fields['username'],
        'password': fields['password']
      };

  Future<void> dangNhap() async {
    error = {};
    require('username', message: 'Tên đăng nhập không được để trống');
    require('password', message: 'Mật khẩu không được để trống');
    if (!fieldError) {
      //todo: callapi
      showLoading();
      await Future.delayed(1000.ms);
      hireLoading();

      accountData = structAccount();
      saveLocal('account', jsonEncode(accountData));
      currentRole = AccountRole.customer;
      update();
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
      showLoading();
      await Future.delayed(1000.ms);
      hireLoading();
      currentRole = AccountRole.customer;
      update();
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
}
