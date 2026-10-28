import 'package:flutter/material.dart';
import 'package:marn/core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.assetPath,
    required this.onFinished,
  });

  final String assetPath;
  final VoidCallback onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onFinished();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandMaroon,
      body: SizedBox.expand(
        child: Image.asset(widget.assetPath, fit: BoxFit.cover),
      ),
    );
  }
}
