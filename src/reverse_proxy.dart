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
      Response res = await this.parseMessage(req);
      req.response.write(res.body);
      req.response.close();
    }
  }

  Future<Response> parseMessage(HttpRequest req) async {
    int port = 0;
    String msg = await utf8.decodeStream(req);
    print(msg);
    switch (msg[0]) {
      case 'B':
        port = 8001;
        break;
      case 'M':
        port = 8002;
        break;
      default:
        throw Exception("unknown message type");
    }
    var url = Uri.http("localhost:$port", "/");
    return post(url, body: msg);
  }
}
