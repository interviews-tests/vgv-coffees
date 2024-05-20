import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:vgvcoffees/data/coffee_repository.dart';
import 'package:vgvcoffees/models/coffee.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final CoffeeRepository coffeeRepository;

  CoffeeBloc({required this.coffeeRepository}) : super(InitialCoffee()) {
    on<FetchCoffee>((event, emit) async {
      await _fetchSingleCoffee(event, emit);
    });

    on<ToggleFavorite>((event, emit) {
      _toggleFavorite(event, emit);
    });
    on<LoadFavoriteImages>((event, emit) async {
      await _loadFavoriteCoffees(event, emit);
    });
  }

  Future<void> _fetchSingleCoffee(
      FetchCoffee event, Emitter<CoffeeState> emit) async {
    emit(CoffeeLoading());
    try {
      final Coffee coffeeImage = await coffeeRepository.fetchCoffeeImages();
      final currentState = state;
      add(LoadFavoriteImages());
      if (currentState is CoffeeLoaded) {
        emit(CoffeeLoaded(
            coffeeImage: coffeeImage,
            favoriteCoffees: currentState.favoriteCoffees));
      } else {
        emit(
            CoffeeLoaded(coffeeImage: coffeeImage, favoriteCoffees: const []));
      }
    } catch (_) {
      emit(CoffeeError());
    }
  }

  void _toggleFavorite(ToggleFavorite event, Emitter<CoffeeState> emit) {
    final imageUrl = event.imageUrl;
    final currentState = state;
    if (currentState is CoffeeLoaded) {
      final List<Coffee> favoriteImages =
          List.from(currentState.favoriteCoffees);
      if (favoriteImages.any((coffee) => coffee.imageUrl == imageUrl)) {
        favoriteImages.removeWhere((coffee) => coffee.imageUrl == imageUrl);
        _removeFavoriteImage(imageUrl);
      } else {
        _saveFavoriteImage(imageUrl);
        favoriteImages.add(Coffee(imageUrl: imageUrl));
      }
      emit(CoffeeLoaded(
          coffeeImage: currentState.coffeeImage,
          favoriteCoffees: favoriteImages));
    }
  }

  Future<void> _loadFavoriteCoffees(
      LoadFavoriteImages event, Emitter<CoffeeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteImageUrls = prefs.getStringList('favoriteImages') ?? [];
      final favoriteImages = <Coffee>[];
      for (String imageUrl in favoriteImageUrls) {
        final base64Image = prefs.getString(imageUrl);
        if (base64Image != null) {
          final Uint8List bytes = base64Decode(base64Image);
          favoriteImages.add(Coffee(imageUrl: imageUrl, imageData: bytes));
        }
      }
      final currentState = state;
      if (currentState is CoffeeLoaded) {
        emit(CoffeeLoaded(
          coffeeImage: currentState.coffeeImage,
          favoriteCoffees: favoriteImages,
        ));
      } else {
        // Offline support here
        emit(CoffeeLoaded(
          coffeeImage: null,
          favoriteCoffees: favoriteImages,
        ));
      }
    } catch (_) {
      emit(CoffeeError());
    }
  }

  Future<void> _saveFavoriteImage(String imageUrl) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final base64Image = await coffeeRepository.fetchImageAsBase64(imageUrl);
      await prefs.setString(imageUrl, base64Image);
      final favoriteImageUrls = prefs.getStringList('favoriteImages') ?? [];
      if (!favoriteImageUrls.contains(imageUrl)) {
        favoriteImageUrls.add(imageUrl);
        await prefs.setStringList('favoriteImages', favoriteImageUrls);
      }
    } catch(_){
      debugPrint(_.toString());
      // TODO
      emit(FavoritesCoffeeError());
    }
  }

  Future<void> _removeFavoriteImage(String imageUrl) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(imageUrl);
      final favoriteImageUrls = prefs.getStringList('favoriteImages') ?? [];
      favoriteImageUrls.remove(imageUrl);
      await prefs.setStringList('favoriteImages', favoriteImageUrls);
    } catch(_){
      debugPrint(_.toString());
      // TODO
      emit(FavoritesCoffeeError());
    }
  }
}
