import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();

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
                  if (data['status'] == 'needStaff') {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Xác nhận đã thu ${data['totalAmount']} vnd tiền mặt',
                                style: AppTextStyles.heading2,
                              ),
                              AppSize.h8,
                              RoundedButton.text(
                                'Xác nhận',
                                () async {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('orders')
                                        .doc(document.id)
                                        .update({'status': 'staffTaken'});
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).sendMessage(
                                        'Cập nhật không thành công');
                                  }
                                },
                              )
                            ],
                          ).safePad(),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Text('Bàn số ${data['tableNumber']}'),
                              const Spacer(),
                              Text('${data['totalAmount']} vnd'),
                            ],
                          ),
                          subtitle: const Text('Cần thanh toán bằng tiền mặt'),
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
      ).safePad(),
    );
  }
}
