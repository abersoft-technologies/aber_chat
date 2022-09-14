import 'package:aberchat/aberchat.dart';
import 'package:flutter/material.dart';

class AberchatExample extends StatelessWidget {
  const AberchatExample({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RoomPage(
        aberchatConfig: AberchatConfig(
          appId: '631ae2ed3a4f071fd104365a',
          apiKey:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmFiMGNkYWItMDA3My00ZDY0LTg4OTItYjNlODg4YWMyYTJkIiwiaWF0IjoxNjYyNzA2NDEzLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0In0.0lBM1iZkfcdC5yXL3y5qnFYpwKvtT20-s0W2WsBe02w',
          roomId: 'demo-aberchat',
        ),
      ),
    );
  }
}
