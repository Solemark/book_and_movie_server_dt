import 'dart:io';

class Server {
  int port;
  String route, type;
  Server(this.port, this.route, this.type);

  void start() async {
    final Socket socket = await Socket.connect(this.route, this.port);
    socket.listen((msg) => print("$msg"), onDone: () => this.sendMessage(), onError: (e) => print("error: $e"));
  }

  void sendMessage() async {
    final Socket socket = await Socket.connect(this.route, 8000);
    socket.writeln("${this.type} saved");
    socket.destroy();
  }
}
