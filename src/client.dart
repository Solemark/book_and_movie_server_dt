import 'dart:io';

void main() => Client();

class Client {
  final String client_prompt = """
  **************************************
  Place your order by selecting a number
  **************************************
  1. Purchase book
  2. Perchase movie
  Press any other key to exit""";
  String route;
  int port;
  Client([this.route = "127.0.0.1", this.port = 8000]) {
    while (true) {
      print(this.client_prompt);
      String msg = "";
      switch (stdin.readLineSync() ?? "") {
        case "1":
          msg = "B${this.getDetails("book")}";
          break;
        case "2":
          msg = "M${this.getDetails("movie")}";
          break;
        default:
          exit(0);
      }
      this.sendMessage(msg);
    }
  }

  String getDetails(String type) {
    String output = "";
    print("Enter $type details:\nEnter name: ");
    output += "${stdin.readLineSync},";
    print("Enter quantity: ");
    output += "${stdin.readLineSync},";
    print("Enter price: ");
    output += "${stdin.readLineSync}";
    return output;
  }

  void sendMessage(String msg) async {
    // Send message
    final Socket socket = await Socket.connect(this.route, this.port);
    socket.writeln(msg);
    // Wait for ACK
    socket.listen((res) {
      print("recieved: ${res.toString()}");
    }, onDone: () {
      print("Acknowledgement recieved, closing socket!");
      socket.destroy();
    }, onError: (e) {
      print("Error: $e\n closing socket!");
      socket.destroy();
    });
  }
}
