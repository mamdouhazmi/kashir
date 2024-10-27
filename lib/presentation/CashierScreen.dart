import 'package:flutter/material.dart';

class CashierScreen extends StatefulWidget {
  const CashierScreen({super.key});

  @override
  _CashierScreenState createState() => _CashierScreenState();
}

class _CashierScreenState extends State<CashierScreen> {
  List<String> categories = ['الأصناف', 'عصير', 'مشروبات حارة', 'وجبات'];
  String selectedCategory = 'الأصناف';
  List<Product> allProducts = [
    Product('مشروب قهوة عربي', 20, 'مشروبات حارة'),
    Product('عصير برتقال', 15, 'عصير'),
    // Add more products here
  ];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
  }

  void filterProducts(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'الأصناف') {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts
            .where((product) => product.category == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الكاشير', style: TextStyle(color: Colors.orange)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Row(
        children: [
          // Left side - Order summary
          Expanded(
            flex: 1,
            child: OrderSummary(),
          ),
          // Right side - Products and filters
          Expanded(
            flex: 3,
            child: Column(
              children: [
                // Search and date inputs
                SearchAndDateInputs(),
                // Category filters
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Text(categories[index]),
                          selected: selectedCategory == categories[index],
                          onSelected: (selected) {
                            if (selected) {
                              filterProducts(categories[index]);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Product grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: filteredProducts[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String category;

  Product(this.name, this.price, this.category);
}

class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement order summary widget
    return Container(
        color: Colors.grey[200], child: Center(child: Text('Order Summary')));
  }
}

class SearchAndDateInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement search and date input fields
    return Container(
        height: 50, child: Center(child: Text('Search and Date Inputs')));
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_cafe, size: 48),
          Text(product.name),
          Text('${product.price} ريال'),
        ],
      ),
    );
  }
}
