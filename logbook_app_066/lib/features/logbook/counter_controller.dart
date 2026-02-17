import 'package:shared_preferences/shared_preferences.dart';


class CounterController {
  int _counter = 0; // Variabel private (Enkapsulasi)
  int _step = 1; //default stepnya
  final List<String> _history = [];

  int get value => _counter; // Getter untuk akses data counter
  int get step => _step; // Getter untuk akses data step
  List<String> get history => List.unmodifiable(_history);

  void setStep(int newStep) // setter step baru
  {
    if (newStep > 0) {
      _step = newStep;
    }
  }

  void _addHistory(String action) {
    final time =
        "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
    _history.insert(0, "$action pada jam $time");

    if (_history.length > 5) {
      _history.removeLast();
    }
  }

  void increment() 
  {
    _counter += _step;
    _addHistory("User menambah $_step");
    saveLastValue();
  } 
  void decrement() 
  {
    if (_counter - _step >= 0) _counter -= _step;
    _addHistory("User mengurangi $_step");
    saveLastValue();
  }
  void reset() 
  {
    _counter = 0;
    _addHistory("User reset counter");
    saveLastValue();
  } 

  Future<void> saveLastValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_counter', _counter);
  }

  Future<void> loadLastValue() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('last_counter') ?? 0;
  }
}
