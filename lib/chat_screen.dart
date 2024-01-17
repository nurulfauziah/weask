// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weask/components/chat_bubbles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController _chat = TextEditingController();
  List<Map<String, dynamic>> _chatHistory = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We Ask'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF030C1A),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - 70,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _chatHistory.length,
                  shrinkWrap: false,
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ChatBubbles(
                      isMe: _chatHistory[index]["isSender"],
                      message: _chatHistory[index]["message"],
                    );
                  },
                ),
              ),
              isLoading
                  ? Container(
                      alignment: Alignment.centerLeft,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Sedang mengetik...',
                        style: TextStyle(color: Colors.white),
                      ))
                  : Container()
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF030C1A),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 60,
                child: TextFormField(
                  controller: _chat,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Chat Here...",
                    hintStyle: const TextStyle(color: Colors.white),
                    isDense: false,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.white, width: 1, strokeAlign: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.white, width: 1, strokeAlign: 1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (_chat.text.isNotEmpty) {
                    _chatHistory.add({
                      "time": DateTime.now(),
                      "message": _chat.text,
                      "isSender": true,
                    });
                    _chat.clear();
                  }
                });
                _scrollController.jumpTo(
                  _scrollController.position.maxScrollExtent,
                );

                getAnswer();
              },
              child: Container(
                width: 50,
                child: const Icon(
                  Icons.send,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getAnswer() async {
    final url =
        "https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=<INSERT KEY HERE>";
    final uri = Uri.parse(url);
    List<Map<String, String>> msg = [];
    for (var i = 0; i < _chatHistory.length; i++) {
      msg.add({"content": _chatHistory[i]["message"]});
    }

    Map<String, dynamic> request = {
      "prompt": {
        "messages": [msg]
      },
      "temperature": 0.25,
      "candidateCount": 1,
      "topP": 1,
      "topK": 1
    };
    setState(() {
      isLoading = true;
    });
    final response = await http.post(uri, body: jsonEncode(request));
    setState(() {
      isLoading = false;
      _chatHistory.add({
        "time": DateTime.now(),
        "message": json.decode(response.body)["candidates"][0]["content"],
        "isSender": false,
      });
    });

    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }
}
