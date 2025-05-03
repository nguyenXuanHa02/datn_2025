import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';

class StaffPayController extends BaseController {
  @override
  void onInit() {
    getAllOrder();
    addOrderListener();
    super.onInit();
  }

  List<String> changeList = [];

  void addOrderListener() {
    FirebaseFirestore.instance
        .collection('orders')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      for (var change in snapshot.docChanges) {
        // if (change.type == DocumentChangeType.modified) {
        final newStatus = change.doc['status'];
        final docId = change.doc.id;
        changeList.add(docId);
        update();
        // Ví dụ: cập nhật UI, hiển thị thông báo,...
      }
      // }
    });
  }

  Future<void> getAllOrder() async {
    showLoading();
    final getter = await FirebaseFirestore.instance.collection('orders').get();
    getter.docs.forEach(
      (element) {
        changeList.add(element.data().toString());
      },
    );
    hireLoading();
    update();
  }
}
