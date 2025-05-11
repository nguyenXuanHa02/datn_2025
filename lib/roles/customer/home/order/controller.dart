import 'package:kichikichi/commons/bloc/baseController.dart';

class HomeOrderController extends BaseController {
  @override
  void onInit() {
    fetchMenuAsMap();
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
}
