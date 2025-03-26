import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String selectedCategory = "Women";
  Map<String, dynamic>? selectedProduct;
  List<Map<String, dynamic>> cartItems = [];
  bool viewingCart = false;

  final Map<String, List<Map<String, dynamic>>> categoryData = {
    "Women": [
      {"name": "Hight Heels", "image": "lib/assets/high.png", "price": 150.00},
      {
        "name": "White Dress",
        "image": "lib/assets/whitedress.png",
        "price": 80.00,
      },
      {
        "name": "Black Dress",
        "image": "lib/assets/blackdress.png",
        "price": 90.00,
      },
      {
        "name": "Pant Suit",
        "image": "lib/assets/pantsuit.png",
        "price": 250.00,
      },
      {
        "name": "Classic dress",
        "image": "lib/assets/classicdress.png",
        "price": 120.00,
      },
      {
        "name": "Green Shirt",
        "image": "lib/assets/greenshirt.png",
        "price": 110.00,
      },
      {
        "name": "White Sneakers",
        "image": "lib/assets/whiteshoes.png",
        "price": 200.00,
      },
      {
        "name": "Blue Dress",
        "image": "lib/assets/bluedress.png",
        "price": 300.00,
      },
    ],
    "Men": [
      {
        "name": "Black Suit",
        "image": "lib/assets/blacksuit.png",
        "price": 400.00,
      },
      {"name": "Green Shirt", "image": "lib/assets/green.png", "price": 70.00},
      {
        "name": "Leather Shoes",
        "image": "lib/assets/leather.png",
        "price": 150.00,
      },
      {
        "name": "Sports Jacket",
        "image": "lib/assets/sport.png",
        "price": 180.00,
      },
      {"name": "Wrist Watch", "image": "lib/assets/wrist.png", "price": 350.00},
      {
        "name": "Running Shoes",
        "image": "lib/assets/runningshoes.png",
        "price": 130.00,
      },
      {"name": "Backpack", "image": "lib/assets/backpack.png", "price": 90.00},
      {"name": "Sweater", "image": "lib/assets/sweather.png", "price": 110.00},
    ],
    "Children": [
      {"name": "Cartoon T-Shirt", "image": "lib/assets/1.png", "price": 50.00},
      {"name": "Jeans Shorts", "image": "lib/assets/2.png", "price": 60.00},
      {"name": "Sneakers", "image": "lib/assets/3.png", "price": 80.00},
      {"name": "Winter Hoodie", "image": "lib/assets/4.png", "price": 90.00},
      {"name": "Cute Dress", "image": "lib/assets/5.png", "price": 70.00},
      {"name": "School Bag", "image": "lib/assets/6.png", "price": 40.00},
      {"name": "T-Shirt", "image": "lib/assets/7.png", "price": 30.00},
      {"name": "Shirt", "image": "lib/assets/8.png", "price": 20.00},
    ],
  };

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.add({...product, "quantity": 1});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${product["name"]} added to cart"),
          action: SnackBarAction(
            label: 'View Cart',
            onPressed:
                () => setState(() {
                  viewingCart = true;
                  selectedProduct = null;
                }),
          ),
        ),
      );
    });
  }

  double get cartTotal => cartItems.fold(
    0,
    (sum, item) => sum + (item["price"] ?? 0) * (item["quantity"] ?? 1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
            viewingCart
                ? Text("Shopping Cart", style: TextStyle(fontSize: 15))
                : DropdownButton<String>(
                  value: selectedCategory,
                  items:
                      categoryData.keys
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category,
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => selectedCategory = value);
                  },
                ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 32),
          onPressed: () {
            if (viewingCart)
              setState(() => viewingCart = false);
            else if (selectedProduct != null)
              setState(() => selectedProduct = null);
            else
              Navigator.pop(context);
          },
        ),
        actions: [
          if (!viewingCart)
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed:
                      () => setState(() {
                        viewingCart = true;
                        selectedProduct = null;
                      }),
                ),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${cartItems.length}',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
      body:
          viewingCart
              ? buildCartView()
              : (selectedProduct == null
                  ? buildProductGrid()
                  : buildProductDetails()),
    );
  }

  Widget buildProductGrid() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.6,
        ),
        itemCount: categoryData[selectedCategory]!.length,
        itemBuilder: (context, index) {
          var item = categoryData[selectedCategory]![index];
          return GestureDetector(
            onTap: () => setState(() => selectedProduct = item),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.asset(
                        item["image"],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      item["name"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${(item["price"] ?? 0).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_shopping_cart, size: 20),
                          onPressed: () => addToCart(item),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProductDetails() {
    String selectedSize = "38";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Image.asset(
              selectedProduct!["image"],
              fit: BoxFit.cover,
              height: 340,
              width: 340,
            ),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 32),
                onPressed: () => setState(() => selectedProduct = null),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedProduct!["name"],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "\$${selectedProduct!["price"].toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Size",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children:
                    ["36", "37", "38", "39", "40"]
                        .map(
                          (size) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: ChoiceChip(
                              label: Text(size),
                              selected: selectedSize == size,
                              onSelected:
                                  (selected) =>
                                      setState(() => selectedSize = size),
                            ),
                          ),
                        )
                        .toList(),
              ),
              SizedBox(height: 5),
              Text(
                "Color",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: Colors.brown,
                      radius: 12,
                    ),
                  ),
                  CircleAvatar(backgroundColor: Colors.blueAccent, radius: 12),
                ],
              ),
              SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    addToCart({
                      ...selectedProduct!,
                      "selectedSize": selectedSize,
                      "selectedColor": Colors.black,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Add to Cart", style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCartView() {
    if (cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
            SizedBox(height: 5),
            Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () => setState(() => viewingCart = false),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: Text("Continue Shopping", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item["image"],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${item["price"].toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 14),
                            ),
                            if (item["selectedSize"] != null)
                              Text(
                                "Size: ${item["selectedSize"]}",
                                style: TextStyle(fontSize: 14),
                              ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline, size: 22),
                            onPressed:
                                () => setState(() {
                                  if ((item["quantity"] ?? 1) > 1) {
                                    item["quantity"] =
                                        (item["quantity"] ?? 1) - 1;
                                  } else {
                                    cartItems.removeAt(index);
                                  }
                                }),
                          ),
                          Text(
                            "${item["quantity"] ?? 1}",
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline, size: 22),
                            onPressed:
                                () => setState(() {
                                  item["quantity"] =
                                      (item["quantity"] ?? 1) + 1;
                                }),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 22,
                        ),
                        onPressed:
                            () => setState(() => cartItems.removeAt(index)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${cartTotal.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Proceeding to checkout...")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Checkout", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
