part of 'coffee_bloc.dart';

abstract class CoffeeEvent extends Equatable {
  const CoffeeEvent();

  @override
  List<Object> get props => [];
}

class FetchCoffee extends CoffeeEvent {}

class ToggleFavorite extends CoffeeEvent {
  final String imageUrl;

  const ToggleFavorite(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}
class LoadFavoriteImages extends CoffeeEvent {}