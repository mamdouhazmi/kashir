import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

class CashierScreen extends StatefulWidget {
  const CashierScreen({Key? key}) : super(key: key);

  @override
  State<CashierScreen> createState() => _CashierScreenState();
}

class _CashierScreenState extends State<CashierScreen> {
  final List<OrderItem> orderItems = [];
  final Map<String, bool> buttonStates = {};
  final TextEditingController dateController = TextEditingController();
  double total = 0;
  int selectedProductIndex = -1;
  List<ProductItem> products = [
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
    ProductItem(name: 'قهوة عربي', price: 20, imageUrl: './assets/coffee.png'),
  ];

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

  void updateTotal() {
    setState(() {
      total =
          orderItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    });
  }

  Widget buildDateField() {
    return SizedBox(
      width: 240,
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: dateController,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 14),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'التاريخ',
                  hintStyle: TextStyle(color: Colors.grey[900]),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.calendar_today, size: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideButton(String label, String? icon, VoidCallback onPressed) {
    bool isPressed = buttonStates[label] ?? false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        height: 48,
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Image.asset(icon, width: 24, height: 24),
              if (icon != null) const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isPressed ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(260), // Adjust this height as needed
      child: Container(
        color: Colors.white,
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'الكاشير',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF9A00),
                      ),
                    ),
                    closeButton(context),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        _buildTextField('بحث'),
                        const SizedBox(width: 16),
                        _buildTextField('العميل'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        buildDateField(),
                        const SizedBox(width: 16),
                        _buildTextField('ملاحظات'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F9F0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset('./assets/close.png', height: 20),
            const SizedBox(width: 8),
            const Text(
              'اغلاق',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Column(
          children: [
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: Row(
                children: [
                  const CategoriesMenu(),
                  Container(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  ProductGrid(
                    products: products,
                    onProductSelected: (index) {
                      setState(() {
                        selectedProductIndex =
                            selectedProductIndex == index ? -1 : index;
                        if (selectedProductIndex != -1) {
                          orderItems.add(OrderItem(
                            name: products[index].name,
                            price: products[index].price,
                            quantity: 1,
                          ));
                          updateTotal();
                        }
                      });
                    },
                    selectedProductIndex: selectedProductIndex,
                  ),
                  Container(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: orderItems.length,
                            itemBuilder: (context, index) {
                              return OrderItemTile(
                                item: orderItems[index],
                                onIncrease: () {
                                  setState(() {
                                    orderItems[index].quantity++;
                                    updateTotal();
                                  });
                                },
                                onDecrease: () {
                                  setState(() {
                                    if (orderItems[index].quantity > 1) {
                                      orderItems[index].quantity--;
                                      updateTotal();
                                    }
                                  });
                                },
                                onRemove: () {
                                  setState(() {
                                    orderItems.removeAt(index);
                                    updateTotal();
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              ReceiptSummary(
                                subtotal: total,
                                tax: total * 0.15,
                                discount: 0,
                              ),
                              const SizedBox(height: 16),
                              _buildSideButton(
                                  'جديد', './assets/docnew.png', () {}),
                              _buildSideButton(
                                  'حفظ / جديد', './assets/docnew.png', () {}),
                              _buildSideButton(
                                  'طباعة الاصناف', './assets/print.png', () {}),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<ProductItem> products;
  final Function(int) onProductSelected;
  final int selectedProductIndex;

  const ProductGrid({
    super.key,
    required this.products,
    required this.onProductSelected,
    required this.selectedProductIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 135 / 168,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onTap: () => onProductSelected(index),
            isSelected: selectedProductIndex == index,
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductItem product;
  final VoidCallback onTap;
  final bool isSelected;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 135,
        height: 168,
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFCC50E) : const Color(0xFFE9F9F0),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              product.imageUrl,
              width: 105,
              height: 90,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '${product.price} ريال',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final double price;

  final String imageUrl;

  ProductItem({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class OrderItem {
  final String name;
  final double price;
  int quantity;

  OrderItem({
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

class OrderItemTile extends StatelessWidget {
  final OrderItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const OrderItemTile({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        width: 280,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F9F0),
          border: Border.all(
            color: const Color(0xFFE9F9F0),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${item.price * item.quantity} ريال',
              style: const TextStyle(fontSize: 14),
            ),
            Container(
              width: 20 * 3,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFCC50E), width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 12),
                    onPressed: () {
                      if (item.quantity > 1) {
                        onDecrease();
                      } else {
                        onRemove();
                      }
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Text(
                    '${item.quantity}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 12),
                    onPressed: onIncrease,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  '${item.price} ريال',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              width: 40.67,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFFCC50E),
                    width: 0.5,
                  ),
                ),
                child: Image.asset(
                  './assets/coffee.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesMenu extends StatefulWidget {
  const CategoriesMenu({Key? key}) : super(key: key);

  @override
  State<CategoriesMenu> createState() => _CategoriesMenuState();
}

class _CategoriesMenuState extends State<CategoriesMenu> {
  int selectedIndex = 3;

  final List<Map<String, dynamic>> categories = [
    {'title': 'عصاير', 'icon': 'assets/juice.png'},
    {'title': 'مشروبات حاره', 'icon': 'assets/teenyicons.png'},
    {'title': 'وجبات', 'icon': 'assets/meals.png'},
    {'title': 'قهوة', 'icon': 'assets/teenyicons.png'},
    {'title': 'عصاير', 'icon': 'assets/juice.png'},
    {'title': 'عصاير', 'icon': 'assets/juice.png'},
    {'title': 'عصاير', 'icon': 'assets/juice.png'},
    {'title': 'عصاير', 'icon': 'assets/juice.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Text(
                'الأصناف',
                style: TextStyle(
                  color: Color(0xFFFF9A00),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? const Color(0xFFFF9A00)
                          : const Color(0xFFE9F9F0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          categories[index]['title'],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Image.asset(
                          categories[index]['icon'],
                          width: 18,
                          height: 18,
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiptSummary extends StatelessWidget {
  final double subtotal;
  final double tax;
  final double discount;

  const ReceiptSummary({
    Key? key,
    required this.subtotal,
    required this.tax,
    this.discount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = subtotal + tax - discount;
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFFE8F5E9),
      child: Column(
        children: [
          _buildRow('المجموع الفرعي', subtotal.toStringAsFixed(2)),
          const SizedBox(height: 8),
          _buildRow('الضريبة', tax.toStringAsFixed(2)),
          const SizedBox(height: 8),
          _buildRow('الخصم', discount.toStringAsFixed(2)),
          const SizedBox(height: 8),
          _buildRow('الإجمالي', total.toStringAsFixed(2), isTotal: true),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

Widget _buildTextField(String hintText) {
  return Container(
    width: 240,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: TextField(
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          isDense: true,
        ),
      ),
    ),
  );
}
