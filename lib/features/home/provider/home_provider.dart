import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_money_application/services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool _balanceVisible = true;
  bool get balanceVisible => _balanceVisible;

  static ChangeNotifierProvider<HomeProvider> initialize() =>
      ChangeNotifierProvider(create: (context) => HomeProvider());

  Future<void> logout({
    required VoidCallback onComplete,
  }) async {
    /// fetch mock login api
    final result = await _api.fetchLogout();

    if (result) {
      onComplete.call();
    }
  }

  Future<Map<String, dynamic>> getBalances() async {
    final result = await _api.fetchBalances();

    if (result.isEmpty) {
      return {};
    }

    return result;
  }

  void setHideBalance(bool value) {
    _balanceVisible = value;

    notifyListeners();
  }

  Future<void> sendAmount({
    required double amount,
    VoidCallback? onComplete,
  }) async {
    final result = await _api.fetchSendAmount(amount: amount);

    if (result.isEmpty) {
      return;
    }

    if (result['message'] == 'success') {
      onComplete?.call();
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionHistory() async {
    final result = await _api.fetchTransactionHistory();

    if (result.isEmpty) {
      return [];
    }

    return result;
  }
}
