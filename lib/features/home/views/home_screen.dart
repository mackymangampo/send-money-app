import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_money_application/features/home/provider/home_provider.dart';
import 'package:send_money_application/features/login/views/login_screen.dart';
import 'package:send_money_application/features/home/views/send_money_screen.dart';
import 'package:send_money_application/features/home/views/transaction_history_screen.dart';
import 'package:send_money_application/services/progress_overlay_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen() : super(key: const Key('home_screen'));

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home View',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ProgressOverlayService().show(
                    context: context,
                    builder: () async => context.read<HomeProvider>().logout(
                          onComplete: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        ));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: context.read<HomeProvider>().getBalances(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.data;

            double balance = 0.00;

            if (data?['balance'] != null) {
              balance = data?['balance'];
            }

            return Container(
              color: Colors.grey.shade300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildBalance(context, balance: balance),
                    _buildActions(context),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget _buildBalance(BuildContext context, {required double balance}) =>
      Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final balanceVisible = provider.balanceVisible;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Text(
                  balanceVisible ? 'Balance: ₱$balance' : 'Balance: ******',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () => provider.setHideBalance(!balanceVisible),
                child: Icon(
                  balanceVisible ? Icons.visibility : Icons.visibility_off,
                  size: 30,
                ),
              ),
            ],
          );
        },
      );

  Widget _buildActions(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF8DC63F))),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SendMoneyScreen(),
                      ),
                    ),
                    child: const Text(
                      'Send Money',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionHistoryScreen(),
                      ),
                    ),
                    child: const Text(
                      'View Transactions',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
