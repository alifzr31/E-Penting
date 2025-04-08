import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPanduanPage extends StatefulWidget {
  const DetailPanduanPage({required this.imageName, super.key});

  static const String routeName = '/detailPanduan';

  final String imageName;

  @override
  State<DetailPanduanPage> createState() => _DetailPanduanPageState();
}

class _DetailPanduanPageState extends State<DetailPanduanPage> {
  late WebViewController _webViewController;
  bool isCreated = false;

  void _initWebView() {
    final url = Uri.parse(
      'https://e-penting.bandung.go.id/images/kia/${widget.imageName}',
    );

    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                if (kDebugMode) print(progress);
              },
              onPageStarted: (String url) {
                if (kDebugMode) print(url);
              },
              onPageFinished: (String url) {
                if (kDebugMode) print(url);
                setState(() {
                  isCreated = true;
                });
              },
              onHttpError: (HttpResponseError error) {
                if (kDebugMode) print(error);
              },
              onWebResourceError: (WebResourceError error) {
                if (kDebugMode) print(error);
              },
            ),
          )
          ..loadRequest(url);
  }

  @override
  void initState() {
    _initWebView();
    super.initState();
  }

  @override
  void dispose() {
    _webViewController
      ..clearCache()
      ..clearLocalStorage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          'Perawatan Bayi Usia ${widget.imageName.replaceAll('.jpg', '')}',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body:
          isCreated
              ? WebViewWidget(controller: _webViewController)
              : Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mohon tunggu sebentar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Sedang memuat konten...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      const CupertinoActivityIndicator(),
                    ],
                  ),
                ),
              ),
    );
  }
}
