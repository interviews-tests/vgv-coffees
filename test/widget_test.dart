import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgvcoffees/data/coffee_repository.dart';
import 'package:vgvcoffees/main.dart';

class MockCoffeeRepo extends Mock implements CoffeeRepository {}

void main() {
  late MockCoffeeRepo mockCoffeeRepository;

  setUp(() {
    mockCoffeeRepository = MockCoffeeRepo();
  });

  testWidgets('MyApp should contain 2 tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(coffeeRepository: mockCoffeeRepository),
      ),
    );
    expect(find.byIcon(Icons.coffee), findsOneWidget);
    expect(find.text('Coffees'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
  });
}
