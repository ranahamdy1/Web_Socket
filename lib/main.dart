import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("web socket"),
        ),
        body: WebSocketDemo(),
      ),
    );
  }
}

class WebSocketDemo extends StatefulWidget {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect(" https://echo.websocket.org/");
  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: inputController,
                      decoration: InputDecoration(
                        labelText: 'send message',
                        border: OutlineInputBorder(),
                      ),
                  style: TextStyle(fontSize: 22),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () {}, child: Text("send")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
