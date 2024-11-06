import 'dart:async';

class NotificationStream {
  /// Initialize [Broadcast] stream controller
  final _broadcastStreamController = StreamController<String>.broadcast();

  final List<String> _history = []; // List to keep the history of notifications

  Stream<String> get broadcastStream => _broadcastStreamController.stream;
  List<String> get history => List.unmodifiable(_history);

  /// add Message To Stream
  void addMessageToStream(String message) {
    _broadcastStreamController.sink.add(message);
    _history.add(message); // Add the message to history
  }

  /// Dispose Stream Controller
  void disposeStreamController() {
    _broadcastStreamController.close();
  }

  final controller = StreamController<int>();
  void listenerOnStream() {
    controller.stream.listen(
      (data) => print("Data received: $data"),
      onError: (error) => print("Error received: $error"),
      onDone: () => print("Stream closed"),
    );
  }

  Stream<int> counterStream() async* {
    int counter = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield counter++;
    }
  }
  
}
