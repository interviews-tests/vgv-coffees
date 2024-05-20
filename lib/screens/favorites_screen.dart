import 'package:vgvcoffees/bloc/coffee_bloc.dart';
import 'package:vgvcoffees/widgets/favorite_coffee_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteImagesScreen extends StatelessWidget {
  const FavoriteImagesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CoffeeBloc>(context).add(LoadFavoriteImages());
    return Scaffold(
      backgroundColor: Colors.brown.withOpacity(.55),
      body: BlocBuilder<CoffeeBloc, CoffeeState>(
        builder: (context, state) {
          if (state is CoffeeLoaded && state.favoriteCoffees.isEmpty) {
            return const Center(
              child: Text(
                'No favorites yet!!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                textScaler: TextScaler.linear(.75),
              ),
            );
          }
          return state is CoffeeLoaded && state.favoriteCoffees.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      // flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.yellow.withOpacity(.12),
                        child: Text(
                            "My favorite coffees: ${state.favoriteCoffees.length}"),
                      ),
                    ),
                    Flexible(
                      flex: 11,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: state.favoriteCoffees.length,
                        itemBuilder: (context, index) {
                          final favoriteImage = state.favoriteCoffees[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FavoriteCoffeeImage(
                              coffee: favoriteImage,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
