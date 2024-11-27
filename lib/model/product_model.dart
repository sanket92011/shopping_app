class ProductModel {
  final String title;
  final String brand;
  final double originalPrice;
  final double discountPercentage;
  final String productUrl;
  int quantity;

  ProductModel({
    required this.title,
    required this.brand,
    required this.originalPrice,
    required this.discountPercentage,
    required this.productUrl,
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      originalPrice: (json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'] ?? 0.0),
      discountPercentage: (json['discountPercentage'] is int
          ? (json['discountPercentage'] as int).toDouble()
          : json['discountPercentage'] ?? 0.0),
      productUrl: json['thumbnail'] ?? "",
    );
  }
}
