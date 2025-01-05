import 'dart:io';

void main() => BookServer();

class BookServer {
  int port;
  String route;
  late Socket socket;
  BookServer([this.port = 8001, this.route = "127.0.0.1"]) {
    this.start();
  }

  void start() async {
    this.socket = await Socket.connect(this.route, this.port);
    this
        .socket
        .listen((msg) => print("${msg.toString()}"), onDone: () => print("done!"), onError: (e) => print("error: $e"));
  }

  void sendMessage() async {
    Socket socket = await Socket.connect(this.route, 8000);
    socket.writeln("Book successfully saved");
    socket.destroy();
  }
}
