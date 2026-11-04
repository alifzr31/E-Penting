import 'package:e_penting/app/cubits/survey/survey_cubit.dart';
import 'package:e_penting/app/utils/app_env.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SurveyView extends StatefulWidget {
  const new({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  bool _isLoading = true;
  bool _isSubmitted = false;

  void _markSubmitted() {
    if (!_isSubmitted && mounted) {
      setState(() {
        _isSubmitted = true;
      });

      context.read<SurveyCubit>().markHasRating();
    }
  }

  void _checkIfSurveySubmitted(String? url, String? method) {
    if (url == null) return;
    if (method != null && method.toUpperCase() != 'POST') return;

    try {
      final uri = Uri.parse(url);
      final isCorrectDomain = uri.host.contains('surveidigital.spbe.go.id');
      final isCorrectPath =
          uri.path.contains('/survey/') && uri.path.contains('/submit');

      if (kDebugMode) {
        print(
          'Survey Intercepted: method=$method, host=${uri.host}, path=${uri.path}',
        );
      }

      if (isCorrectDomain && isCorrectPath) {
        _markSubmitted();
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SafeArea(
                    bottom: false,
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri('${AppEnv.prodBaseUrl}/survei'),
                      ),
                      initialSettings: InAppWebViewSettings(
                        useShouldInterceptRequest: true,
                        useShouldInterceptFetchRequest: true,
                        useShouldInterceptAjaxRequest: true,
                        javaScriptEnabled: true,
                      ),
                      onLoadStart: (controller, url) {
                        setState(() {
                          _isLoading = true;
                        });
                      },
                      onLoadStop: (controller, url) async {
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      shouldInterceptRequest: (controller, request) async {
                        _checkIfSurveySubmitted(
                          request.url.toString(),
                          request.method,
                        );

                        return null;
                      },
                      shouldInterceptFetchRequest:
                          (controller, fetchRequest) async {
                            _checkIfSurveySubmitted(
                              fetchRequest.url?.toString(),
                              fetchRequest.method,
                            );

                            return null;
                          },
                      shouldInterceptAjaxRequest:
                          (controller, ajaxRequest) async {
                            _checkIfSurveySubmitted(
                              ajaxRequest.url?.toString(),
                              ajaxRequest.method,
                            );

                            return null;
                          },
                      onConsoleMessage: (controller, consoleMessage) {
                        if (kDebugMode) {
                          print(
                            'Survey WebView Console: ${consoleMessage.message}',
                          );
                        }
                        final msg = consoleMessage.message.toLowerCase();
                        if (msg.contains('completed') ||
                            msg.contains('anda sudah mengisi survei ini') ||
                            msg.contains('survey telah berhasil')) {
                          _markSubmitted();
                        }
                      },
                      onJsAlert: (controller, jsAlertRequest) async {
                        final msg = jsAlertRequest.message?.toLowerCase() ?? '';
                        if (msg.contains('selesai') ||
                            msg.contains('terima kasih')) {
                          _markSubmitted();
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                if (_isSubmitted) ...[
                  SizedBox(
                    width: .infinity,
                    child: Material(
                      elevation: 1,
                      color: Colors.white,
                      clipBehavior: .antiAlias,
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: const .symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          child: BaseButton(
                            label: 'Tutup Survey',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (_isLoading) ...{
              const Center(child: CircularProgressIndicator()),
            },
          ],
        ),
      ),
    );
  }
}
