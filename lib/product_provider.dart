import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/services/product_api_service.dart';

final productProvider = FutureProvider<List<ProductModel>>((ref) async {
  try {
    final apiClient = ProductApiService();
    return apiClient.fetchProducts();
  } catch (e) {
    e.toString();
    throw e.toString();
  }
});
