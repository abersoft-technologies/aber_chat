import 'package:aberchat/model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatItemWidget extends StatefulWidget {
  const ChatItemWidget({
    Key? key,
    required this.chat,
    required this.senderId,
  }) : super(key: key);

  final Chat chat;
  final String senderId;

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  @override
  Widget build(BuildContext context) {
    final chat = widget.chat;
    return Row(
      children: [
        if (chat.senderId == widget.senderId) const Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: chat.senderId == widget.senderId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (chat.type != 'gift')
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: chat.senderId == widget.senderId
                        ? Colors.blue
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // child: Text(chat.message ?? ''),
                  child: Text(chat.message ?? ''),
                ),
              if (chat.type == 'gift')
                CachedNetworkImage(
                  imageUrl: chat.message ?? '',
                  width: 150,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                ),
              Text(chat.sendAt
                      ?.split('T')[1]
                      .split(':')
                      .getRange(0, 2)
                      .join('.') ??
                  ''),
            ],
          ),
        ),
        if (chat.senderId != widget.senderId) const Spacer(flex: 1),
      ],
    );
  }
}
