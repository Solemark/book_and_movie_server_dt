import 'dart:io';
import 'dart:convert' show utf8;
import 'package:http/http.dart';

void main() => ReverseProxy();

class ReverseProxy {
  int port;
  String route;
  ReverseProxy([this.route = "localhost", this.port = 8000]) {
    this.start();
  }

  void start() async {
    HttpServer server = await HttpServer.bind(this.route, this.port);
    print("listening on: ${server.address.host}:${server.port}");
    await for (HttpRequest req in server) {
      // recieve message from client
      String msg = await utf8.decodeStream(req);
      print(msg);
      // TODO -  is msg a book or movie?
      // send message to server
      var url = Uri.http("localhost:8001", "/");
      Response res = await post(url, body: msg);
      // send response to client
      req.response.write(res.body);
      //close request
      req.response.close();
    }
  }
}
