import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';

class UploadImagePage extends StatefulWidget {
  final Function(String imageUrl) onImageUploaded;

  UploadImagePage({required this.onImageUploaded});

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _selectedImage;
  bool _isUploading = false;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // Khớp với client và endpoint bạn yêu cầu
      String uploadUrl = '/uploader'; // endpoint nodeJS
      DioClient client = DioClient();
      final dio = client.dio;

      String fileName = _selectedImage!.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(_selectedImage!.path,
            filename: fileName),
      });

      Response response = await dio.post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        String imageUrl = response.data['imageUrl'];
        widget.onImageUploaded(imageUrl); // Trả URL ảnh về màn trước
        Navigator.pop(context); // Quay về màn Thêm Món
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Upload thất bại!')));
      }
    } catch (e) {
      print('Upload lỗi: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi khi upload')));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Ảnh')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: pickImage, child: Text('Chọn Ảnh')),
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200),
            SizedBox(height: 20),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: uploadImage,
                    child: Text('Upload & Dùng ảnh này'),
                  ),
          ],
        ),
      ),
    );
  }
}
