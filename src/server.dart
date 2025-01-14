import 'dart:io';
import 'dart:convert' show utf8;

enum Type { Book, Movie }

class Server {
  int port;
  String route;
  Type type;
  Server(this.route, this.port, this.type) {
    this.start();
  }

  void start() async {
    HttpServer server = await HttpServer.bind(this.route, this.port);
    print("listening on: ${server.address.host}:${server.port}");
    await for (HttpRequest req in server) {
      String msg = await utf8.decodeStream(req);
      print(msg);
      req.response.write("${this.type.name.toLowerCase()} recieved");
      req.response.close();
    }
  }
}
