// --- Exercise 4 Classes ---
class Car {
  String brand;

  // Default constructor
  Car(this.brand);

  // Named constructor
  Car.custom(this.brand);

  void drive() {
    print('$brand is driving on gas.');
  }
}

class ElectricCar extends Car {
  // Pass the brand to the parent (super) class
  ElectricCar(String brand) : super(brand);

  // Overriding the parent's drive method
  @override
  void drive() {
    print('$brand is driving silently on electricity.');
  }
}

// --- Exercise 3 Functions ---
// Normal syntax function
int calculateTotal(int a, int b) {
  return a + b;
}

// Arrow syntax function (perfect for single expressions)
int multiply(int a, int b) => a * b;

// --- Exercise 5 Async & Streams ---
Future<void> fetchMockData() async {
  print('Loading data...');
  // Simulates a 2-second network delay
  await Future.delayed(const Duration(seconds: 2));
  print('Data loaded successfully!');
}

Stream<int> numberStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i; // yield emits a value to the stream
  }
}

void main() async {
  // ---------------------------------------------------------
  print('\n--- EXERCISE 1: Basic Syntax & Data Types ---');
  // ---------------------------------------------------------
  int age = 25;
  double height = 1.75;
  String name = "Phucle";
  bool isStudent = true;

  print('Name: $name, Age: $age');
  print('height: $height, isStudent: $isStudent');

  // ---------------------------------------------------------
  print('\n--- EXERCISE 2: Collections & Operators ---');
  // ---------------------------------------------------------
  // List
  List<int> numbers = [10, 20, 30];
  numbers.add(40);
  numbers.remove(10);
  print('List after modifications: $numbers');
  print('Value at index 0: ${numbers[0]}');

  // Operators (+, -, ==, &&, ? :)
  int sum = numbers[0] + numbers[1]; // 20 + 30 = 50
  bool isLarge = sum > 40;
  bool isExact = (sum == 50) && isLarge;

  // Ternary Operator
  String resultMessage = isExact ? "Math is correct!" : "Something is wrong.";
  print('Ternary output: $resultMessage');

  // Set (Automatically ignores the duplicate 'Apple')
  Set<String> uniqueFruits = {'Apple', 'Banana', 'Orange'};
  print('Set : $uniqueFruits');

  // Map (Key-Value pairs)
  Map<String, String> userProfile = {'username': 'coder123', 'role': 'admin'};
  print('Map lookup (Role): ${userProfile['role']}');

  // ---------------------------------------------------------
  print('\n--- EXERCISE 3: Control Flow & Functions ---');
  // ---------------------------------------------------------
  // If/Else
  int score = 85;
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else {
    print('Grade: C');
  }

  // Switch Case
  int dayOfWeek = 3;
  switch (dayOfWeek) {
    case 1:
      print('Monday');
      break;
    case 3:
      print('Wednesday');
      break;
    case 5:
      print('Friday');
      break;
    default:
      print('Another day');
  }

  // Loops
  print('\nStandard For Loop:');
  for (int i = 0; i < numbers.length; i++) {
    print('Index $i: ${numbers[i]}');
  }

  print('\nFor-In Loop:');
  for (var number in numbers) {
    print('Value: $number');
  }

  print('\nforEach Loop:');
  numbers.forEach((number) => print('Value via forEach: $number'));

  print('\nNormal Function result: ${calculateTotal(10, 5)}');
  print('Arrow Function result: ${multiply(10, 5)}');

  // ---------------------------------------------------------
  print('\n--- EXERCISE 4: Intro to OOP ---');
  // ---------------------------------------------------------
  // Standard object creation
  Car standardCar = Car('Toyota');
  standardCar.drive();

  // Using a named constructor
  Car customCar = Car.custom('Honda');
  customCar.drive();

  // Using the subclass to see the overridden method
  ElectricCar tesla = ElectricCar('Tesla');
  tesla.drive();

  // ---------------------------------------------------------
  print('\n--- EXERCISE 5: Async, Future, Null Safety & Streams ---');
  // ---------------------------------------------------------
  // Null Safety Operators
  String? mightBeNull;

  // ? operator (Prevents crash if null, just returns null)
  print('String length: ${mightBeNull?.length}');

  // ?? operator (Provides a default fallback value if null)
  String safeString = mightBeNull ?? 'Fallback String Active';
  print('Using fallback: $safeString');

  // ! operator (Force unwrap)
  // We assign a value first so it is mathematically safe to force unwrap without crashing.
  mightBeNull = "I am safely populated now!";
  print('Forced unwrap: ${mightBeNull!}');

  // Async / Await
  await fetchMockData();

  // Listening to a Stream
  print('Starting stream processing...');
  await for (int value in numberStream()) {
    print('Stream emitted: $value');
  }

  print('\nLab completed successfully!');
}
