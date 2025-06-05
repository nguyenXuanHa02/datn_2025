import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/extensions/utils.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/success/page.dart';

enum CustomerHomeOrderConfirmState {
  start,
  thanhToanStart,
  thanhToanThatBai,
  thanhToanThanhCong,
  goiThemMonStart,
  goiThemMonEnd,
  goiNhanVienThanhCong
}

class CustomerHomeOrderConfirmController extends BaseController {
  final Map<String, dynamic> oderStartData;
  final Map tableData;
  CustomerHomeOrderConfirmState showing = CustomerHomeOrderConfirmState.start;
  final bool? canPop;
  num paid = 0;
  Map<String, int> counter = {};
  Map<String, dynamic> orderMore = {};
  int money = 0;
  String currentOrderId = '';
  BuildContext context;
  CustomerHomeOrderConfirmController(
    this.context, {
    this.canPop,
    required this.oderStartData,
    required this.tableData,
  });
  @override
  void onInit() {
    fetchMenuAsMap();
    loadOrdered(context);
    _startCountdown();
    super.onInit();
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

  Future<void> order(
      {required Function() onSuccess, required Function() onFail}) async {
    try {
      showLoading();
      final response = await dio.post(
        '/order',
        data: {
          'tableNumber': tableData['table_code'],
          'items': oderStartData.values.toList(),
        },
      );
      hireLoading();
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final orderId = response.data['orderId'];
        currentOrderId = orderId;
        showing = CustomerHomeOrderConfirmState.start;
        saveLocal('orderId', currentOrderId);
        update();
        onSuccess();
      } else {
        onFail();
      }
    } catch (e) {
      print('❌ Error placing order: $e');
      // TODO: show error to user
    }
  }

  Future<Map?> payOrder({
    required String orderId,
    required int amount,
    required String description,
  }) async {
    try {
      final response = await DioClient().dio.post('/pay', data: {
        'orderId': orderId,
        'amount': amount,
        'description': description,
      });

      if (response.statusCode == 200 && response.data['paymentUrl'] != null) {
        paymentUrl = response.data['paymentUrl'];
        return response.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print('Pay error: ${e.response?.data ?? e.message}');
      return null;
    }
  }

  int getSoTienCanPay() {
    int t = 0;
    oderStartData.values.forEach(
      (element) {
        t += int.parse(element['count'].toString()) *
            int.parse(element['price'].toString());
      },
    );
    return t;
  }

  String orderId = '';
  String paymentUrl = '';

  bool showHuyMon = false;

  late Timer _timer;
  Duration remaining = Duration.zero;
  final DateTime pastTime = DateTime.now()
      .subtract(Duration(minutes: 3)); // 🕒 Ví dụ: mốc 3 phút trước

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final endTime = pastTime.add(Duration(minutes: 5));
      final now = DateTime.now();
      final diff = endTime.difference(now);
      remaining = diff.isNegative ? Duration.zero : diff;
      update();
      if (diff.isNegative) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> thanhToan(
      {required Function() onSuccess, required Function() onFail}) async {
    showLoading();
    paid = getSoTienCanPay();
    final now = DateTime.now();
    orderId =
        '${paid}${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}';
    final res = await payOrder(
        orderId: orderId,
        amount: paid.toInt(),
        description: 'thanh toan hoa don ban ${tableData['table_code']}');
    hireLoading();
    paymentUrl = res?['paymentUrl'];
    if (paymentUrl.isNotEmpty) {
      showing = CustomerHomeOrderConfirmState.thanhToanStart;
    }
    update();
    onSuccess();
  }

  Future<void> confirmHuyOrder() async {
    try {
      showLoading();
      await saveLocal(
          'order',
          jsonEncode({
            'table': (tableData),
            'orderData': oderStartData,
            'total': getSoTienCanPay()
          }));
      final response = await dio.post(
        '/order/update',
        data: {
          'orderId': currentOrderId,
          'items': oderStartData.values.toList(),
        },
      );
      hireLoading();
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final orderId = response.data['orderId'];
        // currentOrderId = orderId;
        showing = CustomerHomeOrderConfirmState.start;
        update();
        if (Get.context != null)
          ScaffoldMessenger.of(Get.context!).sendMessage('Hủy món thành công');
      }
    } catch (e) {
      hireLoading();
      if (Get.context != null)
        ScaffoldMessenger.of(Get.context!).sendMessage(
            'Hủy món thất bại! Vui lòng liên hệ nhân viên để được hỗ trợ');

      print('❌ Error placing order: $e');
      // TODO: show error to user
    }
  }

  Future<void> orderMoreStart() async {
    //todo:gop order more vao order data

    for (var key in orderMore.keys) {
      final count = orderMore[key]['count'];
      if (oderStartData[key] != null) {
        oderStartData[key]['count'] =
            '${int.parse('$count') + int.parse('${oderStartData[key]['count']}')}';
      } else {
        oderStartData[key] = orderMore[key];
      }
      oderStartData[key]['order_time'] = orderMore[key]['order_time'];
    }
    //todo:cap nhat don order vao csdl
    try {
      showLoading();
      await saveLocal(
          'order',
          jsonEncode({
            'table': (tableData),
            'orderData': oderStartData,
            'total': getSoTienCanPay()
          }));
      final response = await dio.post(
        '/order/update',
        data: {
          'orderId': currentOrderId,
          'items': oderStartData.values.toList(),
        },
      );
      hireLoading();
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final orderId = response.data['orderId'];
        // currentOrderId = orderId;
        showing = CustomerHomeOrderConfirmState.start;
        update();
      } else {}
    } catch (e) {
      print('❌ Error placing order: $e');
      // TODO: show error to user
    }
    //todo:quay ve start
    money = 0;
    orderMore = {};
    showing = CustomerHomeOrderConfirmState.start;
    update();
  }

  Future<void> pay() async {}

  Future<void> contactStaff() async {
    //todo: send notification then navigate to screen
    showing = CustomerHomeOrderConfirmState.goiNhanVienThanhCong;
    update();
  }

  Future<void> updateOrderPaymentStatus(bool isOnlinePaid) async {
    try {
      if (orderId.isEmpty) {
        return;
      }
      final call = await dio.post('/order/status', data: {
        'orderId': currentOrderId,
        'status': isOnlinePaid ? 'onlinePaid' : 'needStaff'
      });
    } catch (e) {
      print("error on 175 confirm Controller");
    }
  }

  Future<void> onPayResult(Map map) async {
    showLoading();
    if (map['status'] == 'success') {
      await updateOrderPaymentStatus(true);
      showing = CustomerHomeOrderConfirmState.thanhToanThanhCong;
      clearLocal('order');
      update();
    } else {
      await updateOrderPaymentStatus(false);
      showing = CustomerHomeOrderConfirmState.thanhToanThatBai;
      update();
    }
    hireLoading();
  }

  void cancelPayment() {
    paymentUrl = '';
    showing = CustomerHomeOrderConfirmState.start;
    update();
  }

  Future<void> loadOrdered(BuildContext context) async {
    final loadOrderedId = await getLocal('orderId');
    if (loadOrderedId != null && context.mounted) {
      currentOrderId = loadOrderedId;
      update();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerHomeOrderConfirmSuccessPage(
            canPop: canPop,
          ),
        ),
        // (route) => false,
      );
    }
  }

  void moneyPay() {
    showing = CustomerHomeOrderConfirmState.goiNhanVienThanhCong;
    update();
  }
}
