import 'package:flutter/material.dart';
import 'package:flutter_aiml/flutter_aiml.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIML Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FlutterAiml aiml;

  TextEditingController inputController = TextEditingController();

  List<ChatMessages> messages = [];

  @override
  void initState() {
    aiml = FlutterAiml();
    aiml.invokeSetup();

    Future.delayed(const Duration(seconds: 2), () {
      requestResponse('Hi');
    });
    super.initState();
  }

  requestResponse(String prompt) {
    setState(() {
      messages.add(ChatMessages(message: prompt, isBot: false));
    });
    aiml.getResponse(message: prompt).then((value) {
      setState(() {
        messages.add(ChatMessages(message: value, isBot: true));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return ChatBubble(messages.reversed.toList()[index]);
                },
              )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: inputController,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()),
                  onSubmitted: (value) {
                    requestResponse(value);
                    inputController.clear();
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessages message;
  const ChatBubble(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft: message.isBot
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                    bottomRight: message.isBot
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                  ),
                  color: message.isBot ? Colors.blue : Colors.purple),
              child: Text(message.message)),
        ],
      ),
    );
  }
}

class ChatMessages {
  final String message;
  final bool isBot;
  ChatMessages({required this.message, required this.isBot});
}
