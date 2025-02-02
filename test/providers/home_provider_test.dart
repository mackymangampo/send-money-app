import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_application/features/home/provider/home_provider.dart';
import 'package:send_money_application/services/api_service.dart';

import 'home_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('Home Provider', () {
    late ApiService api;
    late HomeProvider home;

    setUp(() {
      api = MockApiService();

      home = HomeProvider();
    });

    test('logout successful', () async {
      bool onCompleteCalled = false;

      /// Arrange
      when(api.fetchLogout()).thenAnswer((_) => Future.value(true));

      final res = await api.fetchLogout();

      /// Act
      await home.logout(onComplete: () => onCompleteCalled = res);

      /// Assert
      expect(onCompleteCalled, isTrue);
    });

    test('fetch balance functionality', () async {
      when(api.fetchBalances()).thenAnswer(
        (_) => Future.value(
          {
            'id': 1,
            'balance': 1000.00,
          },
        ),
      );

      final res = await home.getBalances();

      expect(res['id'], 1);
      expect(res['balance'], 1000.00);
    });

    test('send amount functionality', () async {
      bool onCompleteCalled = false;

      when(api.fetchSendAmount(amount: 200.00))
          .thenAnswer((_) => Future.value({'message': 'success'}));

      final res = await api.fetchSendAmount(amount: 200.00);

      await home.sendAmount(
        amount: 200.00,
        onComplete: () => onCompleteCalled = res.isNotEmpty,
      );

      expect(onCompleteCalled, isTrue);
    });

    test('fetching transaction history', () async {
      when(api.fetchTransactionHistory()).thenAnswer(
        (_) => Future.value(
          [
            {
              'id': '1',
              'amount': 200,
              'date_transaction': '2025-1-31',
            },
            {
              'id': '2',
              'amount': 300,
              'date_transaction': '2025-1-31',
            },
            {
              'id': '3',
              'amount': 500,
              'date_transaction': '2025-2-2',
            },
          ],
        ),
      );

      final list = await home.getTransactionHistory();

      expect(list, isNotEmpty);
    });
  });
}
