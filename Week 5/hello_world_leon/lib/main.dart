import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Import the widgets you created in separate files per Praktikum instructions.
import 'basic_widgets/loading_cupertino.dart';
import 'basic_widgets/fab_widget.dart';

void main() {
  runApp(const MyApp());
}

// Root app with a simple menu to test all widgets from Praktikum 5.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 5 - Demo Widgets',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomeMenu(),
      routes: {
        '/cupertino': (_) => const LoadingCupertino(),
        '/fab': (_) => const FabWidget(),
        '/scaffold-counter': (_) =>
            const CounterScaffoldPage(title: 'My Increment App'),
        '/dialog': (_) => const AlertDialogPage(),
        '/textfield': (_) => const TextFieldPage(),
        '/datepicker': (_) => const DatePickerPage(title: 'Contoh Date Picker'),
      },
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_MenuItem>[
      _MenuItem('Cupertino Button & Loading', '/cupertino', Icons.apple),
      _MenuItem('Floating Action Button (FAB)', '/fab', Icons.touch_app),
      _MenuItem('Scaffold + Counter', '/scaffold-counter', Icons.dashboard),
      _MenuItem('Dialog (AlertDialog)', '/dialog', Icons.notifications),
      _MenuItem('Input: TextField', '/textfield', Icons.text_fields),
      _MenuItem('Date & Time Pickers', '/datepicker', Icons.date_range),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Praktikum 5 - Demo Widgets')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (_, i) {
          final it = items[i];
          return ListTile(
            leading: Icon(it.icon, color: Colors.red),
            title: Text(it.title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, it.route),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: items.length,
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final String route;
  final IconData icon;
  _MenuItem(this.title, this.route, this.icon);
}

// =======================
// Langkah 3: Scaffold Widget (Counter)
// =======================
class CounterScaffoldPage extends StatefulWidget {
  const CounterScaffoldPage({super.key, required this.title});
  final String title;

  @override
  State<CounterScaffoldPage> createState() => _CounterScaffoldPageState();
}

class _CounterScaffoldPageState extends State<CounterScaffoldPage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(child: SizedBox(height: 50.0)),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// =======================
// Langkah 4: Dialog Widget (AlertDialog)
// =======================
class AlertDialogPage extends StatelessWidget {
  const AlertDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog - AlertDialog')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Show alert'),
          onPressed: () => _showAlertDialog(context),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    final okButton = TextButton(
      child: const Text('OK'),
      onPressed: () => Navigator.pop(context),
    );

    final alert = AlertDialog(
      title: const Text('My title'),
      content: const Text('This is my message.'),
      actions: [okButton],
    );

    showDialog(context: context, builder: (ctx) => alert);
  }
}

// =======================
// Langkah 5: Input & Selection - TextField
// =======================
class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contoh TextField')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama',
          ),
        ),
      ),
    );
  }
}

// =======================
// Langkah 6: Date & Time Pickers - DatePicker
// =======================
class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key, required this.title});
  final String title;

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatted = "${selectedDate.toLocal()}".split(' ')[0];
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(formatted),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await _selectDate(context);
                // ignore: avoid_print
                print(
                  selectedDate.day + selectedDate.month + selectedDate.year,
                );
              },
              child: const Text('Pilih Tanggal'),
            ),
          ],
        ),
      ),
    );
  }
}
