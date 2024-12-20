import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketDemo extends StatefulWidget {
  // 1- يقوم العميل بالاتصال بالخادم
  final WebSocketChannel channel = IOWebSocketChannel.connect("wss://echo.websocket.org/");

  WebSocketDemo({super.key});
  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState(channel: channel);
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final WebSocketChannel channel;
  final inputController = TextEditingController();
  List<String> messageList = [];

  _WebSocketDemoState({required this.channel}){
    // 3- يعرض العميل الرسائل المستقبلة
    channel.stream.listen((data){
      setState(() {
        print(data);
        messageList.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: inputController,
                decoration: const InputDecoration(
                  labelText: 'send message',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 22),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      if(inputController.text.isNotEmpty){
                        //print(inputController.text);
                        //widget.channel.sink.add(inputController.text);
                        // setState(() {
                        //   messageList.add(inputController.text);
                        // });
                        // 2- يتم إرسال رسالة نصية إلى الخادم
                        channel.sink.add(inputController.text);
                        inputController.text = '';
                      }
                    }, child: const Text("send")),
              )
            ],
          ),
        ),
        Expanded(
          child:
            getMessageList(),
          // StreamBuilder(
          //   stream: widget.channel.stream,
          //   builder: (context, snapshot){
          //     if(snapshot.hasData){
          //       messageList.add(snapshot.data);
          //     }
          //     return getMessageList();
          //   },
          // )
        ),
      ],
    );
  }
  ListView getMessageList(){
    List<Widget> listWidget = [];
    for(String message in messageList){
      listWidget.add(ListTile(
        title: Container(
          color: Colors.cyan,
          height: 100,
          child: Padding(
            padding: const  EdgeInsets.all(8.0),
            child: Text(
              message,
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ),
      ));
    }
    return ListView(children: listWidget);
  }


  @override
  void dispose(){
    // 4- يغلق العميل الاتصال
    inputController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
