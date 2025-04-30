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
  CustomerHomeOrderConfirmState showing = CustomerHomeOrderConfirmState.start;

  num paid = 0;
  Map<int, int> counter = {};
  Map<int, dynamic> orderMore = {};
  int money = 0;

  CustomerHomeOrderConfirmController({required this.oderStartData});
  Future<void> order(
      {required Function() onSuccess, required Function() onFail}) async {
    // todo : call api here to send the order
    // await Future.delayed(const Duration(seconds: 1));
    onSuccess();
  }

  Future<void> thanhToan(
      {required Function() onSuccess, required Function() onFail}) async {
    showing = CustomerHomeOrderConfirmState.thanhToanThanhCong;
    showing = CustomerHomeOrderConfirmState.thanhToanThatBai;
    paid = 1000000;
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
}
