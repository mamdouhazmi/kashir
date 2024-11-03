import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseAnalysisScreen extends StatefulWidget {
  const ExpenseAnalysisScreen({Key? key}) : super(key: key);

  @override
  _ExpenseAnalysisScreenState createState() => _ExpenseAnalysisScreenState();
}

class _ExpenseAnalysisScreenState extends State<ExpenseAnalysisScreen> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: topBar(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'تحليل المصروفات',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9A00),
                  ),
                ),
                const SizedBox(height: 32),
                Row(children: [
                  Expanded(
                    flex: 10,
                    child: buildDateField(label: 'التاريخ'),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'الي',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: buildDateField(label: 'التاريخ'),
                  ),
                ]),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: inputField(label: 'الحساب'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: inputField(label: 'اسم البند'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: inputField(label: 'الخزينه او البنك'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.grey, thickness: 1),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: dataTable(
                        'مدفوعات الموردين',
                        ['الاجمالي', 'الحساب', 'رقم الحساب'],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: dataTable(
                        'بنود المصروفات',
                        ['الاجمالي', 'البند', 'رقم الحساب'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          closeButton(context),
          const Text(
            'شراء',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F9F0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset('./assets/close.png', height: 20),
            const SizedBox(width: 8),
            const Text(
              'اغلاق',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: const Icon(Icons.calendar_today, size: 20),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: dateController,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(fontSize: 14),
                  readOnly: true,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget inputField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const TextField(
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget dataTable(String title, List<String> headers) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFFF9A00),
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: const Color(0xFFFFEBCC),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: headers
                  .map((header) => Text(
                        header,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                  .toList(),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('كرتونه'),
                  Text('اسم المالك-120 ملل'),
                  Text('1'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
