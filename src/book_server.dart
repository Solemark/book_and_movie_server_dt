import 'server.dart';

void main() => BookServer();

class BookServer extends Server {
  BookServer([super.port = 8001, super.route = "127.0.0.1", super.type = "Book"]) {
    super.start();
  }
}
