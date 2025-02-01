import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProgressOverlayService {
  static TransitionBuilder init({
    required Widget Function(BuildContext context, Widget? child) builder,
  }) =>
      EasyLoading.init(
        builder: (context, child) => builder.call(context, child),
      );

  Future<T> show<T>({
    required BuildContext context,
    required Future<T> Function() builder,
  }) async {
    /// setup options
    _setup(context);

    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
    );

    /// call the future and wait
    try {
      final result = await builder.call();

      return result;
    } catch (_, __) {
      rethrow;
    } finally {
      /// dismiss the dialog
      await EasyLoading.dismiss();
    }
  }

  void _setup(BuildContext? context) {
    if (context == null) {
      return;
    }

    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.transparent
      ..textColor = Colors
          .transparent // does not do anything just for the sake of constraint in the library
      ..textStyle = Theme.of(context).textTheme.bodyMedium
      ..boxShadow = []
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor =
          Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4);
  }
}
