import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({Key? key, required this.title, required this.url})
      : super(key: key);
  final String title;
  final String url;

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late File pdfFile;
  bool isLoading = false;
  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    log('DOWNLOAD URL ${widget.url}');
    var tempDir = await getTemporaryDirectory();
    String fullPath = '${tempDir.path}/${widget.url.split('/').last}';
    log('File name $fullPath');
    bool isExist = await File(fullPath).exists();

    if (isExist) {
      setState(() {
        pdfFile = File(fullPath);
      });

      return;
    }
    log(widget.url, name: 'FILE URL');
    var response = await Dio().get(
      widget.url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    );
    File file = File(fullPath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    setState(() {
      pdfFile = file;
    });

    log(pdfFile.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: pdfFile.path,
            ),
    );
  }
}
