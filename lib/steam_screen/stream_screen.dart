import 'package:flutter/material.dart';
import 'package:stream/broadcast_stream/broadcast_stream.dart';
import 'package:stream/steam_screen/counter_stream.dart';

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  final CounterStream _counterStream = CounterStream();

  final NotificationStream _notificationStream = NotificationStream();

  @override
  void dispose() {
    _counterStream.disposeStream();
    _notificationStream.disposeStreamController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream Counter")),
      body: Column(
        children: [
          StreamBuilder<int>(
            stream: _counterStream.stream,
            initialData: 0, // Initial value for the counter
            builder: (context, snapshot) {
              // Display the counter value
              return Text(
                'Counter: ${snapshot.data}',
                style: TextStyle(fontSize: 24),
              );
            },
          ),
          StreamBuilder<String>(
            stream: _notificationStream.broadcastStream,
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, int index) => Text(
                    'Listener 1: ${snapshot.data ?? 'No notifications'}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _notificationStream.history.length,
              itemBuilder: (context, int index) => Text(
                'Listener 1: ${_notificationStream.history[index] ?? 'No notifications'}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // Add a new notification
              _notificationStream
                  .addMessageToStream("New notification at 1888888888 ${DateTime.now()}");
            },
            child: Text("Send Notification"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _counterStream.incrementValue,
        child: Icon(Icons.add),
      ),
    );
  }
}
