import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

class StaffArivePage extends StatefulWidget {
  @override
  _StaffArivePageState createState() => _StaffArivePageState();
}

class _StaffArivePageState extends State<StaffArivePage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();

  Future<void> updateItemStatus(
      String orderId, String itemId, String newStatus) async {
    try {
      // Lấy document đơn hàng từ Firestore
      DocumentReference orderRef =
          FirebaseFirestore.instance.collection('orders').doc(orderId);

      // Truy cập vào trường 'items' và tìm món ăn theo itemId, sau đó cập nhật status
      var orderSnapshot = await orderRef.get();
      if (orderSnapshot.exists) {
        var orderData = orderSnapshot.data() as Map<String, dynamic>;
        var items = orderData['items'] as List<dynamic>;

        // Tìm món ăn trong danh sách items
        int itemIndex =
            items.indexWhere((item) => item['id'].toString() == itemId);
        if (itemIndex != -1) {
          // Update trạng thái cho món ăn
          items[itemIndex]['status'] = newStatus;

          // Cập nhật lại trường items trong Firestore
          await orderRef.update({'items': items});
          print('Item status updated successfully');
        } else {
          print('Item not found');
        }
      } else {
        print('Order not found');
      }
    } catch (e) {
      print('Failed to update item status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  if (data['status'] == 'pending') {
                    final items = data['items'] as List;
                    return ListTile(
                      title: Text(
                        'Bàn ${data['tableNumber']}',
                        style: AppTextStyles.heading2,
                      ),
                      subtitle: Column(
                        children: List.generate(
                          items.length,
                          (index) => Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.card,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        '${items[index]['count']} * ${items[index]['title']}',
                                        style: AppTextStyles.heading3,
                                      )),
                                      AppSize.w8,
                                      (items[index]['status'] != 'arrive')
                                          ? FilledButton(
                                              onPressed: () async {
                                                try {
                                                  await updateItemStatus(
                                                      document.id,
                                                      '${items[index]['id']}',
                                                      'arrive');
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .sendMessage(
                                                    'Gặp lỗi không mong muốn',
                                                  );
                                                  print(e.toString());
                                                }
                                              },
                                              child: const Text('Hoàn tất'))
                                          : const Text('Đã giao')
                                    ],
                                  ).cardPad())
                              .padBottom(8),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
