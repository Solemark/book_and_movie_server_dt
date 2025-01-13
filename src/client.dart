import 'package:http/http.dart';

void main() => Client();

class Client {
  Client() {
    this.send();
  }

  void send() async {
    final Uri url = Uri.http("localhost:8000", "/");

    Response res = await post(url, body: "B|name|price|quantity");
    print("${res.body}");

    res = await post(url, body: "M|name|price|quantity");
    print("${res.body}");
  }
}
