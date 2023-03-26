import 'dart:io';

import 'package:flutter/foundation.dart'
    show kIsWeb; // for checking whether running on Web or not
import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

void main(List<String> args) => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = PdfViewerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // title: ValueListenableBuilder<Matrix4>(
          //   // The controller is compatible with ValueListenable<Matrix4> and you can receive notifications on scrolling and zooming of the view.
          //     valueListenable: controller,
          //     builder: (context, _, child) => Text(controller.isReady
          //         ? 'Page #${controller.currentPageNumber}'
          //         : 'Page -')),
        ),
        backgroundColor: Colors.transparent,
        body: PdfViewer.openAsset(
          'assets/pdf/rd.pdf',
          viewerController: controller,
          onError: (err) => print(err),
          params: PdfViewerParams(
            padding: 100,
            minScale: 1.0,
            scrollDirection: Axis.vertical,
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.first_page),
              onPressed: () => controller.ready?.goToPage(pageNumber: 1),
            ),
            FloatingActionButton(
              child: Icon(Icons.last_page),
              onPressed: () => controller.ready?.goToPage(pageNumber: controller.pageCount),
            ),
          ],
        ),
      ),
    );
  }
}