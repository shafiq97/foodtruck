import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Vendor extends StatefulWidget {
  const Vendor({super.key});

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Login'),
      ),
      body: const WebView(
          initialUrl: 'https://www.google.com/business/',
          javascriptMode: JavascriptMode.unrestricted),
    );
  }
}
