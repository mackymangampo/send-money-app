import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_money_application/features/home/provider/home_provider.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen()
      : super(key: const Key('transaction_history'));

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transaction History',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            color: Colors.grey.shade300,
            child: FutureBuilder(
                future: context.read<HomeProvider>().getTransactionHistory(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final data = snapshot.data;

                  if (data == null) {
                    return const SizedBox.shrink();
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final transaction = data[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text('Amount: ₱${transaction['amount']}'),
                          subtitle: Text(
                              'Date Transaction: ${transaction['date_transaction']}'),
                        ),
                      );
                    },
                  );
                }))),
      );
}
