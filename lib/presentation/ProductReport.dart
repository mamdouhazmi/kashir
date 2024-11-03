import 'package:flutter/material.dart';

class ProductMovementReport extends StatefulWidget {
  const ProductMovementReport({Key? key}) : super(key: key);

  @override
  _ProductMovementReportState createState() => _ProductMovementReportState();
}

class _ProductMovementReportState extends State<ProductMovementReport> {
  String selectedWarehouse = '';
  String selectedDate = '10-11-2025';
  String selectedClass = '';
  String selectedShipment = '';
  String selectedDay = '';
  String selectedFromDate = '10-11-2025';
  String selectedToDate = '10-11-2025';
  String selectedSerial = '';
  String selectedLightMode = "Light";
  String selectedLanguage = "العربية";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _buildMainContent(),
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
            'تقرير حركه الصنف < اسم الصنف-120 ملل',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDownButton(String text, List<Map<String, dynamic>> options,
      Function(String?) onChanged, String currentValue) {
    return Container(
      width: 92,
      height: 35,
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

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildFilterRow(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildDataTable(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildDropdown('المخزن', selectedWarehouse),
              const SizedBox(width: 30),
              _buildDropdown('الصنف', selectedClass),
              const SizedBox(width: 62),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildDateField('من تاريخ', selectedFromDate),
              const SizedBox(width: 30),
              _buildDateField('الى تاريخ', selectedToDate),
              const SizedBox(width: 16),
              _buildDropdown('اليوم', selectedDay),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildDropdown('الشحنه', selectedShipment),
              const SizedBox(width: 30),
              _buildDropdown('السيريال', selectedSerial),
              const SizedBox(width: 62),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value) {
    final isDay = label == 'اليوم';
    return Container(
      width: isDay ? 47 : 200,
      height: isDay ? 29 : null,
      padding:
          isDay ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          hint: Text(label, style: TextStyle(fontSize: isDay ? 12 : 14)),
          isExpanded: true,
          icon: isDay
              ? CustomPaint(size: Size(10, 5), painter: DropdownArrowPainter())
              : const Icon(Icons.arrow_drop_down),
          style: TextStyle(fontSize: isDay ? 12 : 14, color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              switch (label) {
                case 'المخزن':
                  selectedWarehouse = newValue ?? '';
                  break;
                case 'الصنف':
                  selectedClass = newValue ?? '';
                  break;
                case 'الشحنه':
                  selectedShipment = newValue ?? '';
                  break;
                case 'اليوم':
                  selectedDay = newValue ?? '';
                  break;
                case 'السيريال':
                  selectedSerial = newValue ?? '';
                  break;
              }
            });
          },
          items: isDay
              ? List.generate(32, (index) {
                  return DropdownMenuItem<String>(
                    value: index == 0 ? '' : index.toString(),
                    child: Text(index == 0 ? 'اليوم' : index.toString()),
                  );
                })
              : <String>['Option 1', 'Option 2', 'Option 3']
                  .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, String value) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
        ),
        readOnly: true,
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            setState(() {
              if (label == 'من تاريخ') {
                selectedFromDate =
                    "${picked.day}-${picked.month}-${picked.year}";
              } else if (label == 'الى تاريخ') {
                selectedToDate = "${picked.day}-${picked.month}-${picked.year}";
              }
            });
          }
        },
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
            '',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      'رقم الصنف',
      'اسم الصنف',
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

class DropdownArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
