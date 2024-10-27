import 'package:flutter/material.dart';

class SellPage extends StatelessWidget {
  const SellPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Row(
          mainAxisAlignment:
              MainAxisAlignment.end, // Move the title to the right
          children: [
            Text(
              'البيع',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                header(),
                const SizedBox(height: 20),
                formSection(screenWidth),
                const SizedBox(height: 20),
                bottomButtons(context, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      width: 219,
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF00B955),
      child: const Text(
        'بيع',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget formSection(double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F9F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          inputField(label: 'الخزينه'),
          const SizedBox(height: 10),
          inputField(label: 'المرجع'),
          const SizedBox(height: 10),
          inputField(label: 'بند المصروفات'),
          const SizedBox(height: 10),
          inputField(label: 'رقم الحركه'),
          const SizedBox(height: 20),
          tabBar(),
          const SizedBox(height: 20),
          inputField(label: 'المبلغ'),
          const SizedBox(height: 10),
          inputField(label: 'التاريخ'),
          const SizedBox(height: 10),
          inputField(label: 'الحساب'),
          const SizedBox(height: 10),
          inputField(label: 'الملاحظات'),
        ],
      ),
    );
  }

  Widget inputField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  Widget tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        tab(
            label: 'الفواتير المستحقة',
            color: const Color(0xFFF9F9F9),
            fontColor: const Color(0xFFFF9A00)),
        tab(
            label: 'عام',
            color: const Color(0xFFFCC50E),
            fontColor: Colors.white),
      ],
    );
  }

  Widget tab(
      {required String label, required Color color, required Color fontColor}) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: fontColor),
      ),
    );
  }

  Widget bottomButtons(BuildContext context, double screenWidth) {
    return Container(
      width: 851, // Fixed width
      padding: const EdgeInsets.symmetric(vertical: 10), // Adjusted height
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Space between buttons
        children: [
          button(
              label: 'اغلاق',
              icon: './assets/close.png',
              action: () {
                Navigator.of(context).pop();
              }),
          button(
              label: 'حفظ / جديد', icon: './assets/correct.png', action: () {}),
        ],
      ),
    );
  }

  Widget button(
      {required String label,
      required String icon,
      required VoidCallback action}) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(icon, height: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
