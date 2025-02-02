import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_application/features/login/provider/login_provider.dart';
import 'package:send_money_application/services/api_service.dart';

import 'login_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('Login Provider', () {
    late ApiService api;
    late LoginProvider provider;

    setUp(() {
      api = MockApiService();
      provider = LoginProvider();
    });

    test('calls onComplete when login is successful', () async {
      /// Arrange
      when(api.fetchLogin(
        username: 'test123',
        password: 'test123',
      )).thenAnswer((_) => Future.value({'message': 'success'}));

      bool onCompleteCalled = false;

      /// Act
      await provider.login(
        username: 'test123',
        password: 'test123',
        onComplete: () => onCompleteCalled = true,
      );

      /// Assert
      expect(onCompleteCalled, isTrue);
    });

    test('calls onFailed when username or password doesn`t match', () async {
      /// Arrange
      when(api.fetchLogin(
        username: 'test',
        password: 'wrong_password',
      )).thenAnswer((_) =>
          Future.value({"message": "username or password doesn`t match.."}));

      bool onFailedCalled = false;

      /// Act
      await provider.login(
        username: 'test',
        password: 'wrong_password',
        onFailed: () => onFailedCalled = true,
      );

      /// Assert
      expect(onFailedCalled, isTrue);
    });
  });
}
