class Product {
  final int id;
  final String name;
  final int price;
  final int originalPrice;
  final String imageUrl;
  final double rating;
  final int reviews;
  final String store;
  final bool inStock;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.store,
    required this.inStock,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviews': reviews,
      'store': store,
      'inStock': inStock,
      'description': description,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      originalPrice: json['originalPrice'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      store: json['store'],
      inStock: json['inStock'],
      description: json['description'],
    );
  }
}

class ProductWithQuantity {
  final Product product;
  final int quantity;

  ProductWithQuantity({
    required this.product,
    required this.quantity,
  });
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  factory ProductWithQuantity.fromJson(Map<String, dynamic> json) {
    return ProductWithQuantity(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
