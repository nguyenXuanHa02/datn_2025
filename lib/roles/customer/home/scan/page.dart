import 'package:kichikichi/core/imports/imports.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomerHomeScan extends StatefulWidget {
  const CustomerHomeScan({super.key});

  @override
  State<CustomerHomeScan> createState() => _CustomerHomeScanState();
}

class _CustomerHomeScanState extends State<CustomerHomeScan> {
  final MobileScannerController controller = MobileScannerController();
  bool _hasPermission = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      final result = await Permission.camera.request();
      if (!result.isGranted) {
        setState(() {
          _hasPermission = false;
          _errorText = 'Không thể truy cập camera. Vui lòng cấp quyền.';
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasPermission) {
      return Scaffold(
        appBar: AppBar(title: const Text('QR Scanner')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Tính năng quét QR cần quyền truy cập camera, vui lòng cho phép để tiếp tục sử dụng',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                FilledButton(
                    onPressed: () async {
                      final result = await Permission.camera.request();
                      if (result == PermissionStatus.granted) {
                        controller.start();
                      }
                    },
                    child: const Text('Cấp quyền camera'))
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.switch_camera),
            onPressed: () => controller.switchCamera(),
          ),
          DebugButton(
            () async {
              final tableData = await checkQrCode('lol');
              if (tableData['table_code'] != null && context.mounted) {
                controller.stop();
                Navigator.pushReplacementNamed(
                    context, RouteCons.customerHomeOrder,
                    arguments: tableData);
              }
            },
          )
        ],
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) async {
          final barcode = capture.barcodes.first;
          if (barcode.rawValue != null) {
            // todo: check qrcode before move to order page
            final tableData = await checkQrCode(barcode.rawValue);
            if (tableData['table_code'] != null && context.mounted) {
              controller.stop();
              Navigator.pushReplacementNamed(
                  context, RouteCons.customerHomeOrder,
                  arguments: tableData);
            }
          }
        },
        errorBuilder: (context, error, _) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tính năng quét QR cần quyền truy cập camera, vui lòng cho phép để tiếp tục sử dụng',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  FilledButton(
                      onPressed: () async {
                        final result = openAppSettings();
                        if (result == PermissionStatus.granted) {
                          controller.start();
                        }
                      },
                      child: const Text('Cấp quyền camera'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<Map> checkQrCode(String? rawValue) async {
    return {'table_code': 1, 'table_label': 'Bàn số 1'};
  }
}
