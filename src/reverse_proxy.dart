import 'dart:io';

void main() => ReverseProxy();

class ReverseProxy {
  int port;
  String route;
  late Socket socket;
  ReverseProxy([this.port = 8000, this.route = "127.0.0.1"]) {
    this.start();
  }

  void start() async {
    this.socket = await Socket.connect(this.route, this.port);
    this.socket.listen((msg) {
      // first char of msg should be B or M
      switch (msg.toString()[0]) {
        case "B":
          //send message
          this.sendMessage(msg.toString().substring(1), 8001);
          break;
        case "M":
          this.sendMessage(msg.toString().substring(1), 8002);
          //send message
          break;
        default:
          print("malformed message: $msg");
      }
    }, onDone: () => print("message sent"), onError: (e) => print("error: $e"));
  }

  void sendMessage(String msg, int port) async {
    Socket socket = await Socket.connect(this.route, port);
    socket.writeln(msg);
    // Wait for ACK from Server
    socket.listen((msg) {
      print("recieved message: ${msg.toString()}");
      // Send ACK to Client
      this.socket.writeln("${msg.toString()}");
    }, onDone: () => socket.destroy(), onError: (e) => print("error: $e"));
  }
}
