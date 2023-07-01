import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  const PaymentWebViewScreen({
    Key? key,
    required this.paymentUrl,
  }) : super(key: key);

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewXController webViewController;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الدفع',
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: WebViewX(
        initialContent: widget.paymentUrl,
        initialSourceType: SourceType.url,
        onWebViewCreated: (controller) => webViewController = controller,
        onPageFinished: (String url) async {
          log(url, name: 'UPDATED URL');
        },
        height: screenSize.height,
        width: screenSize.width,
      ),
    );
  }
}
