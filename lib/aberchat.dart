library aberchat;

export 'model/model.dart';
export 'widget/widget.dart';

typedef OnReceivedEvent = void Function(dynamic data);

class AberchatConfig {
  AberchatConfig({
    required this.appId,
    required this.apiKey,
    required this.roomId,
    this.userId = 'anonymous',
    this.autoConnect = false,
    this.triggerBoth = true,
    this.onChatAlreadyRead,
    this.onChatJoined,
    this.onChatRead,
    this.onChatReceive,
    this.onChatSend,
  });

  final String appId;
  final String apiKey;
  final String roomId;
  final String userId;
  final bool autoConnect;
  final bool triggerBoth;
  final OnReceivedEvent? onChatSend;
  final OnReceivedEvent? onChatReceive;
  final OnReceivedEvent? onChatRead;
  final OnReceivedEvent? onChatJoined;
  final OnReceivedEvent? onChatAlreadyRead;

  String get url {
    return 'http://chat.abersoft.se/$appId?apiKey=$apiKey&roomId=$roomId&userId=$userId';
  }
}
