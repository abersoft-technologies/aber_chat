import 'package:aberchat/provider/room_chat_provider.dart';
import 'package:aberchat/widget/chat_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomBodyPage extends StatefulWidget {
  const RoomBodyPage({Key? key}) : super(key: key);

  @override
  State<RoomBodyPage> createState() => _RoomBodyPageState();
}

class _RoomBodyPageState extends State<RoomBodyPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RoomChatProvider>();
    return ListView.separated(
      shrinkWrap: true,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: provider.listChatReverse.length,
      itemBuilder: (_, index) {
        final chat = provider.listChatReverse[index];
        return ChatItemWidget(chat: chat, senderId: provider.senderId);
      },
      separatorBuilder: (_, index) {
        return const SizedBox();
      },
    );
  }
}
