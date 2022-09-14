import 'package:aberchat/aberchat.dart';
import 'package:aberchat/provider/room_chat_provider.dart';
import 'package:aberchat/widget/room_body_page.dart';
import 'package:aberchat/widget/room_footer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnReceivedEvent = void Function(dynamic data);
typedef CallbackRoomPage = Widget Function(RoomChatProvider? provider);

class RoomPage extends StatelessWidget {
  const RoomPage({
    Key? key,
    required this.aberchatConfig,
    this.child,
  }) : super(key: key);

  final AberchatConfig aberchatConfig;
  final CallbackRoomPage? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: RoomChatProvider()),
      ],
      child: RoomChatPage(
        aberchatConfig: aberchatConfig,
        child: child,
      ),
    );
  }
}

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({
    Key? key,
    required this.aberchatConfig,
    this.child,
  }) : super(key: key);

  final AberchatConfig aberchatConfig;
  final CallbackRoomPage? child;

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  RoomChatProvider? provider;

  void initChat() {
    provider = context.read<RoomChatProvider>();
    provider?.initSocket(widget.aberchatConfig);
  }

  @override
  void dispose() {
    super.dispose();
    provider?.dispose();
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
    return widget.child?.call(provider) ??
        Column(
          children: const [
            Expanded(
              child: RoomBodyPage(),
            ),
            RoomFooterPage()
          ],
        );
  }
}
