part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final ProductModel productModel;

  const AddProductEvent({
    required this.productModel,
  });
}

class AddQuantityEvent extends ProductEvent {
  final String id;

  const AddQuantityEvent({
    required this.id,
  });
}

class ReduceQuantityEvent extends ProductEvent {
  final String id;

  const ReduceQuantityEvent({
    required this.id,
  });
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  const DeleteProductEvent({
    required this.id,
  });
}

class DeleteAllProductsEvent extends ProductEvent {}
