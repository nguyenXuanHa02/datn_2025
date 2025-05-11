import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/roles/manager/menu/addmenu.dart';

class MenuItem {
  final String id;
  final String name;
  final double price;
  final String category;
  final String description;
  final List<dynamic> image;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      description: json['description'] ?? '',
      image: json['image'] ?? [],
    );
  }
}

class MenuListPage extends StatefulWidget {
  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  List<MenuItem> _menuItems = [];
  bool _isLoading = true;
  void showDeleteConfirmation(MenuItem item) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bạn có chắc muốn xóa "${item.name}"?',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: Text('Hủy'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Xóa'),
                    onPressed: () {
                      Navigator.pop(context); // Đóng bottom sheet
                      deleteMenuItem(item);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteMenuItem(MenuItem item) async {
    try {
      DioClient client = DioClient();
      final dio = client.dio;

      Response response = await dio.delete(
        '/delete_menu_item',
        data: {'name': item.name},
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Xóa thành công')));
        fetchMenu(); // Reload danh sách
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Xóa thất bại')));
      }
    } catch (e) {
      print('Lỗi xóa: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi khi xóa')));
    }
  }

  Future<void> fetchMenu() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DioClient client = DioClient();
      final dio = client.dio;

      Response response = await dio.get('/menu');

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        List data = response.data['data'];
        setState(() {
          _menuItems = data.map((item) => MenuItem.fromJson(item)).toList();
        });
      } else {
        print('Fetch thất bại');
      }
    } catch (e) {
      print('Lỗi fetch menu: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  void navigateToAddMenu() async {
    // Navigate sang màn thêm món
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMenuPage()),
    );

    // Khi quay về, load lại menu
    fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Sách Menu'),
        actions: [
          TextButton(
            onPressed: navigateToAddMenu,
            child: const Row(
              children: [Icon(Icons.add), Text('Thêm món')],
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchMenu,
              child: ListView.builder(
                  itemCount: _menuItems.length,
                  itemBuilder: (context, index) {
                    final item = _menuItems[index];
                    return ListTile(
                      leading: item.image.isNotEmpty
                          ? Image.network(item.image[0],
                              width: 50, height: 50, fit: BoxFit.cover)
                          : Icon(Icons.fastfood),
                      title: Text(item.name),
                      subtitle: Text('${item.price} VND - ${item.category}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => showDeleteConfirmation(item),
                      ),
                    );
                  }),
            ),
    );
  }
}
