import 'package:dio/dio.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';

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
  final Map<int, dynamic> oderStartData;
  final Map tableData;
  CustomerHomeOrderConfirmState showing = CustomerHomeOrderConfirmState.start;

  num paid = 0;
  Map<int, int> counter = {};
  Map<int, dynamic> orderMore = {};
  int money = 0;
  String currentOrderId = '';

  CustomerHomeOrderConfirmController({
    required this.oderStartData,
    required this.tableData,
  });

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
        t += (element['count'] as int) * int.parse(element['price'] as String);
      },
    );
    return t;
  }

  String orderId = '';
  String paymentUrl = '';

  Future<void> thanhToan(
      {required Function() onSuccess, required Function() onFail}) async {
    paid = getSoTienCanPay();
    final now = DateTime.now();
    orderId =
        '${paid}${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}';
    //
    print(tableData);
    final res = await payOrder(
        orderId: orderId,
        amount: paid.toInt(),
        description: 'thanh toan hoa don ban ${tableData['table_code']}');
    // showing = CustomerHomeOrderConfirmState.thanhToanStart;
    print('${res?['paymentUrl']}');
    paymentUrl = res?['paymentUrl'];
    if (paymentUrl.isNotEmpty) {
      showing = CustomerHomeOrderConfirmState.thanhToanStart;
    } else {}
    // print(res);
    update();
    onSuccess();
  }

  Future<void> orderMoreStart() async {
    //todo:gop order more vao order data

    for (var key in orderMore.keys) {
      final count = orderMore[key]['count'];
      if (oderStartData[key] != null) {
        oderStartData[key]['count'] += count;
      } else {
        oderStartData[key] = orderMore[key];
      }
    }
    //todo:cap nhat don order vao csdl
    try {
      showLoading();
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
      //todo: cap nhat thong tin thanh toan vao don hang(order)

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
}
