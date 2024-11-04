import 'package:flutter/material.dart';
import 'package:kashir/presentation/ExpensePage.dart';
import 'package:kashir/presentation/SellPage.dart';
import 'package:kashir/presentation/SettingsScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLightMode = "Light";
  String selectedLanguage = "العربية";
  String? selectedButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF0F0F0), // AppBar color
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5), // Spacing within the box
              color: Colors.white, // White background for only the content area
              child: const Row(
                children: [
                  Text(
                    'البضاعه',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10), // Spacing between the text and icons
                  Icon(Icons.home, size: 24, color: Colors.black),
                  SizedBox(width: 10),
                  Icon(Icons.close, size: 24, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdowns at the top
              Row(
                children: [
                  Flexible(
                    child: dropDownButton(
                      "وضع الاضاءه",
                      [
                        {'label': 'Light', 'icon': Icons.wb_sunny},
                        {'label': 'Dark', 'icon': Icons.nightlight_round},
                      ],
                      (value) {
                        setState(() {
                          selectedLightMode = value!;
                        });
                      },
                      selectedLightMode,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: dropDownButton(
                      "العربية",
                      [
                        {'label': 'العربية', 'icon': Icons.language},
                        {'label': 'الانجليزية', 'icon': Icons.translate},
                      ],
                      (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      },
                      selectedLanguage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset('./assets/flame_logo.png'),
                    const SizedBox(height: 50),
                    // 4 rows with 3 buttons in each row, except for the last row which has 2 buttons
                    buildButtonRow([
                      buildButton('شراء', './assets/Maskgroup.png',
                          onPressed: () {
                        Navigator.pushNamed(context, '/expenseAnalysis');
                      }),
                      buildButton(
                        'بيع',
                        './assets/foundation_burst-sale.png',
                        onPressed: () {
                          // Navigate to the AccountScreen

                          Navigator.pushNamed(context, '/purchase');
                        },
                      ),
                      buildButton(
                        'الاصناف',
                        './assets/carbon.png',
                        onPressed: () {
                          // Navigate to the AccountScreen
                          Navigator.pushNamed(context, '/theGoods');
                        },
                      ),
                    ]),
                    buildButtonRow([
                      buildButton(
                        'البضاعة',
                        './assets/goods-delivery.png',
                        onPressed: () {
                          // Navigate to the AccountScreen
                          Navigator.pushNamed(context, '/theGoods');
                        },
                      ),
                      buildButton(
                        'الحسابات',
                        './assets/carbon.png',
                        onPressed: () {
                          // Navigate to the AccountScreen
                          Navigator.pushNamed(context, '/account');
                        },
                      ),
                      buildButton(
                        'الكاشير',
                        './assets/Vector.png',
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/Cashier'); // This should navigate to SalePage
                        },
                      ),
                    ]),
                    buildButtonRow([
                      buildButton(
                        'مرتجع بيع',
                        './assets/Vector.png',
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/sale'); // This should navigate to SalePage
                        },
                      ),
                      buildButton('سند قبض', './assets/Vector.png',
                          onPressed: () => showExpensePopup(context)),

                      buildButton('سند بيع', './assets/Vector.png',
                          onPressed: () => showSellPopup(context))
                      // This should now work fine
                    ]),
                    buildButtonRow([
                      buildButton('اعداد شعله', './assets/settings.png',
                          onPressed: () => showSettingsScreen(context)),
                      buildButton(
                        'جرد المخزن',
                        './assets/Store.png',
                        onPressed: () {
                          // Navigate to the AccountScreen
                          Navigator.pushNamed(context, '/storeInventory');
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text, String iconPath, {VoidCallback? onPressed}) {
    bool isHighlighted = selectedButton == text;
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
        setState(() {
          selectedButton = text;
        });
      },
      child: Container(
        width: 129, // Fixed width as specified
        height: 136.2, // Fixed height as specified
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.fromLTRB(0, 10.8, 0, 0), // Specified padding
        decoration: BoxDecoration(
          color:
              isHighlighted ? const Color(0xFFFF9A00) : const Color(0xFFE9F9F0),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(17.28),
            topRight: Radius.circular(17.28),
            bottomLeft: Radius.circular(17.28),
            bottomRight: Radius.circular(17.28),
          ), // Custom border-radius as specified
        ),
        child: Column(
          children: [
            Image.asset(iconPath, height: 54),
            const SizedBox(height: 16.2), // Specified gap between icon and text
            Text(
              text,
              style: TextStyle(
                fontSize: 21.6,
                fontWeight: FontWeight.bold,
                color: isHighlighted ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonRow(List<Widget> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons.map((button) {
        return Flexible(
          flex: 1,
          child: button,
        );
      }).toList(),
    );
  }

  Widget dropDownButton(String text, List<Map<String, dynamic>> options,
      Function(String?) onChanged, String currentValue) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        value: currentValue,
        icon: Image.asset('./assets/Arraw.png', height: 12),
        underline: const SizedBox(),
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option['label'],
            child: Row(
              children: [
                Icon(option['icon'],
                    size: 18, color: Colors.black.withOpacity(0.6)),
                const SizedBox(width: 8),
                Text(
                  option['label'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void showSellPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.white,
      builder: (BuildContext context) {
        return const Positioned(
          top: 95,
          left: 236,
          child: SellPopup(),
        );
      },
    );
  }

  void showExpensePopup(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.white,
      builder: (BuildContext context) {
        return const Positioned(
          top: 95,
          left: 236,
          child: ExpensePopup(),
        );
      },
    );
  }

  void showSettingsScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const SettingsScreen(),
        );
      },
    );
  }
}
