import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:intl/intl.dart' as intl;

class PurchasePage extends flutter.StatefulWidget {
  const PurchasePage({flutter.Key? key}) : super(key: key);

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends flutter.State<PurchasePage> {
  String _selectedPaymentOption = 'درج النقديه';
  flutter.TextEditingController dateController =
      flutter.TextEditingController();

  @override
  flutter.Widget build(flutter.BuildContext context) {
    return flutter.Directionality(
      textDirection:
          flutter.TextDirection.rtl, // Setting text direction correctly
      child: flutter.Scaffold(
        backgroundColor: const flutter.Color(0xFFF0F0F0),
        body: flutter.Container(
          padding: const flutter.EdgeInsets.all(16.0),
          child: flutter.SafeArea(
            child: flutter.Column(
              children: [
                _buildHeader(context),
                const flutter.SizedBox(height: 16),
                flutter.Expanded(
                  child: flutter.Row(
                    crossAxisAlignment: flutter.CrossAxisAlignment.start,
                    children: [
                      flutter.Expanded(
                        child: flutter.Column(
                          children: [
                            _buildSearchAndInputs(),
                            const flutter.SizedBox(height: 16),
                            flutter.Expanded(child: _buildDataTable()),
                          ],
                        ),
                      ),
                      const flutter.SizedBox(width: 16),
                      _buildSideButtons(),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: const Color(0xFFF0F0F0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.close,
                size: 18, color: Colors.black), // Close icon
            label: const Text('شراء'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              minimumSize: const Size(80, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset('./assets/close.png',
                height: 20), // Close icon image
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

  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[100], // Matching background color
            borderRadius: BorderRadius.circular(8), // Rounded corners
            border: Border.all(color: Colors.transparent), // Remove border
          ),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: dateController,
                textAlign: TextAlign.right,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(fontSize: 14),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'التاريخ', // Hint text in Arabic
                  hintStyle: TextStyle(
                    color: Colors.grey[900],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16), // Adjusted vertical padding
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.calendar_today, size: 20),
              ),
            ),
          ]),
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
        dateController.text = intl.DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget _buildSearchAndInputs() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ابحث عن اسم الصنف',
                      suffixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Replacing 'التاريخ' field with buildDateField
              Expanded(
                child: buildDateField(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildTextField('الحساب'),
                    const SizedBox(height: 8),
                    _buildTextField('الملاحظات'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 407,
                child: _buildPaymentOptions(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: _buildTextField('الكميه')),
                            const SizedBox(width: 16),
                            Expanded(child: _buildTextField('خصم')),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(child: _buildTextField('شراء')),
                            const SizedBox(width: 16),
                            Expanded(child: _buildTextField('نوع الاضافه')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 401,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton(
                          'تعديل الكمية',
                          Image.asset('./assets/Shopping.png',
                              width: 24, height: 24),
                          () => showInputWidget(context),
                        ),
                        _buildActionButton(
                          'تعديل سعر الصنف',
                          Image.asset('./assets/localOffer.png',
                              width: 24, height: 24),
                          () => showInputWidget1(context),
                        ),
                        _buildActionButton(
                          'المزيد',
                          Image.asset('./assets/icmore.png',
                              width: 24, height: 24),
                          () => showInputWidget2(context),
                        ),
                        _buildActionButton(
                          'حذف الصنف',
                          Image.asset('./assets/delete.png',
                              width: 24, height: 24),
                          () => print('حذف الصنف button pressed'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Row(
      children: [
        for (var option in ['اجل', 'الخزينه', 'بطاقه الاتمان', 'درج النقديه'])
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedPaymentOption = option;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedPaymentOption == option
                    ? const Color(0xFFFCC50E)
                    : const Color(0xFFDEE2E6),
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(option, style: const TextStyle(fontSize: 12)),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildActionButton(
      String buttonText, Widget iconImage, VoidCallback onPressed) {
    return Container(
      width: 86,
      height: 90, // Increased height to prevent overflow
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE9F9F0),
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.4),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replaced Icon with the Image widget
            const SizedBox(height: 8), // Reduced spacing between icon and text
            Text(
              buttonText,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis, // Prevents text overflow
              maxLines: 1, // Limits the text to a single line
              style: const TextStyle(
                  fontSize: 11), // Reduced font size to fit better
            ),
            iconImage,
          ],
        ),
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width *
                0.85, // Adjusts width to fit columns
          ),
          child: DataTable(
            columnSpacing: 1, // Increased spacing for better readability
            headingRowColor: WidgetStateProperty.all(const Color(0xFFF6F6F6)),
            columns: columns
                .map((column) => DataColumn(
                      label: Text(
                        column,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
                .toList(),
            rows: List.generate(
              10,
              (index) => DataRow(
                cells: List.generate(
                  10,
                  (cellIndex) =>
                      const DataCell(Text('')), // Example empty cells
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSideButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 280,
          height: 44,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('شراء'),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 280,
          height: 44,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset('./assets/correct.png', height: 20),
            label: const Text('حفظ / جديد'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFCC50E),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
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

class EnterTheQuantityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 489,
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC00),
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
              SizedBox(
                width: 106,
                height: 34.64,
                child: ElevatedButton.icon(
                  onPressed: () {
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
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                ),
              ),
              const SizedBox(width: 150),
              SizedBox(
                width: 106,
                height: 34.64,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for "موافق" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B955),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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

class EnterTheNewPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 489,
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC00),
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
              SizedBox(
                width: 106,
                height: 34.64,
                child: ElevatedButton.icon(
                  onPressed: () {
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
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                ),
              ),
              const SizedBox(width: 150),
              SizedBox(
                width: 106,
                height: 34.64,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for "موافق" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B955),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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

class InputWidgetWithDiscount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 489,
      height: 380,
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC00),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'اسم الصنف-90',
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                fontSize: 24,
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
              SizedBox(
                width: 106,
                height: 34.64,
                child: ElevatedButton.icon(
                  onPressed: () {
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
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ),
                ),
              ),
              const SizedBox(width: 150),
              SizedBox(
                width: 106,
                height: 34.64,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for "موافق" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B955),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
