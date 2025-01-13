import 'dart:io';
import 'dart:convert' show utf8;

void main() => BookServer();

class BookServer {
  int port;
  String route;
  BookServer([this.route = "localhost", this.port = 8001]) {
    this.start();
  }

  void start() async {
    HttpServer server = await HttpServer.bind(this.route, this.port);
    print("listening on: ${server.address.host}:${server.port}");
    await for (HttpRequest req in server) {
      String msg = await utf8.decodeStream(req);
      print(msg);
      req.response.write("book recieved");
      req.response.close();
    }
  }
}
