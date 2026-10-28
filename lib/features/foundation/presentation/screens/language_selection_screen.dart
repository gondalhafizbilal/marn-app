import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/config/localization/cubit/localizations_cubit.dart';
import 'package:marn/core/utils/app_strings.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({
    super.key,
    required this.backgroundAsset,
    required this.onSelected,
  });

  final String backgroundAsset;
  final VoidCallback onSelected;

  Future<void> _selectLanguage(BuildContext context, String code) async {
    await context.read<LocalizationsCubit>().setLanguage(code);
    if (context.mounted) {
      onSelected();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(backgroundAsset, fit: BoxFit.cover),
            _LanguageTapZone(
              top: .478,
              semanticLabel: strings.arabic,
              onTap: () => _selectLanguage(context, 'ar'),
            ),
            _LanguageTapZone(
              top: .535,
              semanticLabel: strings.english,
              onTap: () => _selectLanguage(context, 'en'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTapZone extends StatelessWidget {
  const _LanguageTapZone({
    required this.top,
    required this.semanticLabel,
    required this.onTap,
  });

  final double top;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            left: size.width * .18,
            right: size.width * .18,
            top: size.height * top,
            height: size.height * .055,
            child: Semantics(
              button: true,
              label: semanticLabel,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onTap,
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
