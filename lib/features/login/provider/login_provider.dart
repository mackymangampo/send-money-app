import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_money_application/services/api_service.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider();

  final ApiService _api = ApiService();

  static ChangeNotifierProvider<LoginProvider> initialize() =>
      ChangeNotifierProvider(create: (context) => LoginProvider());

  Future<void> login({
    required String username,
    required String password,
    VoidCallback? onComplete,
    VoidCallback? onFailed,
  }) async {
    /// fetch mock login api
    final result = await _api.fetchLogin(
      username: username,
      password: password,
    );

    if (result['message'] != 'success') {
      onFailed?.call();

      return;
    }

    onComplete?.call();
  }
}
