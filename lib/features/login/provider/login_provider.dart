import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_money_application/services/api_service.dart';
import 'package:send_money_application/services/notification_service.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider();

  final ApiService _api = ApiService();

  static ChangeNotifierProvider<LoginProvider> initialize() =>
      ChangeNotifierProvider(create: (context) => LoginProvider());

  Future<void> login({
    required BuildContext context,
    String? username,
    String? password,
    VoidCallback? onComplete,
    VoidCallback? onFailed,
  }) async {
    if ((username?.isEmpty ?? false) || (password?.isEmpty ?? false)) {
      NotificationService().notifyWithScaffold(
          context: context,
          message: 'Username or Password is missing.',
          bgColor: Colors.red);

      return;
    }

    /// fetch mock login api
    final result = await _api.fetchLogin(
      username: username ?? '',
      password: password ?? '',
    );

    if (result['message'] != 'success') {
      onFailed?.call();

      return;
    }

    onComplete?.call();
  }
}
