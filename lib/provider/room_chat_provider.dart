import 'package:aberchat/aberchat.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:uuid/uuid.dart';

class RoomChatProvider with ChangeNotifier {
  late AberchatConfig aberchatConfig;
  List<Chat> listChat = [];
  List<Chat> get listChatReverse => listChat.reversed.toList();
  String get senderId => aberchatConfig.userId;

  late io.Socket socket;
  final TextEditingController controller = TextEditingController();

  void initSocket(AberchatConfig aberchatConfig) {
    this.aberchatConfig = aberchatConfig;
    socket = io.io(aberchatConfig.url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': aberchatConfig.autoConnect,
    });
    _connectSocket();
  }

  void _onChatSend(dynamic data) {
    debugPrint('connect: ${socket.id}');
    if (aberchatConfig.triggerBoth) {
      aberchatConfig.onChatSend?.call(data);
    }
  }

  void _onChatRead(dynamic data) {
    debugPrint('connect: ${socket.id}');
    if (aberchatConfig.triggerBoth) {
      aberchatConfig.onChatRead?.call(data);
    }
  }

  void _onChatAlreadyRead(dynamic data) {
    debugPrint('connect: ${socket.id}');
    if (aberchatConfig.triggerBoth) {
      aberchatConfig.onChatAlreadyRead?.call(data);
    }
  }

  void _onChatJoined(dynamic data) {
    GlobalResponse globalResponse = GlobalResponse.fromJson(data);
    listChat.addAll(globalResponse.result?.chats ?? []);
    notifyListeners();
    if (aberchatConfig.triggerBoth) {
      aberchatConfig.onChatJoined?.call(data);
    }
    if (aberchatConfig.triggerBoth) {
      aberchatConfig.onChatJoinedData?.call(listChat);
    }
  }

  void _onChatReceive(dynamic data) {
    debugPrint("chat:receive: $data");
    GlobalResponse globalResponse = GlobalResponse.fromJson(data);
    debugPrint("chat:receive: ${globalResponse.result?.chat?.toJson() ?? {}}");
    Chat chat = globalResponse.result?.chat ?? Chat(message: "Data kosong");
    debugPrint("chat:receive: ${chat.toJson()}");
    listChat.add(chat);
    notifyListeners();
    if (aberchatConfig.triggerBoth) {
      aberchatConfig.onChatReceive?.call(data);
    }
    if (aberchatConfig.triggerBoth) {
      aberchatConfig.onChatReceiveData?.call(chat);
    }
  }

  void _onError(Object e) {
    debugPrint('aberchat:error >> $e');
  }

  void _connectSocket() async {
    try {
      socket.onConnectError((data) => debugPrint('aberchat:error: $data'));
      socket.onConnectTimeout((data) => debugPrint('aberchat:timeout: $data'));
      socket.onConnecting((data) => debugPrint('aberchat:connecting: $data'));
      socket.onConnect((data) => debugPrint('aberchat:connect >> $data'));
      socket.onDisconnect((data) => debugPrint('aberchat:disconnect >> $data'));
      socket.connect();
      final triggerBoth = aberchatConfig.triggerBoth;
      socket.on(
        "chat:send",
        triggerBoth == false
            ? (data) => aberchatConfig.onChatSend?.call(data)
            : _onChatSend,
      );
      socket.on(
        "chat:receive",
        triggerBoth == false
            ? (data) => aberchatConfig.onChatReceive?.call(data)
            : _onChatReceive,
      );
      socket.on(
        "chat:read",
        triggerBoth == false
            ? (data) => aberchatConfig.onChatRead?.call(data)
            : _onChatRead,
      );
      socket.on(
        "user:joined",
        triggerBoth == false
            ? (data) => aberchatConfig.onChatJoined?.call(data)
            : _onChatJoined,
      );
      socket.on(
        "chat:already:read",
        triggerBoth == false
            ? (data) => aberchatConfig.onChatAlreadyRead?.call(data)
            : _onChatAlreadyRead,
      );
    } catch (e) {
      _onError(e);
    }
  }

  void sendChat({
    TextEditingController? controller,
    String? text,
    Chat? customChat,
  }) async {
    final chat = Chat(
      message: text ?? controller?.text ?? this.controller.text,
      sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
      originalId: const Uuid().v4(),
    );
    socket.emit("chat:send", customChat?.chatRequest() ?? chat.chatRequest());
    controller?.clear();
    this.controller.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
    socket.dispose();
    socket.destroy();
  }
}
