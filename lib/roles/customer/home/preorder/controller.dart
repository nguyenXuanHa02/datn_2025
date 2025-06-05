import 'dart:convert';

import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/theme.dart';
import 'package:kichikichi/roles/customer/home/controller.dart';

enum CustomerHomePreorderControllerState {
  start,
  thanhcong,
  thatbai,
  chitiet,
  capnhat
}

class CustomerHomePreorderController extends BaseController {
  CustomerHomePreorderControllerState showing =
      CustomerHomePreorderControllerState.start;

  @override
  void validate() {
    require('name');
    require('count');
    require('phone');
    require('pickupTime');
    update();
    super.validate();
  }

  @override
  void onInit() {
    loadCard();
    super.onInit();
  }

  Map<String, dynamic> card = {};

  Future<void> preorder() async {
    validate();
    if (!fieldError) {
      showLoading();
      try {
        final response =
            await DioClient().dio.post('/customer/preorder', data: {
          "customerName": fields['name'],
          "phoneNumber": fields['phone'],
          "numberOfGuests": fields['count'],
          "arrivalTime":
              DateTimeUtils.parse(fields['pickupTime']).toIso8601String(),
        });
        if (response.data['orderId'] != null) {
          card = {
            'code': '${response.data['orderId']}',
            'name': fields['name'],
            'phone': fields['phone'],
            'count': fields['count'],
            'pickupTime': fields['pickupTime'],
          };
          await saveLocal('card', jsonEncode(card));
          hireLoading();
          showing = CustomerHomePreorderControllerState.thanhcong;
          update();
        }
      } catch (e) {
        hireLoading();
        showing = CustomerHomePreorderControllerState.thatbai;
        update();
      }
    }
  }

  Future<void> loadCard() async {
    final tempCard = await getLocal('card');
    if (tempCard != null) {
      card = jsonDecode(tempCard);
      showing = CustomerHomePreorderControllerState.chitiet;

      fields['code'] = card['code'];
      fields['name'] = card['name'];
      fields['phone'] = card['phone'];
      fields['count'] = card['count'];
      fields['pickupTime'] = card['pickupTime'];
      update();
    }
  }

  void capnhat() {
    this['code'] = card['code'];
    this['name'] = card['name'];
    this['phone'] = card['phone'];
    this['count'] = card['count'];
    this['pickupTime'] = card['pickupTime'];
    showing = CustomerHomePreorderControllerState.capnhat;
    update();
  }

  void saveChangePreorder() {
    preorder();
    update();
  }

  Future<void> huyDatBan(Function() onFinish) async {
    //call api
    //clear
    await clearLocal('card');
    card = {};
    update();
    final check = Get.isRegistered<CustomerHomeController>();
    if (check) {
      Get.delete<CustomerHomeController>();
    }
    onFinish();
  }
}
