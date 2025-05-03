import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        title: const Text('Doanh thu theo ngày'),
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
                    return Card(
                      child: ListTile(
                        title: Text("Bàn: ${data['tableNumber']}"),
                        subtitle: Text("Trạng thái: ${data['status']}"),
                        trailing: Text("${data['totalAmount']} ₫"),
                      ),
                    );
                  }).toList(),
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
}
