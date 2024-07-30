import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:shoping_cart_with_provider/cart_model.dart';
import 'package:shoping_cart_with_provider/cart_provider.dart';
import 'package:shoping_cart_with_provider/db_helper.dart';

import 'cart_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DbHelper? dbHelper = DbHelper();
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    "Peach",
    'Mixed Fruit Basket',
  ];
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'Dozen',
    'KG',
    "KG",
    'KG',
  ];
  List<int> productPrice = [
    10,
    20,
    30,
    40,
    50,
    60,
    70,
  ];
  List<String> productImages = [
    'https://www.shutterstock.com/shutterstock/photos/1987479101/display_1500/stock-vector-fresh-mango-with-mango-slice-and-leaves-vector-illustration-1987479101.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2250844075/display_1500/stock-vector-half-of-fresh-orange-fruit-isolated-on-the-white-background-realistic-fruits-design-template-vector-2250844075.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2340959141/display_1500/stock-vector-grape-watercolor-sketch-hand-drawn-wine-bunch-of-grapes-isolated-backgeound-2340959141.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1722111529/display_1500/stock-photo-bunch-of-bananas-isolated-on-white-background-with-clipping-path-and-full-depth-of-field-1722111529.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1797601963/display_1500/stock-photo-red-sweet-cherry-isolated-on-white-background-with-clipping-path-and-full-depth-of-field-1797601963.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2475285749/display_1500/stock-photo-ripe-peach-with-leaf-and-peach-slices-on-white-background-file-contains-clipping-path-2475285749.jpg',
    'https://www.shutterstock.com/shutterstock/photos/109803575/display_1500/stock-photo-still-life-of-fruit-in-basket-isolated-on-white-109803575.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartListScreen()));
    },
            child: Center(
              child: badges.Badge(
                badgeContent:
                    Consumer<CartProvider>(builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                }),
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(microseconds: 300),
                ),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(
                                    productImages[index].toString())),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName[index].toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${productUnit[index]}  \$${productPrice[index]}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        dbHelper!
                                            .insert(Cart(
                                          id: index,
                                          productId: index.toString(),
                                          productName:
                                              productName[index].toString(),
                                          initialPrice: productPrice[index],
                                          productPrice: productPrice[index],
                                          quantity: 1,
                                          unitTag:
                                              productUnit[index].toString(),
                                          image:
                                              productImages[index].toString(),
                                        ))
                                            .then((value) {
                                          print('Product is added to the Cart');
                                          cart.addTotalPrice(double.parse(
                                              productPrice[index].toString()));
                                          cart.addCounter();
                                        }).onError((error, stackTrace) {
                                          print("Error: $error");
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Add to Cart',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
