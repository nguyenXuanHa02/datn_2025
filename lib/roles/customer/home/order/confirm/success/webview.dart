import 'dart:convert';

import 'package:get/get.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  const Webview({super.key, required this.url, required this.onSuccess});
  final String url;
  final Function(Map) onSuccess;
  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  late final WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            final result = await controller.runJavaScriptReturningResult(
              'document.body.innerText',
            );
            final jsonString = _cleanJsResult(result);
            try {
              final jsonData = jsonDecode(jsonString);
              widget.onSuccess(jsonData);
            } catch (e) {}
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  String _cleanJsResult(Object result) {
    final raw = result.toString();
    return raw
        .replaceAll(RegExp(r'^"|"$'), '') // bỏ dấu " đầu cuối
        .replaceAll(r'\"', '"'); // unescape
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        onBackPress: () {
          if (Get.isRegistered<CustomerHomeOrderConfirmController>()) {
            final _controller = Get.find<CustomerHomeOrderConfirmController>();
            _controller.cancelPayment();
          }
        },
        title: 'Thanh toán',
      ),
      // body: WebViewWidget(controller: controller),
      body: FutureBuilder(
          future: Future.delayed(100.ms),
          builder: (c, _) {
            return WebViewWidget(
              controller: controller,
            );
          }),
    );
    // return BaseScaffold<CustomerHomeOrderConfirmController>(
    //   (p0) {
    //     return
    //   },
    // );
  }
}
