import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  ApiService();

  final Dio _dio = Dio();

  String get _baseUrl => 'https://ed834.wiremockapi.cloud/';

  Future<Map<String, dynamic>> fetchLogin({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      return {};
    }
    log('fetching api post login....');
    try {
      final response = await _dio.post(
        '${_baseUrl}json/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      final data = response.data;

      if (data == null) {
        return {};
      }

      log('fetch api post login success!!');

      return data;
    } catch (e, stackTrace) {
      log('Api error: $e and stackTrace: $stackTrace LOGIN API');

      return {'message': 'not success'};
    }
  }

  Future<bool> fetchLogout() async {
    log('fetching api post logout....');

    try {
      final response = await _dio.get(
        '${_baseUrl}json/logout',
      );

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        log('fetch api post logout success');

        return true;
      }

      return false;
    } catch (e, stackTrace) {
      log('Api error: $e and stackTrace: $stackTrace LOGOUT API');
    }

    return false;
  }

  Future<Map<String, dynamic>> fetchBalances() async {
    log('fetching api balances....');

    try {
      final response = await _dio.get('${_baseUrl}json/balance');

      final data = response.data;

      if (data == null) {
        return {};
      }

      Map<String, dynamic> balanceData = {};

      balanceData.addAll(data);

      log('fetch api balances success....');

      return balanceData;
    } catch (e) {
      log('Api error: $e BALANCE API');
    }

    return {};
  }

  Future<Map<String, dynamic>> fetchSendAmount({
    required double amount,
  }) async {
    log('fetching api sending money....');

    try {
      final response = await _dio.post(
        '${_baseUrl}json/send_money',
        data: {
          'amount': amount,
        },
      );

      final data = response.data;

      if (data == null) {
        return {};
      }

      log('fetch api sending money success');

      return data;
    } catch (e) {
      log('Api error: $e SENDING MONEY API');
    }

    return {};
  }

  Future<List<Map<String, dynamic>>> fetchTransactionHistory() async {
    log('fetching api transaction history....');

    try {
      final response = await _dio.get(
        '${_baseUrl}json/transaction_history',
      );

      final data = response.data;

      if (data == null) {
        return [];
      }

      List<Map<String, dynamic>> list = List.from(data['list'], growable: true);

      log('fetch api transaction history success');

      return list;
    } catch (e) {
      log('Api error: $e SENDING MONEY API');
    }

    return [];
  }
}
