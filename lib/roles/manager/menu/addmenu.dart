import 'package:dio/dio.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/manager/menu/add_image/page.dart';

class AddMenuPage extends StatefulWidget {
  @override
  _AddMenuPageState createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String? _selectedImageUrl;
  bool _isSubmitting = false;

  Future<void> submitMenuItem() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      String apiUrl = '/add_menu_item';
      Dio dio = DioClient().dio;

      Map<String, dynamic> data = {
        "name": _nameController.text,
        "price": double.tryParse(_priceController.text) ?? 0,
        "category": _categoryController.text,
        "description": _descController.text,
        "images": [_selectedImageUrl] // truyền danh sách ảnh
      };

      Response response = await dio.post(apiUrl, data: data);

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Thêm món thành công!')));
        Navigator.pop(context); // Quay lại
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Thêm món thất bại!')));
      }
    } catch (e) {
      print('Lỗi: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi khi thêm món')));
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void navigateToUploadImage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadImagePage(
          onImageUploaded: (url) {
            setState(() {
              _selectedImageUrl = url;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm Món Mới')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tên món')),
            AppSize.h8,
            TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Giá'),
                keyboardType: TextInputType.number),
            AppSize.h8,
            TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Danh mục')),
            AppSize.h8,
            TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Mô tả')),
            AppSize.h8,
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: navigateToUploadImage,
                    child: Text('Chọn Ảnh'),
                  ),
                ),
              ],
            ),
            if (_selectedImageUrl != null) ...[
              const SizedBox(height: 10),
              Image.network(_selectedImageUrl!, height: 150),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _isSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: submitMenuItem,
              child: const Text('Thêm Món'),
            ).padAll(16),
    );
  }
}
