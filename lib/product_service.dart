import 'package:belajar_bloc/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  late SharedPreferences _preferences;
  List<ProductModel> products = [];

  ProductService() {
    init();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    products = _getProductsFromLocalStorage() ?? [];
  }

  List<ProductModel>? _getProductsFromLocalStorage() {
    final List<String>? productStrings = _preferences.getStringList('products');

    if (productStrings != null) {
      return productStrings
          .map((productString) => ProductModel.fromJson(productString))
          .toList();
    }

    return null;
  }

  Future<void> saveToLocalStorage() async {
    await _preferences.setStringList(
      'products',
      products.map((product) => product.toJson()).toList(),
    );
    products = _getProductsFromLocalStorage() ?? [];
  }

  void addProduct(ProductModel productModel) {
    products.add(productModel);
    saveToLocalStorage();
  }

  void deleteProduct(String id) {
    products.removeWhere((element) => element.id == id);
    saveToLocalStorage();
  }

  void addQuantity(String id) {
    final int targetIndex = products.indexWhere((data) => data.id == id);
    products[targetIndex].quantity++;
    saveToLocalStorage();
  }

  void reduceQuantity(String id) {
    final int targetIndex = products.indexWhere((data) => data.id == id);
    if (products[targetIndex].quantity > 1) {
      products[targetIndex].quantity--;
      saveToLocalStorage();
    }
  }

  void deleteAllProducts() {
    products.clear();
    saveToLocalStorage();
  }
}
