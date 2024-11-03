import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensePopup extends StatefulWidget {
  const ExpensePopup({Key? key}) : super(key: key);

  @override
  _ExpensePopupState createState() => _ExpensePopupState();
}

class _ExpensePopupState extends State<ExpensePopup> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 968,
        height: 855,
        decoration: BoxDecoration(
          color: const Color(0xFFE9F9F0),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFF0F0F0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    'الصرف',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDB0000),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'صرف',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    buildFormSection(),
                    const SizedBox(height: 30),
                    buildBottomButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildInputField(label: 'المبلغ', width: 175),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: buildInputField(label: 'الحساب', width: 175)),
            const SizedBox(width: 15),
            Expanded(child: buildDateField(label: 'التاريخ')),
          ],
        ),
        const SizedBox(height: 15),
        buildTextArea(label: 'الملاحظات'),
        const SizedBox(height: 15),
        buildTabs(),
        const SizedBox(height: 20),
        buildInputField(label: 'الخزينه'),
        const SizedBox(height: 15),
        buildInputField(label: 'المرجع'),
        const SizedBox(height: 15),
        buildInputField(label: 'بند المصروفات'),
        const SizedBox(height: 15),
        buildInputField(label: 'رقم الحركه'),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildInputField(
      {required String label, double width = double.infinity}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Container(
          width: width,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const TextField(
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDateField(
      {required String label, double width = double.infinity}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            buildDatePickerButton(),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: dateController,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(fontSize: 14),
                  readOnly: true,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDatePickerButton() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Icon(Icons.calendar_today, size: 18),
      ),
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
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget buildTextArea({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const TextField(
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(fontSize: 14),
            maxLines: null,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'الفواتير المستحقة',
            style: TextStyle(
              color: Color(0xFFFF9A00),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFCC50E),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'عام',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: Image.asset('./assets/close.png', height: 20),
            label: const Text(
              'اغلاق',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check, color: Colors.green),
            label: const Text(
              'حفظ / جديد',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
