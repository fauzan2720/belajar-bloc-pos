import 'package:belajar_bloc/product_model.dart';
import 'package:belajar_bloc/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, List<ProductModel>> {
  final ProductService service = ProductService();

  ProductBloc() : super([]) {
    on<GetProductEvent>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 2000));
      emit(service.products);
    });

    on<AddProductEvent>((event, emit) {
      service.addProduct(event.productModel);
      emit(service.products);
    });

    on<AddQuantityEvent>((event, emit) {
      service.addQuantity(event.id);
      emit(service.products);
    });

    on<ReduceQuantityEvent>((event, emit) {
      service.reduceQuantity(event.id);
      emit(service.products);
    });

    on<DeleteProductEvent>((event, emit) {
      service.deleteProduct(event.id);
      emit(service.products);
    });

    on<DeleteAllProductsEvent>((event, emit) {
      service.deleteAllProducts();
      emit(service.products);
    });
  }
}
