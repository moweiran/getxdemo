import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketDemoPage extends StatefulWidget {
  const SocketDemoPage({Key? key}) : super(key: key);

  @override
  State<SocketDemoPage> createState() => _SocketDemoPageState();
}

class _SocketDemoPageState extends State<SocketDemoPage> {
  final TextEditingController _controller = TextEditingController();
  late final IO.Socket _socket;

  @override
  void initState() {
    _socket = IO.io(
      'http://vama-api.hummingbirdstudio.live/chat',
      // 'http://localhost:8090/chat',
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    _socket.onConnect((_) {
      print('connect');
      _socket.emit('msg', 'test');
    });
    _socket.on('event', (data) => print(data));
    _socket.on('receivedMessage', (data) {
      print(data);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: data));
    });
    _socket.onDisconnect((_) => print('disconnect'));
    _socket.on('fromServer', (_) => print(_));
    _socket.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),

            TextButton(
              onPressed: () {
                _socket.emit('joinRoom', 'joinRoom');
              },
              child: Text('joinroom'),
            ),
            TextButton(
              onPressed: () {
                // _socket.emit('sendMessage', 'joinRoom');
                _socket.emit('SendMessageToChatRoom', {
                  'roomId': 'joinRoom',
                  'message': 'message',
                });
              },
              child: Text('send room message'),
            ),
            // StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //     print('socket==data==${snapshot.data}');
            //     print('socket==connectionState==${snapshot.connectionState}');
            //     print('socket==error==${snapshot.error}');
            //     print('socket==error==${snapshot.stackTrace}');
            //     return Text(snapshot.hasData ? '${snapshot.data}' : '');
            //   },
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // _channel.sink.add(_controller.text);
      _socket.emit('sendMessage', _controller.text);
      _controller.text = '';
      setState(() {});
    }
  }

  @override
  void dispose() {
    // _channel.sink.close();
    _controller.dispose();
    _socket.destroy();
    super.dispose();
  }
}
