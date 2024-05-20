import 'package:vgvcoffees/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgvcoffees/bloc/coffee_bloc.dart';
import 'package:vgvcoffees/data/coffee_repository.dart';
import 'package:vgvcoffees/screens/coffee_screen.dart';

void main() {
  final CoffeeRepository coffeeRepository = CoffeeRepository();
  runApp(MyApp(coffeeRepository: coffeeRepository));
}

class MyApp extends StatelessWidget {
  final CoffeeRepository coffeeRepository;

  const MyApp({super.key, required this.coffeeRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CoffeeBloc(
            coffeeRepository: coffeeRepository,
          ),
        ),
      ],
      child: MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.coffee), text: 'Coffees'),
                  Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                CoffeeScreen(),
                FavoriteImagesScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

