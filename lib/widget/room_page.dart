import 'package:aberchat/aberchat.dart';
import 'package:aberchat/provider/room_chat_provider.dart';
import 'package:aberchat/widget/room_body_page.dart';
import 'package:aberchat/widget/room_footer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({
    Key? key,
    required this.aberchatConfig,
    this.onReceivedEvent,
  }) : super(key: key);

  final AberchatConfig aberchatConfig;
  final OnReceivedEvent? onReceivedEvent;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoomChatProvider()),
      ],
      child: RoomChatPage(
        aberchatConfig: aberchatConfig,
      ),
    );
  }
}

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({
    Key? key,
    required this.aberchatConfig,
  }) : super(key: key);

  final AberchatConfig aberchatConfig;

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  void initChat() {
    final provider = context.read<RoomChatProvider>();
    provider.initSocket(widget.aberchatConfig);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initChat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          child: RoomBodyPage(),
        ),
        RoomFooterPage()
      ],
    );
  }
}
