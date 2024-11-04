import 'package:flutter/material.dart';
import 'package:kashir/presentation/AccountPage.dart';
import 'package:kashir/presentation/AdjustingSellingPrices.dart';
import 'package:kashir/presentation/CashierScreen.dart';
import 'package:kashir/presentation/ItemInputScreen.dart';
import 'package:kashir/presentation/ProductEntryScreen.dart';
import 'package:kashir/presentation/ProductReport.dart';
import 'package:kashir/presentation/TheGoods.dart';
import 'package:kashir/presentation/ExpenseAnalysisScreen.dart';
import 'package:kashir/presentation/ExpensePage.dart';
import 'package:kashir/presentation/HomePage.dart';
import 'package:kashir/presentation/PurchasePage.dart';
import 'package:kashir/presentation/SellPage.dart';
import 'package:kashir/presentation/StoreInventoryPage.dart';
import 'package:kashir/presentation/salepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/account': (context) => const AccountScreen(),
        '/Cashier': (context) => const CashierScreen(),
        '/purchase': (context) => const PurchasePage(),
        '/sale': (context) => const SalePage(),
        '/sell': (context) => const SellPopup(),
        '/expense': (context) => const ExpensePopup(),
        '/expenseAnalysis': (context) => const ExpenseAnalysisScreen(),
        '/storeInventory': (context) => const StoreinventoryPage(),
        '/theGoods': (context) => const TheGoods(),
        '/productEntry': (context) => const ProductEntryScreen(),
        '/itemInput': (context) => const ItemInputScreen(),
        '/cashier': (context) => const CashierScreen(),
        '/SellingPrices': (context) => const AdjustingSellingPrices(),
        '/ProductReport': (context) => const ProductMovementReport(),
      },
    );
  }
}
