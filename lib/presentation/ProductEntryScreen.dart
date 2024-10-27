import 'package:flutter/material.dart';

class ProductEntryScreen extends StatefulWidget {
  const ProductEntryScreen({super.key});

  @override
  _ProductEntryScreenState createState() => _ProductEntryScreenState();
}

class _ProductEntryScreenState extends State<ProductEntryScreen> {
  String? _selectedAccountType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD700),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 150, left: 132, right: 50),
          child: Container(
            width: 975,
            height: 606,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildTopSection(),
                const SizedBox(height: 20),
                _buildMainContent(),
                const SizedBox(height: 20),
                _buildFooterButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'اسم الحساب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCheckboxRow()),
            const SizedBox(width: 50),
            Container(
              width: 335,
              height: 26,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black)),
              ),
              child: const TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckboxRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildCheckbox('اخري'),
        const SizedBox(width: 5),
        _buildCheckbox('مندوب مبيعات'),
        const SizedBox(width: 5),
        _buildCheckbox('مورد'),
        const SizedBox(width: 5),
        _buildCheckbox('عميل'),
      ],
    );
  }

  // Reusable checkbox widget
  Widget _buildCheckbox(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _selectedAccountType == label,
          onChanged: (bool? value) {
            setState(() {
              _selectedAccountType = value! ? label : null;
            });
          },
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

Widget _buildMainContent() {
  return Container(
    padding: const EdgeInsets.all(16), // Add padding around the content
    decoration: BoxDecoration(
      color: const Color(0x33000000), // Background color: #00000033
      borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
    ),
    child: SizedBox(
      width: 611,
      height: 356,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: InvoiceContactWidget()),
          const SizedBox(width: 15),
          Expanded(child: Invoice1ContactWidget()),
          const SizedBox(width: 15),
          Expanded(child: InvoiceOtherWidget()),
        ],
      ),
    ),
  );
}

Widget _buildFooterButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      _buildFooterButton(
        iconPath: './assets/pajamas_go-back.png',
        label: 'رجوع',
        backgroundColor: Colors.white,
        onPressed: () {
          // Action for "رجوع"
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: 300),
      Row(
        children: [
          _buildFooterButton(
            iconPath: './assets/uil_plus.png',
            label: 'حفظ | جديد',
            backgroundColor: Colors.white,
            onPressed: () {
              // Action for "حفظ | جديد"
              print('Save and New button pressed');
            },
          ),
          const SizedBox(width: 10),
          _buildFooterButton(
            iconPath: './assets/ph_check-bold.png',
            label: 'حفظ',
            backgroundColor: const Color(0xFFFF9A00),
            textColor: Colors.white,
            onPressed: () {
              // Action for "حفظ"
              print('Save button pressed');
            },
          ),
        ],
      ),
    ],
  );
}

Widget _buildFooterButton({
  required String iconPath,
  required String label,
  required Color backgroundColor,
  required VoidCallback onPressed, // Callback for button press action
  Color textColor = Colors.black,
}) {
  return GestureDetector(
    onTap: onPressed, // Attach the callback here
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    ),
  );
}

class InvoiceContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionCard(
          title: 'فواتير البيع',
          children: [
            LabeledTextField(label: 'عليه / مدين', width: 112, height: 16),
            LabeledTextField(label: 'له / داءن', width: 100, height: 16),
            LabeledTextField(
              label: 'تاريخ الرصيد',
              width: 88,
              height: 16,
              prefixIcon: Icons.date_range,
            ),
            const SizedBox(height: 15),
          ],
        ),
        // const SizedBox(height: 8),
        SectionCard(
          title: 'بيانات الاتصال',
          children: [
            const SizedBox(height: 5),
            LabeledTextField(
                label: 'موبايل',
                width: 188,
                height: 16,
                padding: const EdgeInsets.symmetric(horizontal: 6)),
            LabeledTextField(
                label: 'ايميل',
                width: 188,
                height: 16,
                padding: const EdgeInsets.symmetric(horizontal: 6)),
            const SizedBox(height: 14),
            Text('العنوان', style: labelStyle, textAlign: TextAlign.left),
            LabeledTextField(
                label: '',
                width: 175,
                height: 16,
                padding: const EdgeInsets.symmetric(horizontal: 10)),
            LabeledTextField(
                label: '',
                width: 175,
                height: 16,
                padding: const EdgeInsets.symmetric(horizontal: 10)),
          ],
        ),
      ],
    );
  }
}

class Invoice1ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionCard(
          title: 'اكواد و تصنيفات',
          children: [
            LabeledTextField(label: 'كود الحساب', width: 112, height: 16),
            LabeledTextField(label: 'الرقم الضريبي', width: 100, height: 16),
            LabeledTextField(label: 'التصنيف', width: 100, height: 16),
          ],
        ),
        // const SizedBox(height: 8)
        Container(
          padding: const EdgeInsets.all(8), // Same padding as SectionCard had
          width: 204, // Maintaining the width of the SectionCard
          decoration: BoxDecoration(
            color: const Color(0xFFE9F9F0), // Keeping the background color same
            borderRadius:
                BorderRadius.circular(2), // Same border radius as SectionCard
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Empty space replacing the input boxes (keeping size intact)
              SizedBox(
                width: 188,
                height: 50,
              ),
              SizedBox(
                width: 188,
                height: 50,
              ),
              SizedBox(height: 11), // Space maintained
              SizedBox(
                width: 175,
                height: 50,
              ),
              SizedBox(
                width: 175,
                height: 50,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class InvoiceOtherWidget extends StatefulWidget {
  @override
  _InvoiceOtherWidgetState createState() => _InvoiceOtherWidgetState();
}

class _InvoiceOtherWidgetState extends State<InvoiceOtherWidget> {
  bool _isAccountReminderChecked = false;
  bool _isAccountInactiveChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionCard(
          title: 'فواتير البيع',
          children: [
            LabeledTextField(label: 'نسبه الخصم', width: 112, height: 16),
            LabeledTextField(label: 'سعر البيع', width: 112, height: 16),
            LabeledTextField(label: 'اعلي دين مسموح', width: 112, height: 16),
            const SizedBox(height: 18),
          ],
        ),
        SectionCard(
          title: 'اخرى',
          children: [
            CheckboxField(
              label: 'ذكرني بمراجعه الحساب',
              value: _isAccountReminderChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isAccountReminderChecked = newValue ?? false;
                });
              },
            ),
            CheckboxField(
              label: 'حساب غير نشط',
              value: _isAccountInactiveChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isAccountInactiveChecked = newValue ?? false;
                });
              },
            ),
            const SizedBox(height: 2),
            _buildNotesField(),
          ],
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above the text area
        Text('الملاحظات', style: labelStyle),
        const SizedBox(height: 4),
        Container(
          width: 160,
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.7)),
          ),
          child: const TextField(
            maxLines: null,
            decoration: InputDecoration.collapsed(hintText: ''),
          ),
        ),
      ],
    );
  }
}

// Reusable components

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 204, // Set the width of the entire component
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F9F0),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Center(
              child: Text(
                title,
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (var child in children)
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4), child: child),
        ],
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final double width;
  final double height;
  final EdgeInsets padding;
  final bool isMultiLine;

  LabeledTextField({
    required this.label,
    this.prefixIcon,
    required this.width,
    required this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.isMultiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            child: Container(
              width: width,
              height: height,
              padding: padding,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(0.7)),
              ),
              child: TextField(
                maxLines: isMultiLine ? null : 1,
                decoration: const InputDecoration.collapsed(hintText: ''),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: labelStyle),
      ],
    );
  }
}

class CheckboxField extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  CheckboxField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Expanded(child: Text(label, style: labelStyle)),
      ],
    );
  }
}

// Common Styles
final titleStyle = const TextStyle(
  fontFamily: 'Arial',
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: Colors.black,
);

final labelStyle = const TextStyle(
  fontFamily: 'Arial',
  fontWeight: FontWeight.bold,
  fontSize: 10,
  color: Colors.black,
);
