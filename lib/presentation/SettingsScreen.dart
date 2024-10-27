import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedTab = 'عام'; // Tracks the currently selected tab

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE9F9F0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    topBar(context),
                    const SizedBox(height: 20),
                    sectionHeader('المشروع'),
                    inputSection([
                      inputField('اسم المشروع',
                          width: 484, height: 26), // Input field method added
                      inputField('', width: 484, height: 26),
                      inputField(
                          'بيانات الاتصال ( العنوان , التليفون ,تظهر في طباعه الفواتير )',
                          width: 484,
                          height: 26),
                      inputField('', width: 484, height: 26),
                      inputField('', width: 484, height: 26),
                    ]),
                    const SizedBox(height: 20),
                    sectionHeader('الضرائب'),
                    inputSection([
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Centering content horizontally
                        children: [
                          Row(
                            mainAxisSize:
                                MainAxisSize.min, // Keep row size minimal
                            children: [
                              labeledInputField('رقم التسجيل التجاري',
                                  width: 225, height: 26),
                              const SizedBox(width: 10), // Space between fields
                              labeledInputField('الرقم الضريبي',
                                  width: 225, height: 26),
                            ],
                          ),
                          const SizedBox(height: 10), // Space between rows
                          Row(
                            mainAxisSize:
                                MainAxisSize.min, // Keep row size minimal
                            children: [
                              labeledInputField('نسبة الضريبة',
                                  width: 225, height: 26),
                              const SizedBox(width: 10), // Space between fields
                              labeledInputField('اسم الضريبة',
                                  width: 225, height: 26),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
        child: Row(
          children: [
            Image.asset('./assets/close.png', height: 16),
            const SizedBox(width: 5),
            const Text(
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

  // Updated to handle button selection and color change
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
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFFF9A00)
                  : const Color(0xFFFFFFFF).withOpacity(
                      0.8), // Updated selected and unselected colors
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
      children: fields,
    );
  }

  // Adjusted labeledInputField to match the small size for smaller fields
  Widget labeledInputField(String label,
      {double width = 225, double height = 26}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.end, // Align text outside to the right
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 6), // Updated padding
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField(String label, {double width = 484, double height = 26}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.end, // Align text outside to the right
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 6), // Updated padding
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
