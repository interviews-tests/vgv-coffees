import 'package:vgvcoffees/widgets/coffee_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgvcoffees/bloc/coffee_bloc.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  void _fetchCoffee(BuildContext context) {
    BlocProvider.of<CoffeeBloc>(context).add(FetchCoffee());
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<CoffeeBloc>(context).add(FetchCoffee());
    return Scaffold(
      backgroundColor: Colors.brown,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          _fetchCoffee(context);
        },
        child: const Icon(
          size: 30,
          Icons.refresh,
          color: Colors.greenAccent,
        ),
      ),
      body: BlocBuilder<CoffeeBloc, CoffeeState>(
        builder: (context, state) {
          if (state is CoffeeLoaded) {
            if (state.coffeeImage != null) {
              final isFavorite = state.favoriteCoffees.any(
                (coffee) => coffee.imageUrl == state.coffeeImage?.imageUrl,
              );
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: CoffeeImage(
                  coffee: state.coffeeImage!,
                  isFavorite: isFavorite,
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Failed to load coffee image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  textScaler: TextScaler.linear(.75),
                ),
              );
            }
          } else if (state is CoffeeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CoffeeError) {
            return const Center(
              child: Text(
                'No internet connection!!!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                textScaler: TextScaler.linear(.75),
              ),
            );
          } else {
            // TODO
            return const Center(
              child: Text('Something happened on our side!'),
            );
          }
        },
      ),
    );
  }
}
