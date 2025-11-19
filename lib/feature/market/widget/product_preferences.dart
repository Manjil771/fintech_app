import 'dart:convert';

import 'package:ismart/feature/market/widget/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPreferences {
  static const String _productsKey = 'saved_products';

  static Future<void> addProduct(Product product, int quantity) async {
    final _instance = await SharedPreferences.getInstance();

    List<ProductWithQuantity> products = await getProducts();

    int existingIndex = products.indexWhere((p) => p.product.id == product.id);

    if (existingIndex != -1) {
      products[existingIndex] = ProductWithQuantity(
        product: product,
        quantity: quantity,
      );
    } else {
      products.add(ProductWithQuantity(
        product: product,
        quantity: quantity,
      ));
    }

    List<String> productJsonList =
        products.map((p) => json.encode(p.toJson())).toList();
    await _instance.setStringList(_productsKey, productJsonList);
  }

  static Future<List<ProductWithQuantity>> getProducts() async {
    final _instance = await SharedPreferences.getInstance();

    final productStrings = _instance.getStringList(_productsKey);
    if (productStrings == null || productStrings.isEmpty) {
      return [];
    }

    List<ProductWithQuantity> products = [];
    for (String productString in productStrings) {
      try {
        final productJson = json.decode(productString);
        products.add(ProductWithQuantity.fromJson(productJson));
      } catch (e) {
        print('Error parsing product: $e');
      }
    }

    return products;
  }

  static Future<ProductWithQuantity?> getProduct(int productId) async {
    final products = await getProducts();
    try {
      return products.firstWhere((p) => p.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  static Future<void> updateProductQuantity(
      int productId, int newQuantity) async {
    final _instance = await SharedPreferences.getInstance();

    List<ProductWithQuantity> products = await getProducts();
    int productIndex = products.indexWhere((p) => p.product.id == productId);

    if (productIndex != -1) {
      products[productIndex] = ProductWithQuantity(
        product: products[productIndex].product,
        quantity: newQuantity,
      );

      List<String> productJsonList =
          products.map((p) => json.encode(p.toJson())).toList();
      await _instance.setStringList(_productsKey, productJsonList);
    }
  }

  static Future<void> deleteProduct(int productId) async {
    final _instance = await SharedPreferences.getInstance();

    List<ProductWithQuantity> products = await getProducts();
    products.removeWhere((p) => p.product.id == productId);

    List<String> productJsonList =
        products.map((p) => json.encode(p.toJson())).toList();
    await _instance.setStringList(_productsKey, productJsonList);
  }

  static Future<void> deleteAllProducts() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_productsKey);
  }

  static Future<bool> productExists(int productId) async {
    final product = await getProduct(productId);
    return product != null;
  }

  static Future<int> getProductCount() async {
    final products = await getProducts();
    return products.length;
  }

  // static Future<int> getTotalQuantity() async {
  //   final products = await getProducts();
  //   return products.fold(0, (total, product) => total + product.quantity);
  // }
}
