import 'package:flutter/material.dart';
import 'package:rateioapp/src/screens/rateio_proporcional.dart';
import 'package:rateioapp/src/screens/rateio_simples.dart';

import '../widgets/dialog_help.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculo de Rateio'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return const DialogHelp();
                  },
                );
              },
              icon: const Icon(
                Icons.help,
                color: Colors.white,
              ),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.account_balance_wallet),
                text: "Rateio Simples",
              ),
              Tab(
                icon: Icon(Icons.account_balance),
                text: "Rateio Proporcional",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RateioSimples(),
            RateioProporcionalScreen(),
          ],
        ),
      ),
    );
  }
}
