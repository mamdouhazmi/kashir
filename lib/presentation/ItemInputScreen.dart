import 'package:flutter/material.dart';

class ItemInputScreen extends StatefulWidget {
  const ItemInputScreen({super.key});

  @override
  _ItemInputScreenState createState() => _ItemInputScreenState();
}

class _ItemInputScreenState extends State<ItemInputScreen> {
  int _selectedButtonIndex = 3; // Default to "عام"
  bool _isServiceWithoutQuantity = false;
  String _selectedClassification = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 975,
      height: 700,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildTopSection(),
              const SizedBox(height: 20),
              _buildButtonGroup(),
              const SizedBox(height: 20),
              _buildMainContent(),
              const SizedBox(height: 20),
              _buildFooterButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Handle camera icon tap
              },
              child: Image.asset('assets/solar_camera-broken.png',
                  width: 100, height: 100),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'اسم الصنف',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 335,
                  height: 26,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.black)),
                  ),
                  child: const TextField(
                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(height: 1),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Checkbox(
              value: _isServiceWithoutQuantity,
              onChanged: (bool? value) {
                setState(() {
                  _isServiceWithoutQuantity = value ?? false;
                });
              },
            ),
            const Text('خدمه ليس لها كميه', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 25),
            _buildInputBox('سعر بدون ضريبه'),
            const SizedBox(width: 25),
            _buildInputBox('سعر البيع بالضريبه'),
          ],
        ),
        const SizedBox(height: 5),
        _buildInputBox('% نسبة الخصم'),
      ],
    );
  }

  Widget _buildInputBox(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 5),
        Container(
          width: 126,
          height: 26,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: const TextField(
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(height: 1),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonGroup() {
    final List<String> buttonLabels = [
      'اخري',
      'وحدات القياس',
      'الكميات الافتتاحيه',
      'عام'
    ];
    return Container(
      width: 639,
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedButtonIndex = index;
              });
            },
            child: Container(
              width: 156,
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _selectedButtonIndex == index
                    ? const Color(0xFFE9F9F0)
                    : const Color(0xCCFFFFFF),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  buttonLabels[index],
                  style: TextStyle(
                    color: _selectedButtonIndex == index
                        ? const Color(0xFFFF9A00)
                        : const Color(0x80000000),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMainContent() {
    if (_selectedButtonIndex == 2) {
      // If the "الكميات الافتتاحيه" button is selected, show MyCustomWidget
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0x33000000),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 611,
          height: 280,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: MyCustomWidget()),
            ],
          ),
        ),
      );
    } else {
      // Default to showing the Row content when "عام" or other buttons are selected
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0x33000000),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 611,
          height: 280,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: InvoiceContactWidget()),
              const SizedBox(width: 15),
              Expanded(child: Invoice1ContactWidget()),
              const SizedBox(width: 15),
              Expanded(
                  child: InvoiceOtherWidget(
                selectedClassification: _selectedClassification,
                onClassificationChanged: (String newValue) {
                  setState(() {
                    _selectedClassification = newValue;
                  });
                },
              )),
            ],
          ),
        ),
      );
    }
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
                showInputWidget2(context);
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
    required VoidCallback onPressed,
    Color textColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onPressed,
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
}

class InvoiceContactWidget extends StatefulWidget {
  @override
  _InvoiceContactWidgetState createState() => _InvoiceContactWidgetState();
}

class _InvoiceContactWidgetState extends State<InvoiceContactWidget> {
  bool _addToItemList = false;
  bool _inactiveItem = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionCard(
          title: 'اخري',
          children: [
            LabeledTextField(label: 'اقل كميه للصنف', width: 112, height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                  value: _addToItemList,
                  onChanged: (value) {
                    setState(() {
                      _addToItemList = value ?? false;
                    });
                  },
                ),
                const Text('اضف لقائمة الاصناف', style: labelStyle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                  value: _inactiveItem,
                  onChanged: (value) {
                    setState(() {
                      _inactiveItem = value ?? false;
                    });
                  },
                ),
                const Text('صنف غير نشط', style: labelStyle),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: 204,
          decoration: BoxDecoration(
            color: const Color(0xFFE9F9F0),
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 188,
                height: 25,
              ),
              SizedBox(
                width: 188,
                height: 25,
              ),
              SizedBox(
                width: 175,
                height: 25,
              ),
              SizedBox(
                width: 175,
                height: 25,
              ),
            ],
          ),
        )
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
          title: 'اكواد الصنف',
          children: [
            LabeledTextField(label: 'بار كود', width: 100, height: 16),
            LabeledTextField(label: 'كودالصنف 1', width: 100, height: 16),
            LabeledTextField(label: 'كودالصنف 2', width: 100, height: 16),
            LabeledTextField(label: 'اكواد اخري', width: 100, height: 16),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: 204,
          decoration: BoxDecoration(
            color: const Color(0xFFE9F9F0),
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 188,
                height: 27,
              ),
              SizedBox(
                width: 188,
                height: 27,
              ),
              SizedBox(
                width: 175,
                height: 27,
              ),
              SizedBox(
                width: 175,
                height: 27,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class InvoiceOtherWidget extends StatelessWidget {
  final String selectedClassification;
  final Function(String) onClassificationChanged;

  InvoiceOtherWidget({
    required this.selectedClassification,
    required this.onClassificationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionCard(
          title: 'التصنيفات',
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.7)),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          './assets/Arraw.png',
                          width: 20,
                          height: 20,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: selectedClassification.isEmpty
                                ? null
                                : selectedClassification,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                onClassificationChanged(newValue);
                              }
                            },
                            icon: const SizedBox.shrink(),
                            isExpanded: true,
                            underline: const SizedBox.shrink(),
                            items: <String>['تصنيف 1', 'تصنيف 2', 'تصنيف 3']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(value),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'التصنيف',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: 204,
          decoration: BoxDecoration(
            color: const Color(0xFFE9F9F0),
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 188,
                height: 35,
              ),
              SizedBox(
                width: 188,
                height: 35,
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 175,
                height: 35,
              ),
              SizedBox(
                width: 175,
                height: 34,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFDEE2E6);
    const headerBgColor = Color(0xFFF9F9F9);
    const cellBgColor = Color(0xFFF0F0F0);

    const headerTextStyle = TextStyle(
      fontFamily: 'Arial',
      fontWeight: FontWeight.bold,
      fontSize: 12.6,
      color: Colors.black,
    );

    const cellTextStyle = TextStyle(
      fontFamily: 'Arial',
      fontWeight: FontWeight.normal,
      fontSize: 10.8,
      color: Color(0xFF000000CC),
    );

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: headerBgColor,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: const Text(
            'الكميه الفتتاحيه هي كميه الصنف عند اضافته للبلرنامج لاول مره',
            style: headerTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          color: const Color(0xFFEFF7E7),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildTableHeader([
                'سعر الشراء بدون ضريبة',
                'كمية الافتتاحية',
                'المخزن',
              ], cellTextStyle, borderColor),
              _buildTableRow(
                  ['3', '4', 'فرع 1'], cellBgColor, cellTextStyle, borderColor),
              _buildTableRow(['-', '-', 'المخزن'], cellBgColor, cellTextStyle,
                  borderColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(
      List<String> headers, TextStyle style, Color borderColor) {
    return Row(
      children: headers.map((header) {
        return Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor, width: 0.9),
            ),
            alignment: Alignment.center,
            child: Text(header, style: style, textAlign: TextAlign.center),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTableRow(List<String> rowCells, Color bgColor, TextStyle style,
      Color borderColor) {
    return Row(
      children: rowCells.map((cell) {
        return Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor, width: 0.9),
            ),
            alignment: Alignment.center,
            child: Text(cell, style: style, textAlign: TextAlign.center),
          ),
        );
      }).toList(),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 204,
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
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(height: 1),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: InputBorder.none,
                  isDense: true,
                ),
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

const titleStyle = TextStyle(
  fontFamily: 'Arial',
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: Colors.black,
);

const labelStyle = TextStyle(
  fontFamily: 'Arial',
  fontWeight: FontWeight.bold,
  fontSize: 10,
  color: Colors.black,
);

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
            'تم الحفظ بنجاح',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xfff00b955),
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
