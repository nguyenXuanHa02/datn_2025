import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  const ErrorPage({Key? key, this.errorMessage = "Page not found!"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 80),
            const SizedBox(height: 16),
            const Text(
              "Oops!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Quay lại màn hình trước
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
