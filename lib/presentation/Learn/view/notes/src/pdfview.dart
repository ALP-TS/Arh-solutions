import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b_soft_appliction/core/helpers/appbarhelper.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    final String? pdfUrl = Get.arguments;

    if (pdfUrl == null || pdfUrl.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Invalid PDF URL', style: TextStyle(color: Colors.red)),
        ),
      );
    }

    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: 'PDF'),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
