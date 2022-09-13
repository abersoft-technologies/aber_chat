import 'package:aberchat_example/aberchat_example.dart';
import 'package:aberchat_example/custom_chat_room.dart';
import 'package:aberchat_example/next_chat_room.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AberChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AberChat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Example 1'),
            subtitle: const Text('Using AberChat Example'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const AberchatExample(title: 'AberChat Example');
                }),
              );
            },
          ),
          ListTile(
            title: const Text('Example 2'),
            subtitle: const Text('Custom Widget'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const CustomChatRoom(title: 'Custom Chat Room');
                }),
              );
            },
          ),
          ListTile(
            title: const Text('Example 3'),
            subtitle: const Text('Next Custom Widget'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const NextChatRoom(title: 'Next Custom Widget');
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
