import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/app_env.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailGuideView extends StatefulWidget {
  const new({required this.imageName, super.key});

  final String? imageName;

  @override
  State<DetailGuideView> createState() => _DetailGuideViewState();
}

class _DetailGuideViewState extends State<DetailGuideView> {
  late WebViewController _webViewController;
  bool _isCreated = false;

  void _initWebView() {
    if (widget.imageName == null) {
      Navigator.pop(context);
      return;
    }

    final imageName = widget.imageName;

    final url = '${AppEnv.baseUrl}/images/kia/$imageName';

    final uri = Uri.parse(url);

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.scaffoldBgColor)
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
              _isCreated = true;
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
      ..loadRequest(uri);
  }

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  @override
  void dispose() {
    _webViewController
      ..clearLocalStorage()
      ..clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'Usia ${widget.imageName?.replaceAll('.jpg', '')}',
          style: const TextStyle(fontSize: 22, fontWeight: .w600),
        ),
      ),
      body: _isCreated
          ? WebViewWidget(controller: _webViewController)
          : BaseSkeletonizer(
              child: Container(
                height: .infinity,
                width: .infinity,
                color: Colors.white,
              ),
            ),
    );
  }
}
