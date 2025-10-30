import 'package:flutter/material.dart';
import 'package:ismart/feature/market/widget/grid_item_card.dart';
import 'package:ismart/feature/market/widget/product.dart';
import 'package:ismart/feature/market/widget/product_detail.dart';

class MarketplaceHomePage extends StatefulWidget {
  @override
  _MarketplaceHomePageState createState() => _MarketplaceHomePageState();
}

class _MarketplaceHomePageState extends State<MarketplaceHomePage> {
  Set<int> favorites = {};

  // final List<Product> popularItems = [
  //   Product(
  //     id: 1,
  //     name: "Horlicks Regular 500g",
  //     price: 445,
  //     originalPrice: 495,
  //     imageUrl:
  //         "https://images.unsplash.com/photo-1563636619-e9143da7973b?w=300&h=300&fit=crop",
  //     rating: 4.5,
  //     reviews: 128,
  //     store: "Asian Super Store Pvt. Ltd",
  //     inStock: true,
  //     description:
  //         "Horlicks is a nutritional malted milk drink made from wheat, barley, and milk solids. Originally developed in the late 19th century, it is popular in countries like India and the UK. Horlicks is often consumed as a health drink, especially for children and adults, and is marketed as supporting growth, strength, and immunity.",
  //   ),
  //   Product(
  //     id: 2,
  //     name: "Basmati Rice 5KG",
  //     price: 890,
  //     originalPrice: 950,
  //     imageUrl:
  //         "https://media.istockphoto.com/id/519309790/photo/pile-of-raw-basmati-rice-with-a-spoon.jpg?s=2048x2048&w=is&k=20&c=T_X5ZPYLGLoGJmiFpkozeXjl7jf1Chd9wtfzYXJLuvw=",
  //     rating: 4.8,
  //     reviews: 256,
  //     store: "Grain Master Store",
  //     inStock: true,
  //     description:
  //         "Premium quality aged basmati rice with extra long grains and authentic aroma. Perfect for biryanis, pulavs and everyday cooking.",
  //   ),
  //   Product(
  //     id: 3,
  //     name: "Organic Honey 1kg",
  //     price: 1200,
  //     originalPrice: 1350,
  //     imageUrl:
  //         "https://images.unsplash.com/photo-1587049352851-8d4e89133924?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  //     rating: 4.7,
  //     reviews: 89,
  //     store: "Nature's Best",
  //     inStock: true,
  //     description:
  //         "Pure organic honey sourced from pristine mountain forests. Rich in antioxidants and natural enzymes.",
  //   ),
  //   Product(
  //     id: 4,
  //     name: "Wheat Flour 10kg",
  //     price: 650,
  //     originalPrice: 720,
  //     imageUrl:
  //         "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=300&h=300&fit=crop",
  //     rating: 4.6,
  //     reviews: 167,
  //     store: "Flour Mills Co.",
  //     inStock: true,
  //     description:
  //         "Fresh ground whole wheat flour, stone milled for better nutrition and taste. Perfect for rotis and bread.",
  //   ),
  // ];
  final List<Product> popularItems = [
    Product(
      id: 1,
      name: "Steam Momo (12 pcs)",
      price: 220,
      originalPrice: 250,
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1661601700660-578fb99d9c51?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      rating: 4.7,
      reviews: 156,
      store: "Himalayan Momo House",
      inStock: true,
      description:
          "Delicious steamed dumplings filled with minced chicken, fresh vegetables and traditional spices. Served with homemade spicy tomato chutney.",
    ),
    Product(
      id: 2,
      name: "Margherita Pizza",
      price: 599,
      originalPrice: 699,
      imageUrl:
          "https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?w=500&h=500&fit=crop&crop=center",
      rating: 4.5,
      reviews: 203,
      store: "Italian Pizza Corner",
      inStock: true,
      description:
          "Classic Margherita pizza with fresh tomato sauce, mozzarella cheese, and basil leaves on a thin crispy crust. Baked in traditional wood-fired oven.",
    ),
    Product(
      id: 3,
      name: "Chicken Chowmein",
      price: 180,
      originalPrice: 210,
      imageUrl:
          "https://images.unsplash.com/photo-1585032226651-759b368d7246?w=500&h=500&fit=crop&crop=center",
      rating: 4.4,
      reviews: 189,
      store: "Chinese Wok",
      inStock: true,
      description:
          "Stir-fried noodles with tender chicken pieces, fresh vegetables, and savory sauces. Cooked to perfection with authentic Chinese flavors.",
    ),
    Product(
      id: 4,
      name: "Coca-Cola (2L)",
      price: 120,
      originalPrice: 140,
      imageUrl:
          "https://images.unsplash.com/photo-1554866585-cd94860890b7?w=500&h=500&fit=crop&crop=center",
      rating: 4.8,
      reviews: 312,
      store: "Beverage World",
      inStock: true,
      description:
          "Refreshing Coca-Cola soft drink in 2-liter bottle. Perfect with meals or as a refreshing beverage on its own.",
    ),
    Product(
      id: 5,
      name: "Pepperoni Pizza",
      price: 849,
      originalPrice: 949,
      imageUrl:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500&h=500&fit=crop&crop=center",
      rating: 4.6,
      reviews: 178,
      store: "Pizza Palace",
      inStock: true,
      description:
          "Large pepperoni pizza with extra cheese, spicy pepperoni slices, and our signature tomato sauce on a hand-tossed crust.",
    ),
  ];

  final List<Product> allItems = [
    Product(
      id: 9,
      name: "Green Tea Bags 100pcs",
      price: 299,
      originalPrice: 350,
      imageUrl:
          "https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?w=300&h=300&fit=crop",
      rating: 4.3,
      reviews: 94,
      store: "Tea Garden",
      inStock: true,
      description:
          "Premium green tea bags with natural antioxidants. Refreshing taste and health benefits in every cup.",
    ),
    Product(
      id: 6,
      name: "Almonds Premium 1kg",
      price: 1450,
      originalPrice: 1600,
      imageUrl:
          "https://images.unsplash.com/photo-1508061253366-f7da158b6d46?w=300&h=300&fit=crop",
      rating: 4.9,
      reviews: 203,
      store: "Dry Fruits Hub",
      inStock: false,
      description:
          "California almonds, rich in vitamin E and healthy fats. Perfect for snacking and cooking.",
    ),
    Product(
      id: 7,
      name: "Coconut Oil 1L",
      price: 380,
      originalPrice: 420,
      imageUrl:
          "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=300&h=300&fit=crop",
      rating: 4.4,
      reviews: 156,
      store: "Tropical Oils",
      inStock: true,
      description:
          "Pure cold-pressed coconut oil. Great for cooking, hair care, and skin care.",
    ),
    Product(
      id: 8,
      name: "Dark Chocolate 200g",
      price: 450,
      originalPrice: 500,
      imageUrl:
          "https://images.unsplash.com/photo-1549007953-2f2dc0b24019?w=300&h=300&fit=crop",
      rating: 4.8,
      reviews: 312,
      store: "Choco Delights",
      inStock: true,
      description:
          "70% dark chocolate with intense cocoa flavor. Rich in antioxidants and perfect for chocolate lovers.",
    ),
  ];

  void toggleFavorite(int productId) {
    setState(() {
      if (favorites.contains(productId)) {
        favorites.remove(productId);
      } else {
        favorites.add(productId);
      }
    });
  }

  void navigateToDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
          isFavorite: favorites.contains(product.id),
          onFavoriteToggle: () => toggleFavorite(product.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> combinedItems = [...popularItems, ...allItems];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Popular Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 16),
                        child: PopularItemCard(
                          product: popularItems[index],
                          isFavorite:
                              favorites.contains(popularItems[index].id),
                          onFavoriteToggle: () =>
                              toggleFavorite(popularItems[index].id),
                          onTap: () => navigateToDetail(popularItems[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'All Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: combinedItems.length,
                  itemBuilder: (context, index) {
                    return GridItemCard(
                      product: combinedItems[index],
                      isFavorite: favorites.contains(combinedItems[index].id),
                      onFavoriteToggle: () =>
                          toggleFavorite(combinedItems[index].id),
                      onTap: () => navigateToDetail(combinedItems[index]),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopularItemCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const PopularItemCard({
    Key? key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: .5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    product.imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                if (!product.inStock)
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: const Center(
                        child: Text(
                          'Out of Stock',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.store,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < product.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 14,
                          );
                        }),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.reviews})',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rs. ${product.price}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              'Rs. ${product.originalPrice}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: product.inStock
                                ? Colors.green[100]
                                : Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            product.inStock ? 'In Stock' : 'Out of Stock',
                            style: TextStyle(
                              fontSize: 10,
                              color: product.inStock
                                  ? Colors.green[800]
                                  : Colors.red[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
