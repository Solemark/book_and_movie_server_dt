import 'dart:io';
import 'server.dart';

void main() => ReverseProxy();

class ReverseProxy extends Server {
  ReverseProxy([super.port = 8000, super.route = "127.0.0.1", super.type = ""]) {
    this.start();
  }

  @override
  void start() async {
    Socket socket = await Socket.connect(this.route, this.port);
    socket.listen((msg) {
      // first char of msg should be B or M
      switch (msg.toString()[0]) {
        case "B":
          //send message
          this.sendAndRecieve(msg.toString().substring(1), 8001);
          break;
        case "M":
          this.sendAndRecieve(msg.toString().substring(1), 8002);
          //send message
          break;
        default:
          print("malformed message: $msg");
          break;
      }
    }, onDone: () => print("message sent"), onError: (e) => print("error: $e"));
  }

  void sendAndRecieve(String msg, int port) async {
    Socket socket = await Socket.connect(this.route, port);
    socket.writeln(msg);
    // Wait for ACK from Server
    socket.listen((msg) {
      print("message recieved: ${msg.toString()}");
      // Send ACK to Client
      socket.writeln("${msg.toString()}");
    }, onDone: () => socket.destroy(), onError: (e) => print("error: $e"));
  }
}
