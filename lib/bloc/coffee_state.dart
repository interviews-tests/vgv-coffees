part of 'coffee_bloc.dart';

abstract class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object> get props => [];
}

class InitialCoffee extends CoffeeState {}

class CoffeeLoading extends CoffeeState {}

class CoffeeLoaded extends CoffeeState {
  final Coffee? coffeeImage;
  final List<Coffee> favoriteCoffees;
  const CoffeeLoaded({
    this.coffeeImage,
    required this.favoriteCoffees,
  });

  @override
  List<Object> get props => [coffeeImage!, favoriteCoffees];
}

class CoffeeError extends CoffeeState {}
class FavoritesCoffeeError extends CoffeeState {}
