import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الفواتير',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InvoicePage(),
    );
  }
}

class InvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الفواتير', style: TextStyle(fontSize: 24)),
          actions: [
            IconButton(icon: const Icon(Icons.close), onPressed: () {}),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'ملخص'),
              Tab(text: 'بيع'),
              Tab(text: 'شراء'),
              Tab(text: 'قبض'),
              Tab(text: 'صرف'),
              Tab(text: 'جرد مخزن'),
              Tab(text: 'تحويل مخزن'),
              Tab(text: 'تسوية مخزن'),
            ],
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'التاريخ من',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'التاريخ إلى',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('رقم الصنف')),
                    DataColumn(label: Text('اسم الصنف')),
                    DataColumn(label: Text('الوحدة')),
                    DataColumn(label: Text('الكميات المتاحة')),
                    DataColumn(label: Text('سعر البيع')),
                    DataColumn(label: Text('الخصم')),
                    DataColumn(label: Text('آخر سعر شراء')),
                    DataColumn(label: Text('متوسط سعر الشراء')),
                    DataColumn(label: Text('تصنيف الصنف')),
                    DataColumn(label: Text('متوسط سعر البيع')),
                  ],
                  rows: List<DataRow>.generate(
                    20,
                    (index) => const DataRow(
                      cells: [
                        DataCell(Text('1')),
                        DataCell(Text('اسم الصنف - 120 متر')),
                        DataCell(Text('كرتونة')),
                        DataCell(Text('155555555')),
                        DataCell(Text('78')),
                        DataCell(Text('78')),
                        DataCell(Text('78')),
                        DataCell(Text('78')),
                        DataCell(Text('78')),
                        DataCell(Text('78')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
