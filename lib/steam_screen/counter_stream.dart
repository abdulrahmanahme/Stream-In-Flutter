import 'dart:async';

class CounterStream {
  /// initialize Stream controller
  final _streamController = StreamController<int>();

  Stream<int> get stream => _streamController.stream;

  // counter value
  int counter = 0;

  /// to incrementValue counter
  void incrementValue() {
    counter++;
    _streamController.sink.add(counter);
  }

  /// Dispose Stream
  void disposeStream() {
    _streamController.close();
  }

}
