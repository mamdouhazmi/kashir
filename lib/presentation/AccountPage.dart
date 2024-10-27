import 'package:flutter/material.dart';
import 'package:kashir/presentation/ProductEntryScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _showInactiveAccounts = false;
  bool _hideZeroBalances = false;
  bool _showUnderReview = false;

  // State variables for the dropdown selections
  String _selectedCategory = 'Sample 1';
  String _selectedAccountType = 'Sample 1';

  // Dropdown options
  final List<String> _categoryOptions = ['Sample 1', 'Sample 2'];
  final List<String> _accountTypeOptions = ['Sample 1', 'Sample 2'];

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
                  _buildMainContent(),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildHeaderButton('./assets/icon-park-solid_update-rotation.png',
                  'تحديث', () {}, context),
              const SizedBox(width: 10),
              _buildHeaderButton('./assets/close.png', 'اغلاق', () {
                Navigator.of(context).pop();
              }, context),
            ],
          ),
          const Text(
            'الحسابات',
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

  Widget _buildSideMenu() {
    return Container(
      width: 320,
      padding: const EdgeInsets.only(top: 150, left: 20, right: 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:
                    _buildSideButton('حذف', './assets/typcn_delete.png', () {}),
              ),
              const SizedBox(width: 13.5),
              Expanded(
                  child: _buildSideButton(
                      'جديد', './assets/pajamas_doc-new.png', () {
                showProductEntryScreen(context);
              })),
              const SizedBox(width: 13.5),
              Expanded(
                child: _buildSideButton(
                    'تعديل', './assets/akar-icons_edit.png', () {}),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSideButton('طباعة قاءمة الحسابات', './assets/print.png', () {}),
          _buildSideButton('كشف الحساب', './assets/bxs_file.png', () {}),
          _buildSideButton('كشف حساب بالاصناف', './assets/bxs_file.png', () {}),
          _buildSideButton('الشبكات و الاقساط', './assets/bxs_file.png', () {}),
          _buildSideButton(
              'ارصده الحسابات بتاريخ سابق', './assets/bxs_file.png', () {}),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterAndSearchRow(),
            const SizedBox(height: 10),
            _buildCheckboxRow(),
            const SizedBox(height: 10),
            Expanded(child: _buildDataTable()),
          ],
        ),
      ),
    );
  }

  // Dropdowns for 'تصنيف' and 'طبيعة الحساب'
  Widget _buildFilterAndSearchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDropdownMenu('تصنيف', _selectedCategory, _categoryOptions,
            (String? newValue) {
          setState(() {
            _selectedCategory = newValue!;
          });
        }),
        _buildDropdownMenu(
            'طبيعة الحساب', _selectedAccountType, _accountTypeOptions,
            (String? newValue) {
          setState(() {
            _selectedAccountType = newValue!;
          });
        }),
        _buildSearchBar(),
      ],
    );
  }

  // Build the dropdown menu with the specified options and selected value
  Widget _buildDropdownMenu(String label, String selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Container(
          width: 99, // Fixed width as specified
          height: 16, // Fixed height as specified
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            underline: const SizedBox(), // Remove default underline
            onChanged: onChanged,
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Justify content between text and arrow
                  children: [
                    Text(value),
                    const Icon(Icons.arrow_drop_down), // Dropdown arrow
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterOption(
            'اظهار الحسابات الغير نشطه فقط', _showInactiveAccounts, (value) {
          setState(() {
            _showInactiveAccounts = value!;
          });
        }),
        _buildFilterOption('اخفاء الارصده الصفريه', _hideZeroBalances, (value) {
          setState(() {
            _hideZeroBalances = value!;
          });
        }),
        _buildFilterOption('اظهار الحسابات تحت المراجعه فقط', _showUnderReview,
            (value) {
          setState(() {
            _showUnderReview = value!;
          });
        }),
      ],
    );
  }

  Widget _buildFilterOption(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بحث عن', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Container(
          width: 167, // Fixed width as specified
          height: 26, // Fixed height as specified
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF000000).withOpacity(0.7)),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(
          color: Colors.black54,
          width: 1.5,
        ),
        columns: _createColumns(),
        rows: List.generate(
          12,
          (index) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (index == 0) {
                  return const Color(
                      0xFFFFD700); // Golden yellow for the first row
                }
                return index.isEven
                    ? const Color(0xFFF9F9F9)
                    : Colors.white; // Alternating row colors
              },
            ),
            cells: List.generate(10, (idx) => _buildStyledDataCell()),
          ),
        ),
      ),
    );
  }

  DataCell _buildStyledDataCell() {
    return DataCell(
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.black54, width: 1.0), // Add border to each cell
        ),
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
      DataColumn(label: _buildDataHeader('رقم الحساب')),
      DataColumn(label: _buildDataHeader('اسم الحساب')),
      DataColumn(label: _buildDataHeader('الوحده')),
      DataColumn(label: _buildDataHeader('الكميات المتاحه')),
      DataColumn(label: _buildDataHeader('سعر البيع')),
      DataColumn(label: _buildDataHeader('الخصم')),
      DataColumn(label: _buildDataHeader('اقل سعر')),
      DataColumn(label: _buildDataHeader('متوسط سعر الشراء')),
      DataColumn(label: _buildDataHeader('اخر سعر الشراء')),
      DataColumn(label: _buildDataHeader('تصنيف الصنف')),
    ];
  }

  Widget _buildDataHeader(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: const BoxDecoration(
        color: Color(0xFFF0F0F0),
        border: Border(
          bottom: BorderSide(color: Colors.black54, width: 1.5),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}

Widget _buildSideButton(String label, String icon, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: GestureDetector(
      onTap: onPressed, // Handle the tap event
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F9F0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 24, height: 24),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}

void showProductEntryScreen(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const ProductEntryScreen(),
      );
    },
  );
}
