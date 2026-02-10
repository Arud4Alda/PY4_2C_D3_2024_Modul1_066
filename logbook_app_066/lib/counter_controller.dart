class CounterController {
  int _counter = 0; // Variabel private (Enkapsulasi)
  int _step = 1; //default stepnya

  int get value => _counter; // Getter untuk akses data counter
  int get step => _step; // Getter untuk akses data step

  void setStep(int newStep) // setter step baru
  {
    if (newStep > 0) 
    {
      _step = newStep;
    }
  }

  void increment() => _counter += _step;
  void decrement() {
    if (_counter - _step >= 0) _counter -= _step;
  }

  void reset() => _counter = 0;
}
