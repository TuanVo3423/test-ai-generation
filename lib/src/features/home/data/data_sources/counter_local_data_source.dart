class CounterLocalDataSource {
  int _counter = 0;

  int getCounter() => _counter;

  int increment() {
    _counter += 1;
    return _counter;
  }
}

