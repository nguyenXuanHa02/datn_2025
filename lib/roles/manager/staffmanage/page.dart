import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';

class ManagerCreateStaffPage extends StatefulWidget {
  @override
  _ManagerCreateStaffPageState createState() => _ManagerCreateStaffPageState();
}

class _ManagerCreateStaffPageState extends State<ManagerCreateStaffPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _statusMessage;

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _statusMessage = null;
    });

    final success = await createStaff(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _loading = false;
      _statusMessage =
          success ? 'Tạo tài khoản thành công!' : 'Tạo tài khoản thất bại.';
    });
    _usernameController.clear();
    _passwordController.clear();
  }

  Future<bool> createStaff(String username, String password) async {
    try {
      final dio = DioClient().dio;
      final response = await dio.post(
        '/createStaff',
        data: {
          'username': username,
          'password': password,
        },
      );

      return response.data['staus'] ==
          'success'; // chú ý bạn viết sai 'staus' thay vì 'status'
    } catch (e) {
      print('Create staff error: $e');
      return false;
    }
  }

  Stream<List<Map<String, dynamic>>> getStaffAccounts() {
    return FirebaseFirestore.instance
        .collection('user')
        .where('rule', isEqualTo: 2)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tạo tài khoản nhân viên')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration:
                        const InputDecoration(labelText: 'Tên đăng nhập'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Vui lòng nhập tên đăng nhập'
                        : null,
                  ),
                  AppSize.h8,
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Mật khẩu'),
                    obscureText: true,
                    validator: (value) => value == null || value.length < 6
                        ? 'Mật khẩu tối thiểu 6 ký tự'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            await _handleSubmit();
                          },
                    child: _loading
                        ? CircularProgressIndicator()
                        : Text('Tạo tài khoản'),
                  ),
                  if (_statusMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _statusMessage!,
                      style: TextStyle(
                        color: _statusMessage!.contains('thành công')
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Danh sách tài khoản nhân viên:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: getStaffAccounts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  }
                  final users = snapshot.data ?? [];

                  if (users.isEmpty) {
                    return const Center(child: Text('Chưa có nhân viên nào.'));
                  }

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        leading: Icon(Icons.person),
                        title: Text(user['username'] ?? 'Không tên'),
                        subtitle: Text('ID: ${user['id']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Xác nhận xoá'),
                                content:
                                    Text('Bạn có chắc muốn xoá tài khoản này?'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: Text('Huỷ')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: Text('Xoá')),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(user['id'])
                                  .delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Đã xoá tài khoản')),
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
