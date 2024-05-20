import 'package:vgvcoffees/bloc/coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vgvcoffees/models/coffee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCoffeeImage extends StatelessWidget {
  final Coffee coffee;

  const FavoriteCoffeeImage({
    super.key,
    required this.coffee,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: coffee.imageData != null
              ? Image.memory(
                  coffee.imageData!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .55,
                )
              : null,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Center(
              child: IconButton(
                icon: const Icon(
                  size: 20,
                  Icons.heart_broken_sharp,
                  color: Colors.grey,
                ),
                onPressed: () {
                  BlocProvider.of<CoffeeBloc>(context)
                      .add(ToggleFavorite(coffee.imageUrl));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
