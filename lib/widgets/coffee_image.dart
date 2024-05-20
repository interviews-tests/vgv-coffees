import 'package:vgvcoffees/bloc/coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vgvcoffees/models/coffee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeImage extends StatelessWidget {
  final Coffee coffee;
  final bool isFavorite;

  const CoffeeImage(
      {super.key, required this.coffee, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12), // Rounded corners
          child: Image.network(
            coffee.imageUrl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .55,
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              BlocProvider.of<CoffeeBloc>(context)
                  .add(ToggleFavorite(coffee.imageUrl));
            },
          ),
        ),
      ],
    );
  }
}
