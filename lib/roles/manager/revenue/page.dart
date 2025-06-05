import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kichikichi/core/imports/imports.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({super.key});

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  DateTimeRange selectedRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );

  List<QueryDocumentSnapshot> orders = [];
  int totalRevenue = 0;
  bool isLoading = false;

  Future<void> loadRevenue() async {
    setState(() => isLoading = true);

    final firestore = FirebaseFirestore.instance;
    String format(DateTime dt) => DateFormat('yyyyMMddHHmmss').format(dt);
    int start = int.parse(format(selectedRange.start));
    int end = int.parse(format(selectedRange.end));

    try {
      final snapshot = (await firestore
              .collection('orders')
              .where(
                'createdAt',
                isGreaterThanOrEqualTo: start,
              )
              .where('createdAt', isLessThanOrEqualTo: end)
              .get())
          .docs
          .where(
            (element) =>
                element['status'] == 'onlinePaid' ||
                element['status'] == 'staffTaken',
          )
          .toList();

      final total = snapshot.fold<int>(0, (sum, doc) {
        final data = doc.data();
        return sum + (data['totalAmount'] as int ?? 0);
      });

      setState(() {
        orders = snapshot;
        totalRevenue = total;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }

  Future<void> pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: selectedRange,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => selectedRange = picked);
      await loadRevenue();
    }
  }

  @override
  void initState() {
    super.initState();
    loadRevenue();
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        "${DateFormat('dd/MM/yyyy').format(selectedRange.start)} - ${DateFormat('dd/MM/yyyy').format(selectedRange.end)}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê doanh thu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: pickDateRange,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadRevenue,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text("Khoảng thời gian: $dateText"),
                  const SizedBox(height: 12),
                  Text(
                    "Tổng doanh thu: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(totalRevenue)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text("Danh sách đơn hàng:"),
                  const SizedBox(height: 8),
                  ...orders.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            final items = data['items'];
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.toString()),
                                  Text('Bàn: ${data['tableNumber'] ?? '--'}'),
                                  if (items is List)
                                    ListView(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSize.paddingSmall),
                                      shrinkWrap: true,
                                      children: List.generate(
                                        items.length,
                                        (index) {
                                          return item(items[index], 1);
                                        },
                                      ),
                                    )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(data['createdAt'] != null
                              ? timeParse('${data['createdAt']}')
                              : '--'),
                          subtitle: Text(
                              "Trạng thái: ${data['status'] == 'onlinePaid' ? "Thanh toán trực tuyến" : 'Tiền mặt'}"),
                          trailing: Text("${data['totalAmount']} vn₫"),
                        ),
                      ),
                    );
                  }),
                  if (orders.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Text("Không có đơn hàng"),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  String timeParse(String raw) {
    if (raw.length != 14 || !RegExp(r'^\d{14}$').hasMatch(raw)) {
      return '--';
    }

    try {
      int year = int.parse(raw.substring(0, 4));
      int month = int.parse(raw.substring(4, 6));
      int day = int.parse(raw.substring(6, 8));
      int hour = int.parse(raw.substring(8, 10));
      int minute = int.parse(raw.substring(10, 12));
      int second = int.parse(raw.substring(12, 14));

      // Kiểm tra giá trị hợp lệ cơ bản
      if (month < 1 ||
          month > 12 ||
          day < 1 ||
          day > 31 ||
          hour < 0 ||
          hour > 23 ||
          minute < 0 ||
          minute > 59 ||
          second < 0 ||
          second > 59) {
        return '--';
      }

      final dateTime = DateTime(year, month, day, hour, minute, second);
      return 'Ngày ${dateTime.day.toString().padLeft(2, '0')}'
          ' tháng${dateTime.month.toString().padLeft(2, '0')}'
          ' -- ${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return '--';
    }
  }

  Widget item(Map m, int e) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ImageViewer(
            m['image'] is List ? m['image'][0] : m['image'],
            height: 50,
            width: 50,
          ),
        ),
        AppSize.paddingSmall.w,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyles.bodyText.text(m['name']),
              AppTextStyles.bodyText.text(m['price'].toString()),
            ],
          ),
        ),
        Center(
          child: Text('x${m['count']}'),
        )
      ],
    ).padSymmetric(v: 8).animate().fadeIn(duration: 300.ms).slide(
          begin: const Offset(-2, 0),
          end: const Offset(0, 0),
          duration: 250.ms + 90.ms * e,
        );
  }
}
