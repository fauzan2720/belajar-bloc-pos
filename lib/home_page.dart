import 'package:belajar_bloc/bloc/product_bloc.dart';
import 'package:belajar_bloc/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(GetProductEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Belajar Bloc"),
        actions: [
          TextButton(
            onPressed: () {
              final String id = const Uuid().v1();
              context.read<ProductBloc>().add(AddProductEvent(
                      productModel: ProductModel(
                    id: id,
                    productName: "Product $id",
                    quantity: 1,
                  )));
            },
            child: const Text(
              "Tambah Product ke Cart",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          TextButton(
            onPressed: () =>
                context.read<ProductBloc>().add(DeleteAllProductsEvent()),
            child: const Text(
              "Delete All",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, List<ProductModel>>(
        builder: (context, state) {
          return ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: state.length,
              itemBuilder: (context, index) {
                final ProductModel product = state[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () => context
                              .read<ProductBloc>()
                              .add(ReduceQuantityEvent(id: product.id)),
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          product.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        IconButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            context
                                .read<ProductBloc>()
                                .add(AddQuantityEvent(id: product.id));
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            context
                                .read<ProductBloc>()
                                .add(DeleteProductEvent(id: product.id));
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
