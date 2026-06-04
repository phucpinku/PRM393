// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

Future<void> main() async {
  await runProductRepositoryExercise();
  await runUserRepositoryExercise();
  await runMicrotaskExercise();
  await runStreamTransformationExercise();
  runFactoryConstructorExercise();
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
  });

  final int id;
  final String name;
  final double price;

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}

class ProductRepository {
  final List<Product> _products = [
    const Product(id: 1, name: 'Laptop', price: 1200),
    const Product(id: 2, name: 'Mouse', price: 25),
    const Product(id: 3, name: 'Keyboard', price: 75),
  ];

  final StreamController<Product> _addedController =
      StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return List<Product>.unmodifiable(_products);
  }

  Stream<Product> liveAdded() => _addedController.stream;

  void addProduct(Product product) {
    _products.add(product);
    _addedController.add(product);
  }

  Future<void> dispose() => _addedController.close();
}

Future<void> runProductRepositoryExercise() async {
  print('\nExercise 1 - Product Model & Repository');

  final repository = ProductRepository();
  final subscription = repository.liveAdded().listen((product) {
    print('Live added product: $product');
  });

  final products = await repository.getAll();
  print('All products:');
  for (final product in products) {
    print('- $product');
  }

  // The broadcast stream emits this item to all active listeners.
  repository.addProduct(const Product(id: 4, name: 'Monitor', price: 220));

  await Future<void>.delayed(Duration.zero);
  await subscription.cancel();
  await repository.dispose();
}

class User {
  const User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  final String name;
  final String email;

  @override
  String toString() => 'User(name: $name, email: $email)';
}

class UserRepository {
  Future<List<User>> fetchUsers() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    const apiResponse = '''
[
  {"name": "An Nguyen", "email": "an.nguyen@example.com"},
  {"name": "Binh Tran", "email": "binh.tran@example.com"},
  {"name": "Chi Le", "email": "chi.le@example.com"}
]
''';

    final decoded = jsonDecode(apiResponse) as List<dynamic>;
    return decoded
        .map((item) => User.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

Future<void> runUserRepositoryExercise() async {
  print('\nExercise 2 - User Repository with JSON');

  final repository = UserRepository();
  final users = await repository.fetchUsers();

  print('Parsed users:');
  for (final user in users) {
    print('- $user');
  }
}

Future<void> runMicrotaskExercise() async {
  print('\nExercise 3 - Async + Microtask Debugging');
  print('1. Synchronous start');

  scheduleMicrotask(() {
    print('3. Microtask runs before the event queue Future');
  });

  Future<void>(() {
    print('4. Future event callback');
  });

  print('2. Synchronous end');

  // Microtasks are completed before event-queue callbacks such as Future(() {}).
  await Future<void>.delayed(Duration.zero);
}

Future<void> runStreamTransformationExercise() async {
  print('\nExercise 4 - Stream Transformation');

  final transformedStream = Stream<int>.fromIterable([1, 2, 3, 4, 5])
      .map((number) => number * number)
      .where((square) => square.isEven);

  print('Even square values:');
  await for (final value in transformedStream) {
    print('- $value');
  }
}

class Settings {
  Settings._internal();

  static final Settings _instance = Settings._internal();

  factory Settings() {
    return _instance;
  }
}

void runFactoryConstructorExercise() {
  print('\nExercise 5 - Factory Constructors & Cache');

  final firstSettings = Settings();
  final secondSettings = Settings();

  print('identical(firstSettings, secondSettings): '
      '${identical(firstSettings, secondSettings)}');
}
