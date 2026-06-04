import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _setDarkMode(bool enabled) {
    setState(() {
      _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF5E6197);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Flutter UI Fundamentals',
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        scaffoldBackgroundColor: const Color(0xFFFCF8FF),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onDarkModeChanged: _setDarkMode,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    final exercises = [
      ExerciseMenuItem(
        title: 'Exercise 1 - Core Widgets\nDemo',
        screen: const CoreWidgetsDemo(),
      ),
      ExerciseMenuItem(
        title: 'Exercise 2 - Input Controls\nDemo',
        screen: const InputControlsDemo(),
      ),
      ExerciseMenuItem(
        title: 'Exercise 3 - Layout Demo',
        screen: const LayoutDemo(),
      ),
      ExerciseMenuItem(
        title: 'Exercise 4 - App Structure &\nTheme',
        screen: AppStructureDemo(
          isDarkMode: isDarkMode,
          onDarkModeChanged: onDarkModeChanged,
        ),
      ),
      ExerciseMenuItem(
        title: 'Exercise 5 - Common UI\nFixes',
        screen: const CommonUiFixesDemo(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab 4 - Flutter UI Fundamentals',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(14, 28, 14, 16),
        itemBuilder: (context, index) {
          final exercise = exercises[index];

          return Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              minVerticalPadding: 12,
              title: Text(exercise.title, style: const TextStyle(fontSize: 16)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => exercise.screen),
                );
              },
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemCount: exercises.length,
      ),
    );
  }
}

class ExerciseMenuItem {
  const ExerciseMenuItem({required this.title, required this.screen});

  final String title;
  final Widget screen;
}

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercise 1 - Core Widgets Demo',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(6, 20, 6, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Flutter UI',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 28),
            const Center(
              child: Icon(Icons.movie, color: Colors.blue, size: 56),
            ),
            const SizedBox(height: 28),
            Image.asset(
              'Furina_birthday.jpg',
              height: 154,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 154,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 48),
                );
              },
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Movie Item'),
                subtitle: const Text(
                  'This is a sample ListTile inside a\nCard.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _rating = 50;
  bool _isActive = false;
  String? _selectedGenre;
  DateTime? _selectedDate;

  Future<void> _openDatePicker() async {
    // showDatePicker must be called from a valid widget context.
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateLabel = _selectedDate == null
        ? null
        : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercise 2 - Input Controls Demo',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(2, 18, 2, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle('Rating (Slider)'),
            Slider(
              value: _rating,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            Text('Current value: ${_rating.round()}'),
            const SizedBox(height: 24),
            const SectionTitle('Active (Switch)'),
            SwitchListTile(
              title: const Text('Is movie active?'),
              value: _isActive,
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                });
              },
              contentPadding: const EdgeInsets.only(left: 12, right: 22),
            ),
            const SizedBox(height: 14),
            const SectionTitle('Genre (RadioListTile)'),
            RadioGroup<String>(
              groupValue: _selectedGenre,
              onChanged: _setGenre,
              child: const Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Action'),
                    value: 'Action',
                    contentPadding: EdgeInsets.only(left: 8),
                  ),
                  RadioListTile<String>(
                    title: Text('Comedy'),
                    value: 'Comedy',
                    contentPadding: EdgeInsets.only(left: 8),
                  ),
                ],
              ),
            ),
            Text('Selected genre: ${_selectedGenre ?? 'None'}'),
            if (selectedDateLabel != null) ...[
              const SizedBox(height: 8),
              Text('Selected date: $selectedDateLabel'),
            ],
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _openDatePicker,
                child: const Text('Open Date Picker'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setGenre(String? value) {
    setState(() {
      _selectedGenre = value;
    });
  }
}

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  static const movies = ['Avatar', 'Inception', 'Interstellar', 'Joker'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercise 3 - Layout Demo',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4, 26, 4, 16),
        child: Column(
          children: [
            Text(
              'Now Playing',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return Card(
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFDDE0FF),
                        child: Text(movie.substring(0, 1)),
                      ),
                      title: Text(movie),
                      subtitle: const Text('Sample description'),
                    ),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemCount: movies.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppStructureDemo extends StatelessWidget {
  const AppStructureDemo({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercise 4 - App Structure & Theme',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          const Center(child: Text('Dark')),
          Switch(value: isDarkMode, onChanged: onDarkModeChanged),
          const SizedBox(width: 4),
        ],
      ),
      body: const Center(
        child: Text('This is a simple screen with theme toggle.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FloatingActionButton tapped')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CommonUiFixesDemo extends StatelessWidget {
  const CommonUiFixesDemo({super.key});

  static const movies = ['Movie A', 'Movie B', 'Movie C', 'Movie D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercise 5 - Common UI Fixes',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6, 26, 6, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Correct ListView inside Column using\nExpanded',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Expanded gives ListView a bounded height inside Column.
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.movie),
                    title: Text(movies[index]),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemCount: movies.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
