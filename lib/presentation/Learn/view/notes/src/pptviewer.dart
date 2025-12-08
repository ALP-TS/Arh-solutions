import 'package:flutter/material.dart';
import 'package:arh_solution_app/core/helpers/appbarhelper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OfficeWebView extends StatefulWidget {
  final String url;
  final String title;
  const OfficeWebView({required this.url, required this.title, super.key});

  @override
  State<OfficeWebView> createState() => _OfficeWebViewState();
}

class _OfficeWebViewState extends State<OfficeWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  String get gviewUrl {
    final encoded = Uri.encodeComponent(widget.url);
    return 'https://docs.google.com/gview?embedded=true&url=$encoded';
  }

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
            print("Started: $url");

            // Detect viewerng
            if (url.contains("viewerng/viewer")) {
              Navigator.pop(context);
            }
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
            print("Finished: $url");
          },
          onUrlChange: (change) {
            print("URL changed: ${change.url}");
            if (change.url != null && change.url!.contains("viewerng/viewer")) {
              Navigator.pop(context);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(gviewUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: widget.title),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
