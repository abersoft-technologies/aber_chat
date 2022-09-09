class Chat {
  Chat({
    this.id,
    this.message,
    this.url,
    this.type,
    this.sendAt,
    this.originalId,
    this.senderId,
  });

  Chat.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    url = json['url'];
    type = json['type'];
    sendAt = json['sendAt'];
    originalId = json['originalId'];
    senderId = json['senderId'];
  }

  String? id;
  String? message;
  String? url;
  String? type;
  String? sendAt;
  String? originalId;
  String? senderId;

  Chat copyWith({
    String? id,
    String? message,
    String? url,
    String? type,
    String? sendAt,
    String? originalId,
    String? senderId,
  }) =>
      Chat(
        id: id ?? this.id,
        message: message ?? this.message,
        url: url ?? this.url,
        type: type ?? this.type,
        sendAt: sendAt ?? this.sendAt,
        originalId: originalId ?? this.originalId,
        senderId: senderId ?? this.senderId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['url'] = url;
    map['type'] = type;
    map['sendAt'] = sendAt;
    map['originalId'] = originalId;
    map['senderId'] = senderId;
    return map;
  }

  Map<String, dynamic> chatRequest() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['url'] = url ?? '';
    map['type'] = type ?? 'text';
    map['sendAt'] = sendAt;
    map['originalId'] = originalId;
    return map;
  }
}
