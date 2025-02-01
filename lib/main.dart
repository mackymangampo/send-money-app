import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:send_money_application/features/home/provider/home_provider.dart';
import 'package:send_money_application/features/login/provider/login_provider.dart';
import 'package:send_money_application/features/login/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:send_money_application/services/progress_overlay_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        LoginProvider.initialize(),
        HomeProvider.initialize(),
      ],
      child: const SendMoneyApp(),
    ),
  );
}

class SendMoneyApp extends StatefulWidget {
  const SendMoneyApp({super.key});

  @override
  State<SendMoneyApp> createState() => _SendMoneyAppState();
}

class _SendMoneyAppState extends State<SendMoneyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Send Money App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: ProgressOverlayService.init(builder: (context, child) {
          child ??= const SizedBox.shrink();
          return ResponsiveBreakpoints.builder(
            child: Portal(child: child),
            breakpoints: [
              const Breakpoint(start: 0, end: 600, name: MOBILE),
              const Breakpoint(start: 601, end: 1024, name: TABLET),
            ],
          );
        }),
        home: const LoginScreen(),
      );
}
