import 'package:e_penting/app/utils/app_env.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

class DetailGuideView extends StatefulWidget {
  const new({required this.imageName, super.key});

  final String? imageName;

  @override
  State<DetailGuideView> createState() => _DetailGuideViewState();
}

class _DetailGuideViewState extends State<DetailGuideView>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  Key _imageKey = UniqueKey();

  void _animationListener() {
    if (_animation != null) {
      _transformationController.value = _animation!.value;
    }
  }

  void _retry() {
    setState(() {
      _imageKey = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(_animationListener);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController
      ..removeListener(_animationListener)
      ..dispose();
    super.dispose();
  }

  String get baseUrl =>
      kDebugMode ? AppEnv.staggingBaseUrl : AppEnv.prodBaseUrl;
  String get title => 'Usia ${widget.imageName?.replaceAll('.jpg', '')}';
  String get imageUrl => '$baseUrl/images/kia/${widget.imageName}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: .w600),
        ),
      ),
      body: SizedBox.expand(
        child: InteractiveViewer(
          transformationController: _transformationController,
          clipBehavior: .hardEdge,
          boundaryMargin: const .all(40),
          minScale: 1.0,
          maxScale: 5.0,
          child: SizedBox.expand(
            child: Image.network(
              imageUrl,
              key: _imageKey,
              fit: .contain,
              alignment: .center,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;

                return const Center(
                  child: BaseSkeletonizer(
                    child: SizedBox.expand(
                      child: ColoredBox(color: Colors.white),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Padding(
                  padding: const .all(16),
                  child: BaseHandleState(
                    handleType: .error,
                    lottieWidth: 160,
                    errorMessage: 'Gagal memuat panduan perawatan anak',
                    onRefetch: _retry,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
