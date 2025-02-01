import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:send_money_application/features/home/provider/home_provider.dart';
import 'package:send_money_application/services/notification_service.dart';
import 'package:send_money_application/services/progress_overlay_service.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Send Money',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          color: Colors.grey.shade300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildAmountField(context),
                const SizedBox(
                  height: 20,
                ),
                _buildSubmitButton(context),
              ],
            ),
          ),
        ),
      );

  Widget _buildAmountField(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Enter amount',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
        ),
      );

  Widget _buildSubmitButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF8DC63F))),
                onPressed: () {
                  ProgressOverlayService().show(
                    context: context,
                    builder: () => context.read<HomeProvider>().sendAmount(
                          amount:
                              double.tryParse(_amountController.text) ?? 0.0,
                          onComplete: () => NotificationService()
                              .notifyWithScaffold(
                                  context: context,
                                  message:
                                      'Transaction Successful! Money has been sent.',
                                  bgColor: Colors.green),
                        ),
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      );
}
