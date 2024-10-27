import 'package:flutter/material.dart';
import 'package:kashir/presentation/ItemInputScreen.dart';

class TheGoods extends StatefulWidget {
  const TheGoods({Key? key}) : super(key: key);

  @override
  _TheGoodsState createState() => _TheGoodsState();
}

class _TheGoodsState extends State<TheGoods> {
  String selectedFactory = 'المصنع';
  String selectedBrand = 'الماركة';
  String selectedLightMode = "Light";
  String selectedLanguage = "العربية";
  String selectedClassification = 'التصنيف';
  bool showInactiveAccounts = false;
  bool hideZeroBalances = false;
  bool showAccountsUnderReview = false;
  Map<String, bool> buttonStates = {};

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
                  _buildSideMenu(),
                  Expanded(
                    child: _buildMainContent(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
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
                const SizedBox(width: 10),
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
          ),
          const Spacer(),
          const Text(
            'البضاعة',
            style: TextStyle(
              color: Color(0xFFFF9A00),
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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

  Widget _buildDropdownMenu(String label, String selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return Container(
      width: 105,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: onChanged,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSideMenu() {
    return Container(
      width: 300,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSideButtonRow([
                _buildSideButton('حذف', './assets/typcn_delete.png', () {
                  showInputWidget2(context);
                }),
                _buildSideButton('جديد', './assets/pajamas_doc-new.png', () {
                  showItemInputScreen(context);
                }),
                _buildSideButton(
                    'تعديل', './assets/akar-icons_edit.png', () {}),
              ]),
              const SizedBox(height: 10),
              _buildSideButtonRow([
                _buildSideButton('طباعة الاصناف', './assets/print.png', () {}),
                _buildSideButton(
                    'تقرير حركه الصنف', './assets/bxs_file.png', () {}),
              ]),
              const SizedBox(height: 10),
              _buildSideButtonRow([
                _buildSideButton(
                    'تقرير بضاعه المخزن', './assets/bxs_file.png', () {}),
                _buildSideButton(
                    'طباعة باركود', './assets/tdesign_barcode-1.png', () {
                  showInputWidget1(context);
                }),
              ]),
              const SizedBox(height: 10),
              _buildSideButtonRow([
                _buildSideButton('تقرير المخزون الوارد و المنصرف',
                    './assets/bxs_file.png', () {}),
                _buildSideButton('تعديل اسعار البيع', null, () {
                  showInputWidget(context);
                }),
              ]),
              const SizedBox(height: 10),
              _buildSideButtonRow([
                _buildSideButton('بحث كود سيريال', null, () {}),
                _buildSideButton('تقرير شحنه', null, () {}),
              ]),
              const SizedBox(height: 10),
              _buildSideButtonRow([
                _buildSideButton(
                    '', './assets/vscode-icons_file-type-excel.png', () {}),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildFilterAndSearchRow(),
            const SizedBox(height: 10),
            _buildCheckboxRow(),
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

  Widget _buildSideButtonRow(List<Widget> buttons) {
    return Row(
      children: buttons.map((button) => Expanded(child: button)).toList(),
    );
  }

  Widget _buildSideButton(String label, String? icon, VoidCallback onPressed) {
    bool isPressed = buttonStates[label] ?? false;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              buttonStates[label] = !isPressed;
            });
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isPressed ? const Color(0xFFFF9A00) : const Color(0xFFE9F9F0),
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Image.asset(icon, width: 24, height: 24)
              else
                const SizedBox(height: 24),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isPressed ? Colors.white : const Color(0xFF000000),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterAndSearchRow() {
    return Container(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 17),
          _buildDropdownMenu('التصنيف', selectedClassification,
              ['التصنيف', 'تصنيف 1', 'تصنيف 2'], (String? newValue) {
            setState(() {
              selectedClassification = newValue ?? 'التصنيف';
            });
          }),
          const SizedBox(width: 17),
          _buildDropdownMenu(
              'الماركة', selectedBrand, ['الماركة', 'ماركة 1', 'ماركة 2'],
              (String? newValue) {
            setState(() {
              selectedBrand = newValue ?? 'الماركة';
            });
          }),
          const SizedBox(width: 17),
          _buildDropdownMenu(
              'المصنع', selectedFactory, ['المصنع', 'مصنع 1', 'مصنع 2'],
              (String? newValue) {
            setState(() {
              selectedFactory = newValue ?? 'المصنع';
            });
          }),
          const SizedBox(width: 17),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildCheckboxRow() {
    return Container(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildFilterOption(
              'عرض الاصناف التي تجاوز أقل الكميه', showInactiveAccounts,
              (value) {
            setState(() {
              showInactiveAccounts = value ?? false;
            });
          }),
          const SizedBox(width: 16),
          _buildFilterOption('عرض الاصناف الغير مستخدمة', hideZeroBalances,
              (value) {
            setState(() {
              hideZeroBalances = value ?? false;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildFilterOption(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          visualDensity: VisualDensity.compact,
        ),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 36, // Set a fixed height to match other elements in the row
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 18, color: Colors.grey),
                  SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Text(
            'البحث عن',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget dropDownButton(String text, List<Map<String, dynamic>> options,
      Function(String?) onChanged, String currentValue) {
    return Container(
      width: 92,
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(option['icon'],
                    size: 14, color: Colors.black.withOpacity(0.6)),
                Text(
                  option['label'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.6),
        ),
        isExpanded: true,
        hint: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
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
      'رقم الحساب',
      'اسم الحساب',
      'الوحده',
      'الكميات المتاحه',
      'سعر البيع',
      'الخصم',
      'اقل سعر',
      'متوسط سعر الشراء',
      'اخر سعر الشراء',
      'تصنيف الصنف',
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

class PriceAdjustmentWidget extends StatefulWidget {
  @override
  _PriceAdjustmentWidgetState createState() => _PriceAdjustmentWidgetState();
}

class _PriceAdjustmentWidgetState extends State<PriceAdjustmentWidget> {
  bool isPressed1 = false;
  bool isPressed2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 547,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 85),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'هل تريد تعديل اسعار البيع ؟',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          OptionButton(
            text: 'للصنف المحدد فقط',
            backgroundColor:
                isPressed1 ? const Color(0xFFFCC50E) : const Color(0xFFAAAAAA),
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                isPressed1 = !isPressed1;
              });
              Navigator.pushNamed(context, '/SellingPrices');
            },
          ),
          const SizedBox(height: 8),
          OptionButton(
            text: 'لجميع الاصناف في القاءمه',
            backgroundColor:
                isPressed2 ? const Color(0xFFFCC50E) : const Color(0xFFAAAAAA),
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                isPressed2 = !isPressed2;
              });
              print("Adjusting price for all items in the list");
            },
          ),
          const SizedBox(height: 8),
          OptionButton(
            text: 'عودة',
            backgroundColor: const Color(0xFFAAAAAA),
            textColor: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  OptionButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class BarcodePrintingWidget extends StatefulWidget {
  @override
  _BarcodePrintingWidgetState createState() => _BarcodePrintingWidgetState();
}

class _BarcodePrintingWidgetState extends State<BarcodePrintingWidget> {
  bool isPressed1 = false;
  bool isPressed2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 547,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 85),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'هل تريد طباعه ملصقات الكود ؟',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          BarcodeOptionButton(
            text: 'للصنف المحدد فقط',
            backgroundColor:
                isPressed1 ? const Color(0xFFFCC50E) : const Color(0xFFAAAAAA),
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                isPressed1 = !isPressed1;
              });
              print("Printing barcode for selected item only");
            },
          ),
          const SizedBox(height: 8),
          BarcodeOptionButton(
            text: 'لجميع الاصناف في القاءمه',
            backgroundColor:
                isPressed2 ? const Color(0xFFFCC50E) : const Color(0xFFAAAAAA),
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                isPressed2 = !isPressed2;
              });
              print("Printing barcode for all items in the list");
            },
          ),
          const SizedBox(height: 8),
          BarcodeOptionButton(
            text: 'عودة',
            backgroundColor: const Color(0xFFAAAAAA),
            textColor: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class BarcodeOptionButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const BarcodeOptionButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class WarningMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 536,
      height: 200,
      padding: const EdgeInsets.fromLTRB(10, 35, 10, 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'يوجد فواتير متعلقة بهذا الصنف لا يمكن حذفه',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFFE90000),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            ),
            child: const Text(
              'عودة',
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
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
        child: PriceAdjustmentWidget(),
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
        child: WarningMessageWidget(),
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
        child: BarcodePrintingWidget(),
      );
    },
  );
}
