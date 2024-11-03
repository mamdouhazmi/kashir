import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedTab = 'عام';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 975,
      height: 660,
      decoration: BoxDecoration(
        color: const Color(0xFFE9F9F0),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topBar(context),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    sectionHeader('المشروع'),
                    const SizedBox(height: 10),
                    inputSection([
                      inputField('اسم المشروع', width: 900, height: 30),
                      const SizedBox(height: 10),
                      inputField(
                          'بيانات الاتصال ( العنوان , التليفون ,تظهر في طباعه الفواتير )',
                          width: 900,
                          height: 30),
                      const SizedBox(height: 10),
                      inputField('', width: 900, height: 30),
                      const SizedBox(height: 10),
                      inputField('', width: 900, height: 30),
                    ]),
                    const SizedBox(height: 20),
                    sectionHeader('الضرائب'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      children: [
                        labeledInputField('رقم التسجيل التجاري',
                            width: 420, height: 30),
                        labeledInputField('الرقم الضريبي',
                            width: 420, height: 30),
                        labeledInputField('نسبة الضريبة',
                            width: 420, height: 30),
                        labeledInputField('اسم الضريبة',
                            width: 420, height: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          closeButton(context),
          Expanded(child: tabBar()),
          settingsButton(),
        ],
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFFFCC50E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.close, color: Colors.black, size: 16),
            SizedBox(width: 5),
            Text(
              'اغلاق',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    List<String> tabs = [
      'اعدادات المطعم',
      'اخري',
      'كلمات السر',
      'الضرائب',
      'حقول اضافية',
      'عام',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: tabs.map((label) {
        bool isSelected = label == selectedTab;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTab = label;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFFF9A00)
                  : const Color(0xFFFFFFFF).withOpacity(0.8),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF000000).withOpacity(0.8)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget settingsButton() {
    return const Text(
      'الاعدادات',
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFF9A00)),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF9A00)),
      ),
    );
  }

  Widget inputSection(List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: fields,
    );
  }

  Widget labeledInputField(String label,
      {double width = 420, double height = 30}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const TextField(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(height: 1),
            decoration: InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget inputField(String label, {double width = 900, double height = 30}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const TextField(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(height: 1),
            decoration: InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
            ),
          ),
        ),
      ],
    );
  }
}
