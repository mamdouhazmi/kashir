import 'package:flutter/material.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  String _selectedPaymentOption = 'درج النقديه';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0F0), // Light grey background color
        body: Container(
          padding:
              const EdgeInsets.all(16.0), // Added padding for better layout
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(
                    height: 16), // Added space between header and buttons
                _buildActionButtons(),
                const SizedBox(
                    height: 16), // Added space between buttons and content
                Expanded(
                  child: Row(
                    // Replace Expanded with Row for alignment
                    children: [
                      Expanded(
                        child:
                            _buildMainContent(), // Main content takes the remaining space
                      ),
                      _buildBottomSection(), // Buttons will now be on the right side
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              for (var tab in ['شراء', 'Tab 2', 'Tab 3', 'Tab 4'])
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(tab),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tab == 'شراء'
                          ? const Color(0xFF0D99FF)
                          : Colors.white,
                      foregroundColor:
                          tab == 'شراء' ? Colors.white : Colors.black,
                      elevation: 0,
                      minimumSize: const Size(80, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: tab == 'شراء'
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset('./assets/close.png', height: 20),
            label: const Text('اغلاق'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              backgroundColor: const Color(0xFFE9F9F0),
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(80, 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final actions = [
      {
        'label': 'تعديل الكمية',
        'icon': Icons.shopping_cart,
        'onPressed': () {
          // Action for 'تعديل الكمية'
          showInputWidget(context);
          // Add your specific logic here
        },
      },
      {
        'label': 'تعديل سعر الصنف',
        'icon': Icons.local_offer,
        'onPressed': () {
          // Action for 'تعديل سعر الصنف'
          showInputWidget1(context);
          // Add your specific logic here
        },
      },
      {
        'label': 'المزيد',
        'icon': Icons.more_horiz,
        'onPressed': () {
          // Action for 'المزيد'
          showInputWidget2(context);
          // Add your specific logic here
        },
      },
      {
        'label': 'حذف الصنف',
        'icon': Icons.delete,
        'onPressed': () {
          // Action for 'حذف الصنف'
          print('حذف الصنف button pressed');
          // Add your specific logic here
        },
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actions.map((action) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: action['onPressed']
                  as VoidCallback?, // Assign specific action
              icon: Icon(action['icon'] as IconData, size: 20),
              label: Text(action['label'] as String),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE9F9F0),
                foregroundColor: Colors.black,
                elevation: 0,
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFormFields(),
        const SizedBox(height: 16),
        _buildPaymentOptions(),
        const SizedBox(height: 16),
        Expanded(child: _buildDataTable()),
      ],
    );
  }

  Widget _buildFormFields() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن اسم الصنف',
                    suffixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'التاريخ',
                    suffixIcon: const Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'الحساب',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'الملاحظات',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions() {
    final options = ['اجل', 'الخزينه', 'بطاقه الاتمان', 'درج النقديه'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: options.map((option) {
          final isSelected = option == _selectedPaymentOption;
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedPaymentOption = option;
                });
              },
              child: Text(option),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected
                    ? const Color(0xFFFCC50E)
                    : const Color(0xFFDEE2E6),
                foregroundColor: Colors.black,
                elevation: 0,
                minimumSize: const Size(90, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDataTable() {
    final columns = [
      'رقم الحساب',
      'اسم الحساب',
      'الوحده',
      'الكميات المتاحه',
      'سعر البيع',
      'الخصم',
      'اقل سعر',
      'متوسط سعر الشراء',
      'اخر سعر الشراء',
      'تصنيف الصنف'
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 16,
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF6F6F6)),
          columns:
              columns.map((column) => DataColumn(label: Text(column))).toList(),
          rows: List.generate(
            10,
            (index) => DataRow(
              cells: List.generate(
                10,
                (cellIndex) => DataCell(Text('Sample')),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.end, // Align to the right side
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16), // Adjust the padding
          child: SizedBox(
            width: 280, // Fixed width
            height: 44, // Fixed height
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('شراء'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28.5), // Space between buttons
        Padding(
          padding: const EdgeInsets.only(right: 16), // Adjust the padding
          child: SizedBox(
            width: 280, // Fixed width
            height: 44, // Fixed height
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFCC50E),
                foregroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Aligns icon and text in the center
                children: [
                  // Add the icon
                  const SizedBox(
                      width: 8), // Add space between the icon and the text
                  const Text('حفظ / جديد'), // The text next to the icon
                  Image.asset('./assets/correct.png', height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EnterTheQuantityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 489,
      height: 280, // Increased height to accommodate buttons
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC00), // Yellow background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ادخل الكميه',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 106,
                height: 34.64,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add functionality for "رجوع" button
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset('assets/pajamas_go-back.png',
                      width: 20, height: 20),
                  label: const Text(
                    'رجوع',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9F9F0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                ),
              ),
              const SizedBox(width: 150),
              Container(
                width: 106,
                height: 34.64,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for "موافق" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B955),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  child: const Text(
                    'موافق',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
// Space between buttons
            ],
          ),
        ],
      ),
    );
  }
}

class EnterTheNewPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 489,
      height: 280, // Increased height to accommodate buttons
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC00), // Yellow background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ادخل السعر الجديد',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 106,
                height: 34.64,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add functionality for "رجوع" button
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset('assets/pajamas_go-back.png',
                      width: 20, height: 20),
                  label: const Text(
                    'رجوع',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9F9F0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                ),
              ),
              const SizedBox(width: 150),
              Container(
                width: 106,
                height: 34.64,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for "موافق" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B955),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  child: const Text(
                    'موافق',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
// Space between buttons
            ],
          ),
        ],
      ),
    );
  }
}

class InputWidgetWithDiscount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 489,
      height: 380, // Increased height to accommodate new input boxes
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC00), // Yellow background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20), // Added space before heading
            child: Text(
              'اسم الصنف-90', // Heading label
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                fontSize: 24, // Adjusted font size for the heading
                color: Color(0xFFF9F9F9),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 40, bottom: 8),
                      child: Text(
                        'ادخل نسبه الخصم',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: 36,
                      margin: const EdgeInsets.only(left: 40, right: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 40, bottom: 8),
                      child: Text(
                        'او قيمه الخصم',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: 36,
                      margin: const EdgeInsets.only(left: 10, right: 40),
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'ادخل السيريال نمبر',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 106,
                height: 34.64,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add functionality for "رجوع" button
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset('assets/pajamas_go-back.png',
                      width: 20, height: 20),
                  label: const Text(
                    'رجوع',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9F9F0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                ),
              ),
              const SizedBox(width: 150),
              Container(
                width: 106,
                height: 34.64,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for "موافق" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B955),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  child: const Text(
                    'موافق',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showInputWidget2(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InputWidgetWithDiscount(),
      );
    },
  );
}

void showInputWidget1(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: EnterTheNewPriceWidget(),
      );
    },
  );
}

void showInputWidget(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: EnterTheQuantityWidget(),
      );
    },
  );
}
