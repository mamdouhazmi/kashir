import 'package:flutter/material.dart';

class ExpenseAnalysisScreen extends StatelessWidget {
  const ExpenseAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Adjust height if needed
        child: topBar(context), // Use the topBar as AppBar
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0), // Reduced padding to reduce space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10), // Reduced space after top bar
                  const Text(
                    'تحليل المصروفات',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 48, // Font size retained
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF9A00),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Reduced space before input fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      inputField(label: 'الحساب', width: screenWidth * 0.18),
                      const SizedBox(
                          width: 16), // Space between input fields retained
                      inputField(label: 'اسم البند', width: screenWidth * 0.18),
                      const SizedBox(width: 16),
                      inputField(
                          label: 'الخزينه او البنك', width: screenWidth * 0.18),
                      const SizedBox(width: 16),
                      inputField(label: 'التاريخ', width: screenWidth * 0.18),
                    ],
                  ),
                  const SizedBox(height: 20), // Reduced space before divider
                  const Divider(thickness: 1.5),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dataColumn('مدفوعات الموردين',
                          screenWidth * 0.45), // Column width retained
                      dataColumn('بنود المصروفات', screenWidth * 0.45),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Removes default back button
      backgroundColor: Colors.white, // Change background color if needed
      elevation: 0, // Remove shadow
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            closeButton(context),
            const Text(
              'شراء',
              style: TextStyle(
                fontSize: 28, // Adjusted font size for top bar
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F9F0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset('./assets/close.png', height: 24),
            const SizedBox(width: 5),
            const Text(
              'اغلاق',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputField({required String label, required double width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
          const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget dataColumn(String title, double width) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFFFF9A00),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          ...List.generate(
            10,
            (index) => Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 12), // Increased padding retained
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: const BorderSide(color: Color(0xFFF0F0F0)),
                  left: const BorderSide(color: Color(0xFFF0F0F0)),
                  right: const BorderSide(color: Color(0xFFF0F0F0)),
                  bottom: index == 9
                      ? const BorderSide(color: Color(0xFFF0F0F0))
                      : BorderSide.none,
                ),
              ),
              child: Text('بيانات $index',
                  style: const TextStyle(fontSize: 14)), // Font size retained
            ),
          ),
        ],
      ),
    );
  }
}
