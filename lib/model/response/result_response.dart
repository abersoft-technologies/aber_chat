import 'package:aberchat/model/chat.dart';

class ResultResponse {
  ResultResponse({
    this.chat,
    this.chats,
  });

  ResultResponse.fromJson(dynamic json) {
    chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
    if (json['chats'] != null) {
      chats = [];
      json['chats'].forEach((v) {
        chats?.add(Chat.fromJson(v));
      });
      chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
    }
  }

  Chat? chat;
  List<Chat>? chats;

  ResultResponse copyWith({
    Chat? chat,
    List<Chat>? chats,
  }) =>
      ResultResponse(
        chat: chat ?? this.chat,
        chats: chats ?? this.chats,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (chat != null) {
      map['chat'] = chat?.toJson();
    }
    if (chats != null) {
      map['chats'] = chats?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
