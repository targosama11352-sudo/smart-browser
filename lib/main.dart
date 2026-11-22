import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const SmartBrowserApp());
}

class SmartBrowserApp extends StatelessWidget {
  const SmartBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Browser',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BrowserHome(),
    );
  }
}

class BrowserHome extends StatefulWidget {
  const BrowserHome({super.key});
  @override
  State<BrowserHome> createState() => _BrowserHomeState();
}

class _BrowserHomeState extends State<BrowserHome> {
  late final WebViewController controller;
  final TextEditingController urlController = TextEditingController(text: 'https://www.google.com');

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.google.com'));
  }

  void goToUrl() {
    String url = urlController.text.trim();
    if (!url.startsWith('http')) {
      url = 'https://$url';
    }
    controller.loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: urlController,
          decoration: const InputDecoration(
            hintText: 'Search or enter URL',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
          onSubmitted: (_) => goToUrl(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: goToUrl),
          IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => controller.goBack()),
          IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => controller.goForward()),
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => controller.reload()),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
