import 'package:shared_preferences/shared_preferences.dart';

class CounterController {
  int _counter = 0; 
  int _step = 1; 
  final List<String> _history = [];

  int get value => _counter; 
  int get step => _step; 
  List<String> get history => List.unmodifiable(_history);

  void setStep(int newStep) 
  {
    if (newStep > 0) {
      _step = newStep;
    }
  }

  void _addHistory(String action) {
    final time = "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
    _history.insert(0, "$action pada jam $time");

    if (_history.length > 5) {
      _history.removeLast();
    }
  }

  void increment(String username) 
  {
    _counter += _step;
    _addHistory("User menambah $_step");
    saveLastValue(username);
  } 
  void decrement(String username) 
  {
    if (_counter - _step >= 0) _counter -= _step;
    _addHistory("User mengurangi $_step");
    saveLastValue(username);
  }
  void reset(String username) 
  {
    _counter = 0;
    _addHistory("User reset counter");
    saveLastValue(username);
  } 

  Future<void> saveLastValue(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter_$username', _counter);
  }

  Future<void> loadLastValue(String username) async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('counter_$username') ?? 0;
  }
}
