import 'package:aberchat/aberchat.dart';
import 'package:flutter/material.dart';

class CustomChatRoom extends StatefulWidget {
  const CustomChatRoom({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<CustomChatRoom> createState() => _CustomChatRoomState();
}

class _CustomChatRoomState extends State<CustomChatRoom> {
  List<String> events = [];
  List<Chat> chats = [];
  List<Chat> get chatsData => chats.toList();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final aberchatConfig = AberchatConfig(
      appId: '631ae2ed3a4f071fd104365a',
      apiKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmFiMGNkYWItMDA3My00ZDY0LTg4OTItYjNlODg4YWMyYTJkIiwiaWF0IjoxNjYyNzA2NDEzLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0In0.0lBM1iZkfcdC5yXL3y5qnFYpwKvtT20-s0W2WsBe02w',
      roomId: 'demo-aberchat',
      onChatJoined: (data) {
        setState(() {
          events.add('Chat joined');
        });
      },
      onChatJoinedData: (data) {
        setState(() {
          chats.addAll(data);
        });
      },
      onChatReceiveData: (data) {
        setState(() {
          chats.insert(0, data);
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RoomPage(
        aberchatConfig: aberchatConfig,
        child: (provider) {
          return Column(
            children: [
              const Text('Custom UI'),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: chatsData.length,
                  itemBuilder: (context, index) {
                    final chat = chatsData[index];
                    if (chat.senderId == aberchatConfig.userId) {
                      return Row(
                        children: [
                          const Spacer(flex: 2),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(chat.message ?? ''),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              color: Colors.yellow,
                              child: SizedBox.square(
                                dimension: 40,
                                child: Center(
                                  child: Text(
                                      chat.senderId?.substring(0, 1) ?? ''),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            color: Colors.yellow,
                            child: SizedBox.square(
                              dimension: 40,
                              child: Center(
                                child:
                                    Text(chat.senderId?.substring(0, 1) ?? ''),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(chat.message ?? ''),
                            ],
                          ),
                        ),
                        const Spacer(flex: 2),
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Input your message",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      provider?.sendChat(text: controller.text);
                      controller.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your roomId: ${aberchatConfig.roomId}',
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your senderId: ${aberchatConfig.userId}',
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('List Event: '),
                    Expanded(
                      child: ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return Text(event);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
