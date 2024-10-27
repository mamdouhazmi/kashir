import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kashir/presentation/ItemInputScreen.dart';

class AdjustingSellingPrices extends StatefulWidget {
  const AdjustingSellingPrices({Key? key}) : super(key: key);

  @override
  _AdjustingSellingPricesState createState() => _AdjustingSellingPricesState();
}

class _AdjustingSellingPricesState extends State<AdjustingSellingPrices> {
  String selectedFactory = 'المصنع';
  String selectedBrand = 'الماركة';
  String selectedLightMode = "Light";
  String selectedLanguage = "العربية";
  String selectedClassification = 'التصنيف';
  bool showInactiveAccounts = false;
  bool hideZeroBalances = false;
  bool showAccountsUnderReview = false;
  Map<String, bool> buttonStates = {};

  String calculationMethod = '';
  String calculationBase = '';
  Map<String, bool> selectedFields = {
    'سعر البيع': false,
    'سعر الجمله': false,
    'اقل سعر': false,
  };
  Map<String, TextEditingController> fieldControllers = {
    'سعر البيع': TextEditingController(),
    'سعر الجمله': TextEditingController(),
    'اقل سعر': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildMainContent(),
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: _buildHeaderButton(
                    './assets/close.png',
                    'اغلاق',
                    () {
                      Navigator.of(context).pop();
                    },
                    context,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: _buildHeaderButton(
                    './assets/icon-park-solid_update-rotation.png',
                    'تحديث',
                    () {
                      print("تحديث clicked");
                    },
                    context,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: _buildHeaderButton(
                    './assets/correct.png',
                    'حفظ',
                    () {},
                    context,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 250),
          const Flexible(
            child: Text(
              'تعديل اسعار البيع ',
              style: TextStyle(
                color: Color(0xFFFF9A00),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.end, // Changed from start to end
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildDataTable(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(
      String icon, String label, VoidCallback onTap, BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Image.asset(icon, width: 24, height: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE9F9F0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      border: TableBorder.all(color: Colors.black54, width: 1.5),
      columns: _createColumns(),
      rows: List.generate(
        12,
        (index) => DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (index == 0) return const Color(0xFFFFD700);
              return index.isEven ? const Color(0xFFF9F9F9) : Colors.white;
            },
          ),
          cells: List.generate(10, (idx) => _buildStyledDataCell()),
        ),
      ),
    );
  }

  DataCell _buildStyledDataCell() {
    return DataCell(
      Container(
        padding: const EdgeInsets.all(8),
        child: const Center(
          child: Text(
            'sample',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      'تصنيف الصنف',
      'اخر سعر الشراء',
      'متوسط سعر الشراء',
      'اقل سعر',
      'الخصم',
      'سعر البيع',
      'الكميات المتاحه',
      'الوحده',
      'اسم الحساب',
      'رقم الحساب',
    ].map((label) => DataColumn(label: _buildDataHeader(label))).toList();
  }

  Widget _buildDataHeader(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildCalculationMethodColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('طريقة الحساب',
            style: TextStyle(fontWeight: FontWeight.bold)),
        _buildCustomRadioTile('اضافة نسبه مؤيه', 'percentage'),
        _buildCustomRadioTile('اضافة قيمه ثابته', 'fixed'),
      ],
    );
  }

  Widget _buildCalculationBaseColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('الي', style: TextStyle(fontWeight: FontWeight.bold)),
        _buildCustomRadioTile('اخر سعر شراء', 'lastPurchasePrice'),
        _buildCustomRadioTile('متوسط سعر الشراء', 'averagePurchasePrice'),
        _buildCustomRadioTile('سعر البيع الحالي', 'currentSellingPrice'),
        _buildCustomRadioTile('سعر البيع', 'sellingPrice'),
        _buildCustomRadioTile('سعر الجمله', 'wholesalePrice'),
      ],
    );
  }

  Widget _buildCustomRadioTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(
              width: 8), // Add some space between text and radio button
          SizedBox(
            width: 24,
            height: 24,
            child: Radio<String>(
              value: value,
              groupValue: value == 'percentage' || value == 'fixed'
                  ? calculationMethod
                  : calculationBase,
              onChanged: (newValue) {
                setState(() {
                  if (value == 'percentage' || value == 'fixed') {
                    calculationMethod = newValue!;
                  } else {
                    calculationBase = newValue!;
                  }
                });
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildFieldSelectionColumn()),
              Expanded(child: _buildCalculationBaseColumn()),
              Expanded(child: _buildCalculationMethodColumn()),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                // Add functionality for calculating selling prices
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFCC50E),
                minimumSize: const Size(168, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'حساب اسعار البيع',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculateButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {
            // Add functionality for calculating selling prices
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFCC50E),
            fixedSize: const Size(168, 35),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
            ),
          ),
          child: const Text(
            'حساب اسعار البيع',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldSelectionColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('حدد الحقول', style: TextStyle(fontWeight: FontWeight.bold)),
        ...selectedFields.keys.map((field) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 34,
                    height: 20,
                    child: TextField(
                      controller: fieldControllers[field],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD4D4D4),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(field),
                  Checkbox(
                    value: selectedFields[field],
                    onChanged: (value) =>
                        setState(() => selectedFields[field] = value!),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  @override
  void dispose() {
    fieldControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

void showItemInputScreen(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const ItemInputScreen(),
      );
    },
  );
}
