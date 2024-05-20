import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgvcoffees/bloc/coffee_bloc.dart';
import 'package:vgvcoffees/data/coffee_repository.dart';
import 'package:vgvcoffees/models/coffee.dart';

class MockCoffeeRepo extends Mock implements CoffeeRepository {}

void main() {
  group('CoffeeBloc', () {
    final mockCoffeeRepo = MockCoffeeRepo();
    Coffee coffee = Coffee(
        imageUrl: 'https://coffee.alexflipnote.dev/hZ0RXtcBWjA_coffee.jpg');
    List<Coffee> favCoffeeImages =
        []; // For sake of this test I leave this empty

    blocTest<CoffeeBloc, CoffeeState>(
      'get single coffee',
      build: () => CoffeeBloc(coffeeRepository: mockCoffeeRepo),
      setUp: () =>
          when(() => mockCoffeeRepo.fetchCoffeeImages()).thenAnswer((_) {
        return Future<Coffee>(() => coffee);
      }),
      act: (bloc) => bloc.add(FetchCoffee()),
      expect: () => <CoffeeState>[
        CoffeeLoading(),
        CoffeeLoaded(coffeeImage: coffee, favoriteCoffees: favCoffeeImages),
        CoffeeError()
      ],
    );

    blocTest<CoffeeBloc, CoffeeState>(
      'get single coffee error',
      build: () => CoffeeBloc(coffeeRepository: mockCoffeeRepo),
      setUp: () =>
          when(() => mockCoffeeRepo.fetchCoffeeImages()).thenAnswer((_) {
        throw Exception('Failed to load coffee images');
      }),
      act: (bloc) => bloc.add(FetchCoffee()),
      expect: () => <CoffeeState>[CoffeeLoading(), CoffeeError()],
    );
  });
}
