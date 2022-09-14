import 'package:aberchat/provider/room_chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomFooterPage extends StatefulWidget {
  const RoomFooterPage({Key? key}) : super(key: key);

  @override
  State<RoomFooterPage> createState() => _RoomFooterPageState();
}

class _RoomFooterPageState extends State<RoomFooterPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<RoomChatProvider>();
    final controller = context.watch<RoomChatProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.controller,
              decoration: const InputDecoration(
                hintText: "Input your message",
              ),
            ),
          ),
          IconButton(
            onPressed: provider.sendChat,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
