import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_app/model/product_model.dart';

class ProductApiService {
  final url = 'https://dummyjson.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> productsJson = jsonData['products'];
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
