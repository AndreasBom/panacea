import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panacea_app/features/login/views/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('sv', 'SE')],
      path: 'assets/translations',
      //fallbackLocale: Locale('en', 'US'),
      child: ProviderScope(
        child: App(),
      ),
    ),
  );
}

class App extends ConsumerWidget {
  App({super.key});

  final titleProvider = Provider((ref) => 'Hem titel');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ref.read(titleProvider),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: FlexThemeData.light(
        subThemesData: const FlexSubThemesData(
          inputDecoratorUnfocusedHasBorder: true,
          inputDecoratorRadius: 5,
          inputDecoratorIsFilled: false,
        ),
        scheme: FlexScheme.blumineBlue,
        appBarElevation: 0.5,
      ),
      home: const LoginView(),
    );
  }
}
